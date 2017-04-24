package w3.war.physics;
import haxe.ds.HashMap;
import w3.Pt2;
import w3.war.physics.colliders.Collider;
import w3.war.physics.colliders.Collision;
import w3.war.physics.objects.Object;

/**
 * ...
 * @author
 */
class LL {
    public static var oa:Object;    // colliding object (this)
    public static var ob:Object;    // colliding object (other)
    public static var oc:Object;    //
    public static var od:Object;    //

    public static var xa:Float;     // object velocity
    public static var xb:Float;
    public static var xc:Float;
    public static var xd:Float;
    public static var ya:Float;
    public static var yb:Float;
    public static var yc:Float;
    public static var yd:Float;

    public static var ca:Collider; // collider (this)
    public static var cb:Collider; // collider (other)
    public static var cc:Collider;
    public static var cd:Collider;
}