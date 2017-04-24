package w3.war.physics.colliders;

/**
 * ...
 * @author
 */
class CRectangle extends Collider {
    @:isVar public var left(get, set)  :Float;
    @:isVar public var top(get, set)   :Float;
    @:isVar public var right(get, set) :Float;
    @:isVar public var bottom(get, set):Float;
    public var tl:Pt2;
    public var br:Pt2;

    public function new(left:Float, top:Float, right:Float, bottom:Float, tangBounce:Float = 0.9, normBounce:Float = 0.5) {
        super(tangBounce, normBounce);
        this.left = left;
        this.top = top;
        this.right = right;
        this.bottom = bottom;
    }


    public override function collideWith(other:Collider, v:Pt2):Collision{
        if(v.x == 0 && v.y == 0) return null;
        return -other.collideWithRectangle(this, -v);
    }

    public override function collideWithTiles(land:Land, v:Pt2):Collision{
        return null;
    }

    public override function collideWithLand(land:Land, v:Pt2):Collision{
        return null;
    }

    public override function collideWithCircle(other:CCircle, v:Pt2):Collision{
        return null;
    }

    public override function collideWithRectangle(other:CRectangle, v:Pt2):Collision{
        return null;
    }

    public override function collideWithPolygon(other:CPolygon, v:Pt2):Collision{
        return null;
    }

    function get_bottom():Float {
        return bottom;
    }

    function set_bottom(value:Float):Float {
        return bottom = value;
    }

    function get_right():Float {
        return right;
    }

    function set_right(value:Float):Float {
        return right = value;
    }

    function get_top():Float {
        return top;
    }

    function set_top(value:Float):Float {
        return top = value;
    }

    function get_left():Float {
        return left;
    }

    function set_left(value:Float):Float {
        return left = value;
    }
}
