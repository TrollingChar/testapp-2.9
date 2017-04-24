package w3;

/**
 * ...
 * @author
 */

class PlayerColors {
    public static var RED:Int = 0;
    public static var BLUE:Int = 1;
    public static var GREEN:Int = 2;
    public static var PURPLE:Int = 3;
    public static var YELLOW:Int = 4;
    public static var BLACK:Int = 5;

    public static var text:Array<Int> = [
        0xff3300,
        0x55aaff,
        0x66cc00,
        0xaa55ff,
        0xffff00,
        0x666666
    ];
    public static var glow:Array<Int> = [
        0xcc0000,
        0x0055aa,
        0x336600,
        0x660099,
        0xaaaa00,
        0x222222
    ];
}
/*
class PlayerColors {
    public static var RED:Int        = 0xff3300;
    public static var REDGLOW:Int    = 0xcc0000;
    public static var BLUE:Int       = 0x55aaff;
    public static var BLUEGLOW:Int   = 0x0055aa;
    public static var GREEN:Int      = 0x66cc00;
    public static var GREENGLOW:Int  = 0x336600;
    public static var PURPLE:Int     = 0xaa55ff;
    public static var PURPLEGLOW:Int = 0x660099;
    public static var YELLOW:Int     = 0xffff00;
    public static var YELLOWGLOW:Int = 0xaaaa00;
    public static var BLACK:Int      = 0x666666;
    public static var BLACKGLOW:Int  = 0x222222;

    public static function genRandColors(players:Int):Array<Int> {
        var colors:Array<Int> = Util.makeArray(1, players);
        var result:List<Int> = [0];
    }

    public static function getColorById(id:Int) {

    }

    public static function getGlowColorById(id:Int) {

    }
}
*/
