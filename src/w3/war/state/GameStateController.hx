package w3.war.state;
import w3.net.Connection;
import w3.war.physics.objects.Worm;
import w3.war.players.Player;
import w3.war.state.GameState;

/**
 * ...
 * @author
 */
class GameStateController {
    static var turnTime:Int = 45000;
    static var retreatTime:Int = 3000;

    public var synchronized:Bool;
    public var currentState:GameState;
    var nextState:GameState;

    var wormFrozen:Bool;
    var activeWorm:Worm;

    @:isVar public var timer(get, set):Int;
    @:isVar public var timerVisible(get, set):Bool;

    public function new() {
        currentState = GameState.AFTER_TURN;
        nextState = GameState.REMOVE_0HP;
        timer = 500;
        wormFrozen = true;
        activeWorm = null;
    }

    public function update() {
        timer -= 20;
        if (timer <= 0) changeState();
        //switch (currentState) {
            //case GameState.BEFORE_TURN:
                //Main.panelCenterText.text = "BEFORE TURN";
            //case GameState.SYNCHRONIZING:
                //Main.panelCenterText.text = "SYNCHRONIZING";
            //case GameState.TURN:
                //Main.panelCenterText.text = Combat.players.myTurn ? "MY TURN" : "TURN";
            //case GameState.ENDING_TURN:
                //Main.panelCenterText.text = "ENDING TURN";
            //case GameState.AFTER_TURN:
                //Main.panelCenterText.text = "AFTER TURN";
            //case GameState.REMOVE_0HP:
                //Main.panelCenterText.text = "REMOVE 0 HP";
        //}
        //Main.panelCenterText.text += " " + Std.string(timer);
    }

    public function changeState() {
        enterState(nextState);
    }

    public function enterState(state:GameState) {
        currentState = state;
        switch (state) {
            case GameState.BEFORE_TURN: {
                //Main.panelCenterText.text = "BEFORE TURN";
                nextState = GameState.SYNCHRONIZING;
                if (Random.genrand_int32() % 2 == 0) {
                    // drop crates
                    timer = 500;
                } else {
                    changeState();
                }
            }
            case GameState.SYNCHRONIZING: {
                //Main.panelCenterText.text = "SYNCHRONIZING";
                nextState = GameState.TURN;
                synchronized = true;
                Connection.sendSynchronize(true);
            }
            case GameState.TURN: {
                //Main.panelCenterText.text = Combat.players.myTurn ? "MY TURN" : "TURN";
                nextState = GameState.ENDING_TURN;
                wormFrozen = false;
                var player:Player = Combat.players.activePlayer;
                activeWorm = player.nextWorm();
                timer = turnTime;
                timerVisible = true;
            }
            case GameState.ENDING_TURN: {
                //Main.panelCenterText.text = "ENDING TURN";
                nextState = GameState.AFTER_TURN;
                Connection.immediateResponse =
                wormFrozen = true;
                synchronized = false;
                activeWorm = null;
                Combat.players.resetActivePlayer();
                timer = 500;
                timerVisible = false;
            }
            case GameState.AFTER_TURN: {
                //Main.panelCenterText.text = "AFTER TURN";
                nextState = GameState.REMOVE_0HP;
                if (Random.genrand_int32() % 2 == 0) {
                    // poison damage
                    timer = 500;
                } else {
                    changeState();
                }
            }
            case GameState.REMOVE_0HP: {
                //Main.panelCenterText.text = "REMOVE 0 HP";
                if (Random.genrand_int32() % 5 == 5) {   // never happens
                    // hitpointless worms begin exploding
                    nextState = GameState.REMOVE_0HP;
                    timer = 500;
                } else {
                    nextState = GameState.BEFORE_TURN;
                    changeState();
                }
            }
            //default:
        }
    }

    public function get_timer():Int {
        return timer;
    }

    public function set_timer(value:Int):Int {
        var i:Int = value > 0 ? Std.int((value + 999) / 1000) : 0;
        if (timerVisible) Main.panelBottom.leftIcon.text = Std.string(i);
        return timer = value;
    }

    public function get_timerVisible():Bool {
        return timerVisible;
    }

    public function set_timerVisible(value:Bool):Bool {
        Main.panelBottom.leftIcon.text = value ? (timer > 0 ? Std.string(Std.int((timer + 999) / 1000)) : "0") : "";
        return timerVisible = value;
    }

    public function startTurn(id:Int) {
        changeState();
    }

    public function wait(milliseconds:Int) {
        if (currentState != TURN && timer < milliseconds) timer = milliseconds;
    }

}
