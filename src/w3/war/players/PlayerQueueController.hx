package w3.war.players;
import haxe.ds.IntMap;
import w3.net.Connection;

/**
 * ...
 * @author
 */
class PlayerQueueController {

    public var players:IntMap<Player>;
    public var activePlayerId:Int;
    public var activePlayer(get, never):Player;
    public var myTurn(get, never):Bool;

    public function new(players:IntMap<Player>) {
        this.players = players;
    }

    public function receiveHisTurn(player:Int) {
        activePlayerId = player;
    }

    public function receivePlayerLeft(player:Int) {

    }

    public function resetActivePlayer() {
        activePlayerId = 0;
    }

    function get_activePlayer():Player {
        return players.get(activePlayerId);
    }

    function get_myTurn():Bool {
        return activePlayerId == Main.myId;
    }

}