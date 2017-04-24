package w3.war;
import haxe.ds.IntMap;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.display.Stage;
import openfl.events.MouseEvent;
import w3.net.Connection;
import w3.war.TurnData;
import w3.war.physics.LandTile;
import w3.war.physics.World;
import w3.war.physics.WorldTile;
import w3.war.players.Player;
import w3.war.players.PlayerQueueController;
import w3.war.state.GameState;
import w3.war.state.GameStateController;
import w3.war.view.Layers;
import openfl.events.Event;

/**
 * ...
 * @author
 */
class Combat {
    public static var active:Bool = false;
    public static var state:GameStateController;
    public static var players:PlayerQueueController;
    public static var layers:Layers;
    public static var world:World;

    static public var paused(get, never):Bool;
    static function get_paused():Bool {
        return Main.panelDebug.shown;
    }

    static public function receiveStartBattle(players:IntMap<Player>) {
        state = new GameStateController();
        Combat.players = new PlayerQueueController(players);
        var sky:BitmapData = Assets.getBitmapData("img/sky.png");
        var land:BitmapData = Assets.getBitmapData("img/tiled-map.png");
        layers = new Layers(sky, land);
        world = new World(land);
        Main.worldPlaceholder.addChild(layers);

        Main.panelMain.hide();
        Main.panelBottom.show();
        Main.panelCenterText.show();
        active = true;
    }

    public static function onTimer(stage:Stage) {
        if (!active) return;
        if (paused) return;

        Main.td.x = stage.mouseX + layers.camera.currentView.x - stage.stageWidth / 2;
        Main.td.y = stage.mouseY + layers.camera.currentView.y - stage.stageHeight / 2;

        if(state.synchronized) {
            if(players.myTurn) {
                if (state.currentState == GameState.TURN) {
                    Connection.sendTD(Main.td);
                } else {
                    Main.log("WRONG TIME TO SEND DATA");
                }
                update(Main.td);
            } else {
                Connection.readData();
                if (Connection.td == null) {
                    layers.update();
                } else {
                    update(Connection.td);
                }
            }
        } else {
            update();
        }
    }

    static function update(td:TurnData = null) {
        // if called with null, it means that no player is active
        // if something is still trying to use td, we catch null exception
        world.update(td); // physics
        state.update(); // timer
        layers.update(); // camera
    }

    //static function updateOnlyGfx() {
        //layers.update();
    //}

    static public function receiveTD(td:TurnData) {

    }

    static public function receiveHisTurn(id:Int) {
        players.receiveHisTurn(id);
        state.startTurn(id);
    }

    static public function receivePlayerLeft(id:Int) {
        players.receivePlayerLeft(id);
    }

    static public function onRightMouseUp(stage:Stage) {
        layers.camera.reset();
    }

    static public function onRightMouseDown(stage:Stage) {
        layers.camera.setManual(stage);
    }

    static public function wait(milliseconds:Int = 500) {
        state.wait(milliseconds);
    }
}
