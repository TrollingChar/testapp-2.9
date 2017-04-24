package w3.war.physics.primitives;

class PrHorizontal extends Primitive {
    public var y:Float;
    public var isTop:Bool;

    public function new(y:Float, isTop:Bool) {
        this.y = y;
        this.isTop = isTop;
    }
/*
    @:override
    public function locate(other:Primitive) {
        //if(Std.is(other, PrHorizontal)) return locateHorizontal(other);
        if(Std.is(other, PrCircle)) return locateCircle(other);
        return 0;
    }
*/
    override function locateCircle(other:PrCircle, offset:Pt2):Float {
        return (isTop ? y - other.center.y : other.center.y - y) - other.radius;
    }

    function locateHorizontal(other:PrHorizontal, offset:Pt2):Float {
        if(isTop == other.isTop) return 0;
        return isTop ? y - other.y : other.y - y;
    }

}
