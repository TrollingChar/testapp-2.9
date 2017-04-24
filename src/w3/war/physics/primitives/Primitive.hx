package w3.war.physics.primitives;
import w3.war.physics.primitives.Primitive;

class Primitive {

    public function locate(other:Primitive, offset:Pt2):Float {
        if(Std.is(other, PrCircle)) return locateCircle(cast(other, PrCircle), offset);
        return 0;
    }

    function locateCircle(other:PrCircle, offset:Pt2):Float {
        return 0;
    }

}
