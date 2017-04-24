package w3.war.physics.colliders;
import w3.Pt2;
import w3.war.physics.colliders.CollisionStruct;
import w3.war.physics.primitives.PrCircle;
import w3.war.physics.primitives.PrHorizontal;
import w3.war.physics.primitives.PrVertical;

/**
 * ...
 * @author
 */
class CCircle extends Collider {
    @:isVar public var center(get, set):Pt2;
    public var radius:Float;

    public function new(center:Pt2, radius:Float, tangBounce:Float = 0.9, normBounce:Float = 0.5) {
        super(tangBounce, normBounce);
        this.center = center;
        this.radius = radius;
    }

    public override function collideWith(other:Collider, v:Pt2):Collision {
        if(v.x == 0 && v.y == 0) return null;
        return -other.collideWithCircle(this, -v);
    }

    public override function collideWithLL() {
        //if (LL.xa == 0 && LL.ya == 0) LL.cd = null;
        //else LL.

        //return -other.collideWithCircle(this, -v);
    }

    public override function collideWithTiles(land:Land, v:Pt2):Collision {
        return null;
    }

    public override function collideWithLand(land:Land, v:Pt2):Collision {
        var c:Collision = land.castRay(center, center + v, radius);
        if(c != null) c.c1 = this;
        return c;
        //var hDist:Float = 1,
            //vDist:Float = 1;
        //if (v.x > 0) {
            //var p:Pt2 = new Pt2(center.x + radius, center.y);
            //hDist = land.castRay(p, p + v);
        //}
    }

    public override function collideWithCircle(other:CCircle, v:Pt2):Collision {
        //Main.log("OBJECT #" + Std.string(object.hashCode()) + " REPORTING");
        var mv:Float = Geom.castRayToCircle(center, v, other.center, radius + other.radius);
        //Main.log("RETURNED " + Std.string(mv));
        var c:Collision;
        //if (mv >= 1) c = null;
        if (mv < 0) mv = 0;
        if (1 > mv) c = new Collision(v * mv,
                                      center + v * mv - other.center,
                                      this,
                                      other,
                                      new PrCircle(center, radius),
                                      new PrCircle(other.center, other.radius));
        else c = null;

        //Main.log(Collision.string(c));
        //Main.log("");
        return c;
    }

    public override function collideWithRectangle(other:CRectangle, v:Pt2):Collision {
        return null;
        //// стороны
        //if(v.x != 0) {
            //var mv:Float = Geom.castRayToVertical(center, v, v.x > 0 ? other.tl.x : other.br.x, radius),
                //y:Float = center.y + v.y * mv;
            //if(y > other.tl.y && y < other.br.y)
                //return new Collision(mv, object, other.object, new PrCircle(center, radius), new PrVertical(v.x > 0 ? other.tl.x : other.br.x, v.x > 0));
        //}
        //if(v.y != 0) {
            //var mv:Float = Geom.castRayToHorizontal(center, v, v.y > 0 ? other.tl.y : other.br.y, radius),
                //x:Float = center.x + v.x * mv;
            //if(x > other.tl.x && x < other.br.x)
                //return new Collision(mv, object, other.object, new PrCircle(center, radius), new PrHorizontal(v.y > 0 ? other.tl.y : other.br.y, v.y > 0));
        //}
        //
        //// вершины
        //var min:Float = 1,
            //cp:CollisionStruct = null;
        //if(v.x > 0 || v.y > 0) { // top left
            //var mv:Float = Geom.castRayToCircle(center, v, other.tl, radius);
            //if(mv < min) {
                //min = mv;
                //cp = new Collision(mv, object, other.object, new PrCircle(center, radius), new PrCircle(other.tl));
            //}
        //}
        //if(v.x < 0 || v.y > 0) { // top right
            //var tr:Pt2 = new Pt2(other.br.x, other.tl.y),
                //mv:Float = Geom.castRayToCircle(center, v, tr, radius);
            //if(mv < min) {
                //min = mv;
                //cp = new Collision(mv, object, other.object, new PrCircle(center, radius), new PrCircle(tr));
            //}
        //}
        //if(v.x > 0 || v.y < 0) { // bottom left
            //var bl:Pt2 = new Pt2(other.tl.x, other.br.y),
                //mv:Float = Geom.castRayToCircle(center, v, bl, radius);
            //if(mv < min) {
                //min = mv;
                //cp = new Collision(mv, object, other.object, new PrCircle(center, radius), new PrCircle(bl));
            //}
        //}
        //if(v.x < 0 || v.y < 0) { // bottom right
            //var mv:Float = Geom.castRayToCircle(center, v, other.br, radius);
            //if(mv < min) {
                //min = mv;
                //cp = new Collision(mv, object, other.object, new PrCircle(center, radius), new PrCircle(other.br));
            //}
        //}
        //return cp;
    }

    public override function collideWithPolygon(other:CPolygon, v:Pt2):Collision {
        return null;
    }

    function get_center():Pt2 {
        return center + object.position;
    }

    function set_center(value:Pt2):Pt2 {
        return center = value;
    }

    override public function get_aabb():AABB {
        var c:Pt2 = center;
        return new AABB(c.x - radius, c.y - radius, c.x + radius, c.y + radius);
    }
}
