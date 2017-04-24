package w3.war.physics.primitives;

class PrCircle extends Primitive {
    public var center:Pt2;
    public var radius:Float;

    public function new(c:Pt2, r:Float = 0) {
        center = c;
        radius = r;
    }

    // less the number, closer the object are to each other
    public override function locate(other:Primitive, offset:Pt2):Float {
        return other.locateCircle(this, -offset);
    }

    override function locateCircle(other:PrCircle, offset:Pt2):Float {
        return (center - other.center).length2 - (radius + other.radius)*(radius + other.radius);
    }

}
