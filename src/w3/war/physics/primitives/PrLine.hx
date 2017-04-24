package w3.war.physics.primitives;

class PrLine extends Primitive {
    public var a:Pt2, b:Pt2;

    @:override
    function locateCircle(other:PrCircle) {
        var ln:Pt2 = b - a;
        var skew:Float = skewProd(ln, other.center - a);
        return skew * Math.abs(skew) / ln.length2 - radius;
    }

}
