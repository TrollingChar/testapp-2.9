package w3.war.physics.colliders;
import w3.Pt2;
import w3.war.physics.primitives.Primitive;

/**
 * ...
 * @author
 */
abstract Collision(CollisionStruct) {

    public var offset(get, set):Pt2;
    public var normal(get, set):Pt2;
    public var c1(get, set):Collider;
    public var c2(get, set):Collider;
    public var pr1(get, set):Primitive;
    public var pr2(get, set):Primitive;

    public function new(offset:Pt2, normal:Pt2,
                        c1:Collider, c2:Collider,
                        pr1:Primitive, pr2:Primitive) {
        this = new CollisionStruct(offset, normal, c1, c2, pr1, pr2);
    }

    static public function string(c:Collision):String {
        if (c == null) return "[null]";
        return "[" + Pt2.string(c.offset) + "; " + Pt2.string(c.normal) + "]";
    }

    @:op( -A) static public function neg(a:Collision):Collision {
        if (a == null) return null;
        return new Collision(-a.offset, -a.normal, a.c2, a.c1, a.pr2, a.pr1);
    }

    @:op(A == B) static public function eq(a:Collision, b:Collision):Bool {
        if (a == null) return b == null;
        if (b == null) return false;
        return a.offset == b.offset;
    }

    @:op(A != B) static public function ne(a:Collision, b:Collision):Bool {
        return !(a == b);
    }

    @:op(A < B) static public function lt(a:Collision, b:Collision):Bool {
        if (a == null) return false;
        if (b == null) return true;
        return a.offset.length2 < b.offset.length2;
    }

    @:op(A > B) static public function gt(a:Collision, b:Collision):Bool {
        return b < a;
    }

    @:op(A <= B) static public function lte(a:Collision, b:Collision):Bool {
        return !(a > b);
    }

    @:op(A >= B) static public function gte(a:Collision, b:Collision):Bool {
        return !(a < b);
    }

    function get_offset():Pt2 { return this.offset; }
    function get_normal():Pt2 { return this.normal; }
    function get_c1():Collider { return this.c1; }
    function get_c2():Collider { return this.c2; }
    function get_pr1():Primitive { return this.pr1; }
    function get_pr2():Primitive { return this.pr2; }

    function set_offset(value:Pt2):Pt2 { return this.offset = value; }
    function set_normal(value:Pt2):Pt2 { return this.normal = value; }
    function set_c1(value:Collider):Collider { return this.c1 = value; }
    function set_c2(value:Collider):Collider { return this.c2 = value; }
    function set_pr1(value:Primitive):Primitive { return this.pr1 = value; }
    function set_pr2(value:Primitive):Primitive { return this.pr2 = value; }
}