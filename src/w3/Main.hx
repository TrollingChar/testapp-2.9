package w3;

import haxe.CallStack;
import haxe.ds.IntMap;
import openfl.display.*;
import openfl.events.*;
import openfl.ui.*;
import w3.ui.*;
import w3.war.Combat;
import w3.war.physics.colliders.Collision;
import w3.war.players.Player;
import w3.war.TurnData;
//import w3.war.World;

/**
 * ...
 * @author
 */
class Main extends Sprite {
    public static var panelBackground:PanelBackground;
    public static var panelDebug:PanelDebug;
    public static var panelMain:PanelMainMenu;
    public static var panelConnect:PanelConnect;
    public static var panelCancel:PanelCancel;
    public static var panelHelp:PanelHelp;
    public static var panelTop:PanelTop;
    public static var panelBottom:PanelBottom;
    public static var panelCenterText:PanelCenterText;

    public static var worldPlaceholder:Sprite;
    public static var td:TurnData;
    static public var myId:Int;

    static var logList:List<String>;

    public function new() {
        super();
        try {
            logList = new List<String>();
            panelDebug = new PanelDebug();
            // чтобы не было падения при попытке вести логи



            Random.init(7675);

            panelBackground = new PanelBackground();
            addChild(panelBackground);
            panelBackground.show();

            worldPlaceholder = new Sprite();
            addChild(worldPlaceholder);

            panelMain = new PanelMainMenu();
            addChild(panelMain);

            panelCancel = new PanelCancel();
            addChild(panelCancel);

            panelHelp = new PanelHelp();
            addChild(panelHelp);

            panelConnect = new PanelConnect();
            addChild(panelConnect);
            panelConnect.show();

            panelTop = new PanelTop();
            addChild(panelTop);
            panelTop.show();

            panelCenterText = new PanelCenterText();
            addChild(panelCenterText);
            //panelCenterText.show();
            //panelCenterText.text = "TEST";

            panelBottom = new PanelBottom();
            addChild(panelBottom);
            addChild(panelDebug);

            td = new TurnData(0, 0);

            stage.addEventListener(KeyboardEvent.KEY_DOWN, stage_keyDown);
            stage.addEventListener(KeyboardEvent.KEY_UP, stage_keyUp);
            stage.addEventListener(MouseEvent.MOUSE_DOWN, stage_mouseDown);
            stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUp);
            stage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, stage_rightMouseDown);
            stage.addEventListener(MouseEvent.RIGHT_MOUSE_UP, stage_rightMouseUp);
            stage.addEventListener(Event.ENTER_FRAME, stage_enterFrame);

        } catch (err:Dynamic) {
            log(err);
        }
    }



    function stage_enterFrame(e:Event):Void {
        try {
            Combat.onTimer(stage);
        } catch (err:Dynamic) {
            log("TIMER: "+Std.string(err));
        }
    }



    function stage_rightMouseUp(e:MouseEvent):Void {
        try {
            Combat.onRightMouseUp(stage);
        } catch (err:Dynamic) {
            log(err);
        }
    }



    function stage_rightMouseDown(e:MouseEvent):Void {
        try {
            Combat.onRightMouseDown(stage);
        } catch (err:Dynamic) {
            log(err);
        }
    }



    function stage_mouseUp(e:MouseEvent):Void {
        try {
            td.flags &= ~TurnData.mb;
        } catch (err:Dynamic) {
            log(err);
        }
    }



    function stage_mouseDown(e:MouseEvent):Void {
        try {
            td.flags |= TurnData.mb;
        } catch (err:Dynamic) {
            log(err);
        }
    }



    @:deprecated
    static public function log(msg:Dynamic// = "CHECKPOINT"
                                          ) {
        //logList.add(Std.string(msg));
        //if (logList.length > 38) logList.pop();
//
        //panelDebug.label.text = "";
        //for (s in logList) {
            //panelDebug.label.text += s + "\n";
        //}

        panelDebug.label.text += Std.string(msg) + "\n";
    }



    @:deprecated
    static public function centerText(msg:Dynamic// = "CHECKPOINT"
                                                 ) {
        panelCenterText.text = Std.string(msg);
    }



    function stage_keyDown(e:KeyboardEvent):Void {
        try {
            switch(e.keyCode) {
                case Keyboard.BACKQUOTE: panelDebug.toggle();
                case Keyboard.W: td.flags |= TurnData.w;
                case Keyboard.A: td.flags |= TurnData.a;
                case Keyboard.S: td.flags |= TurnData.s;
                case Keyboard.D: td.flags |= TurnData.d;
                case Keyboard.E: td.flags |= TurnData.e;
            }
        } catch (err:Dynamic) {
            log(err);
        }
    }



    function stage_keyUp(e:KeyboardEvent):Void {
        try {
            switch(e.keyCode) {
                case Keyboard.W: td.flags &= ~TurnData.w;
                case Keyboard.A: td.flags &= ~TurnData.a;
                case Keyboard.S: td.flags &= ~TurnData.s;
                case Keyboard.D: td.flags &= ~TurnData.d;
                case Keyboard.E: td.flags &= ~TurnData.e;
            }
        } catch (err:Dynamic) {
            log(err);
        }
    }



    static public function receiveAuthConfirm(id:Int) {
        myId = id;
        panelConnect.hide();
        panelMain.show();
    }



    static public function receiveCancel() {
        panelCancel.hide();
        panelMain.show();
    }



    static public function receiveEndBattle(decodeFromString:Int) {

    }



    static public function receivePlayerLeft(id:Int) {
        Combat.receivePlayerLeft(id);
    }



    static public function receiveHisTurn(id:Int) {
        Combat.receiveHisTurn(id);
    }



    static public function receiveTD(td:TurnData) {
        Combat.receiveTD(td);
    }



    static public function receiveStartBattle(players:IntMap<Player>, rndSeed:Int) {
        panelCancel.hide();
        panelMain.show();
        Random.init(rndSeed);
        Combat.receiveStartBattle(players);
    }

}
