package w3;

import openfl.geom.Point;
import w3.war.Combat;
import w3.war.physics.World;

/**
 * ...
 * @author
 */
abstract Pt2(Point) from Point to Point
{
    public var x(get, set):Float;
    public var y(get, set):Float;

    public var length(get, set):Float;
    public var length2(get, never):Float;
    public var angle(get, set):Float;

    public function new(x:Float = 0, y:Float = 0) {
        if(Combat.active) ++Combat.world.debugP;
        this = new Point(x, y);
    }

    public function copy():Pt2 {
        return new Pt2(x, y);
    }

    static public function string(p:Pt2):String {
        if (p == null) return "(nowhere)";
        return "(" + Std.string(p.x) + ", " + Std.string(p.y) + ")";
        //var reg:Int;
        //return "(" + Std.string((reg = Math.round(p.x * 10)) / 10) + "." + Std.string(reg % 10) + "; "
                   //+ Std.string((reg = Math.round(p.y * 10)) / 10) + "." + Std.string(reg % 10) + ") ";
    }

    @:op(A + B) static public function add(a:Pt2, b:Pt2):Pt2 {
        return new Pt2(a.x+b.x, a.y+b.y);
    }

    @:op(A - B) static public function sub(a:Pt2, b:Pt2):Pt2 {
        return new Pt2(a.x-b.x, a.y-b.y);
    }
/*
    @:op(A = B) public function wr(b:Pt2):Pt2 {
        x = b.x;
        y = b.y;
        return this;
    }
*/
    @:op(A += B) public function addwr(b:Pt2):Pt2 {
        x += b.x;
        y += b.y;
        return this;
    }

    @:op(A -= B) public function subwr(b:Pt2):Pt2 {
        x -= b.x;
        y -= b.y;
        return this;
    }

    @:op(-A) static public function neg(a:Pt2):Pt2 {
        return new Pt2(-a.x, -a.y);
    }

    @:op(A * B) @:commutative static public function mul(a:Pt2, b:Float):Pt2 {
        return new Pt2(a.x * b, a.y * b);
    }

    @:op(A / B) static public function div(a:Pt2, b:Float):Pt2 {
        return new Pt2(a.x / b, a.y / b);
    }

    @:op(A *= B) public function mulwr(b:Float):Pt2 {
        x *= b;
        y *= b;
        return this;
    }

    @:op(A /= B) public function divwr(b:Float):Pt2 {
        x /= b;
        y /= b;
        return this;
    }

    @:op(A == B) static public function eq(a:Pt2, b:Pt2):Bool {
        return a.x == b.x && a.y == b.y;
    }

    @:op(A != B) static public function ne(a:Pt2, b:Pt2):Bool {
        return a.x != b.x || a.y != b.y;
    }

    static public function fromPolar(length:Float, angle:Float = 0):Pt2 {
        var p:Pt2 = new Pt2(length, 0);
        return p.rotate(angle);
    }

    // а по ссылке мы не сравниваем
    // никогда

    public function rotate(ang:Float):Pt2 {
        var si:Float = Math.sin(ang),
            co:Float = Math.cos(ang);
        return new Pt2(co*x - si*y, si*x + co*y);
    }

    public function rotateFwd():Pt2 {
        return new Pt2(-y, x);
    }

    public function rotateBwd():Pt2 {
        return new Pt2(y, -x);
    }

    function get_x():Float { return this.x; }
    function get_y():Float { return this.y; }
    function set_x(value:Float):Float { return this.x = value; }
    function set_y(value:Float):Float { return this.y = value; }

    function get_length():Float { return Math.sqrt(length2); }
    function get_length2():Float { return x * x + y * y; }

    function set_length(value:Float):Float {
        var l:Float = length;
        if (l == 0) {
            y = -value;
        } else {
            l = value / l;
            x *= l; y *= l;
        }
        return value;
    }

    function get_angle():Float { return Math.atan2(y, x); }
    function set_angle(value:Float):Float {
        var l:Float = length;
        x = l*Math.cos(value);
        y = l*Math.sin(value);
        return value;
    }

}
