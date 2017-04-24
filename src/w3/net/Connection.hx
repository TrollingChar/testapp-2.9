package w3.net;
import haxe.ds.IntMap;
import openfl.events.*;
import openfl.net.*;
import w3.war.players.Player;
import w3.war.TurnData;

/**
 * ...
 * @author
 */
class Connection {
    static var socket:Socket;
    static var host:String;
    static var port:Int;
    static public var connected:Bool;
    static public var immediateResponse:Bool;
    static var id:Int;
    static public var td:TurnData;


    public static function init(host:String, port:Int) {
        Connection.host = host;
        Connection.port = port;
        connected = false;
        immediateResponse = true;
        socket = new Socket();
        socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
        socket.addEventListener(IOErrorEvent.IO_ERROR, onError);
        socket.addEventListener(ErrorEvent.ERROR, onError);
        socket.addEventListener(Event.CONNECT, onConnect);
        socket.addEventListener(Event.CLOSE, onClose);
        socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
    }



    public static function connect(id:Int) {
        Connection.id = id;
        socket.connect(host, port);
    }



    public static function close() {
        connected = false;
        socket.close();
    }



    static public function send(s:String) {
        //Main.log("Me: " + s);
        socket.writeUTF(s);
        socket.flush();
    }



    static function onConnect(e:Event) {
        connected = true;
        sendAuth();
    }



    static function onClose(e:Event) {
        connected = false;
    }



    static function onError(e:Event) {
        if (!connected) {
            connect(id);
        }
    }



    public static function onSocketData(e:ProgressEvent) {
        var b:Bool = true;
        while (immediateResponse && b) b = readData();
    }



    public static function readData():Bool {
        try {
            td = null;
            if (socket.bytesAvailable > 0) {
                var s:String = socket.readUTF();
                //Main.log("Server: " + s);

                var cmd:Int = Base64Codec.Decode(s.charAt(0));
                s = s.substring(1);

                switch (cmd) {
                    case ServerCommands.AUTH_CONFIRM:
                        receiveAuthConfirm();
                    case ServerCommands.START_BATTLE:
                        receiveStartBattle(s);
                    case ServerCommands.CANCEL:
                        receiveCancel();
                    case ServerCommands.HIS_TURN:
                        receiveHisTurn(s);
                    case ServerCommands.TURN_DATA:
                        receiveTD(s);
                    case ServerCommands.PLAYER_LEFT:
                        receivePlayerLeft(s);
                    case ServerCommands.END_BATTLE:
                        receiveEndBattle(s);
                    default:
                        Main.log("INVALID SERVER COMMAND");
                }
                return true;
            }
            return false;
        } catch (e:Dynamic) {
            //Main.I.world.paused = true;
            Main.log(e);
            return false;
        }
    }



    static function sendAuth() {
        send(Base64Codec.EncodeToChar(ClientCommands.AUTHORIZE) + Base64Codec.Encode(id));
    }



    public static function sendPing() {
        send("");
    }



    public static function sendToBattle() {
        send(Base64Codec.EncodeToChar(ClientCommands.TO_BATTLE));
    }



    public static function sendCancel() {
        send(Base64Codec.EncodeToChar(ClientCommands.CANCEL));
    }



    public static function sendTD(td:TurnData) {
        send(Base64Codec.EncodeToChar(ClientCommands.TURN_DATA) + td.toString());
    }



    public static function sendSynchronize(alive:Bool) {
        send(Base64Codec.EncodeToChar(ClientCommands.SYNCHRONIZE));// + (alive ? "" : "-"));
    }



    public static function sendRepeat(msgId:Int) {
        send(Base64Codec.EncodeToChar(ClientCommands.REPEAT) + Base64Codec.Encode(msgId));
    }



    static function receiveAuthConfirm() {
        Main.receiveAuthConfirm(id);
    }



    static function receiveCancel() {
        Main.receiveCancel();
    }



    static function receiveStartBattle(s:String) {
        var i:Int = Base64Codec.Decode(s.charAt(0));
        var players:IntMap<Player> = new IntMap<Player>();
        Base64Codec.s = s.substring(1);
        for (j in 0...i) {
            var id:Int = Base64Codec.DecodeFromString();
            players.set(id, new Player(id));
        }
        Main.receiveStartBattle(players, Base64Codec.DecodeFromString());
    }



    static function receiveEndBattle(s:String) {
        Base64Codec.s = s;
        Main.receiveEndBattle(Base64Codec.DecodeFromString());
    }



    static function receivePlayerLeft(s:String) {
        Base64Codec.s = s;
        Main.receivePlayerLeft(Base64Codec.DecodeFromString());
    }



    static function receiveTD(s:String) {
        td = TurnData.parse(s);
        Main.receiveTD(td);
    }



    static function receiveHisTurn(s:String) {
        Base64Codec.s = s;
        Main.receiveHisTurn(Base64Codec.DecodeFromString());
        immediateResponse = false;
    }

}
