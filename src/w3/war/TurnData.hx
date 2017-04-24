package w3.war;
import haxe.crypto.Base64;
import haxe.io.Bytes;

/**
 * ...
 * @author
 */
class TurnData
{
    public static inline var w:Int = 0x1;
    public static inline var a:Int = 0x2;
    public static inline var s:Int = 0x4;
    public static inline var d:Int = 0x8;
    public static inline var e:Int = 0x10;
    public static inline var mb:Int = 0x20;     // mouse button
    public static inline var rmb:Int = 0x40;    // right mouse button

    public var flags:Int;
    public var x:Float;
    public var y:Float;

    public function new(x:Float, y:Float, flags = 0) {
        this.x = x;
        this.y = y;
        this.flags = flags;
    }

    public function toString() : String {
        var b:Bytes = Bytes.alloc(16);
        b.setDouble(0, x);
        b.setDouble(8, y);
        return Base64Codec.Encode(flags) + Base64.encode(b);
    }

    public static function parse(str : String) : TurnData {
        Base64Codec.s = str;
        var flags:Int = Base64Codec.DecodeFromString();
        var s:String = Base64Codec.s;
        s = s.substring(0, s.length - 1);
        var b:Bytes = Base64.decode(s);
        var x:Float = b.getDouble(0);
        var y:Float = b.getDouble(8);
        return new TurnData(x, y, flags);
    }

    public static function string(td:TurnData) {
        if (td == null) return "NULL";
        var reg:Int;
        return "(" + Std.string((reg = Math.round(td.x * 10)) / 10) + "." + Std.string(reg % 10) + "; "
                   + Std.string((reg = Math.round(td.y * 10)) / 10) + "." + Std.string(reg % 10) + ") "
                   + (td.flags & w == 0 ? "w" : "W")
                   + (td.flags & a == 0 ? "a" : "A")
                   + (td.flags & s == 0 ? "s" : "S")
                   + (td.flags & d == 0 ? "d" : "D")
                   + (td.flags & e == 0 ? "e" : "E")
                   + (td.flags & mb == 0 ? "0" : "1")
                   ;
    }

}
