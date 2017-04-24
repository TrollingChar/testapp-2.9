package w3.war.physics.primitives;

class PrVertical extends Primitive {
    public var x:Float;
    public var isLeft:Bool;

    public function new(x:Float, isLeft:Bool) {
        this.x = x;
        this.isLeft = isLeft;
    }
/*
    @:override
    public function locate(other:Primitive):Float {
        //if(Std.is(other, PrVertical)) return locateVertical(other);
        if(Std.is(other, PrCircle)) return locateCircle(other);
        return 0;
    }
*/
    override function locateCircle(other:PrCircle, offset:Pt2):Float {
        return (isLeft ? x - other.center.x : other.center.x - x) - other.radius;
    }

    function locateVertical(other:PrVertical, offset:Pt2):Float {
        if(isLeft == other.isLeft) return 0;
        return isLeft ? x - other.x : other.x - x;
    }

}
