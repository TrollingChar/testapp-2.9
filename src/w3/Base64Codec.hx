package w3;
import haxe.ds.HashMap;

/**
 * ...
 * @author
 */
class Base64Codec
{
    static var initialized:Bool = false;
    public static var array:String;
    static public var s:String;
    //static var map:Object;
    static var map:Map<String, Int>;

    static public function Init(str:String = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz./")
    {
        array = str;
        map = new Map<String, Int>();
        for (i in 0...str.length) {
            map[array.charAt(i)] = i;
        }
        initialized = true;
    }

    static public function EncodeToChar(n:Int):String
    {
        if (!initialized) Init();
        return (n & ~63) == 0 ? array.charAt(n) : '?';
    }

    static public function Encode(n:Int):String
    {
        if (!initialized) Init();
        var s:String;
        s = "=";
        while (n != 0)
        {
            s = EncodeToChar(n & 63) + s;
            n >>= 6;
        }
        return s;
    }

    static public function Decode(c:String):Int
    {
        if (!initialized) Init();
        return map[c];
    }

    static public function DecodeFromString():Int
    {
        if (!initialized) Init();
        //var str:String = s;
        var sum:Int = 0;
        for (i in 0...s.length){
            if (s.charAt(i) != "="){
                sum = sum * 64 + Decode(s.charAt(i));
            }
            else{
                s = s.substring(i+1);
                return sum;
            }
        }

        return -1;
    }
}