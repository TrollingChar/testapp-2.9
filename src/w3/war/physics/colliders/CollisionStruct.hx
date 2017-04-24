package w3.war.physics.colliders;
import w3.war.physics.objects.Object;
import w3.war.physics.primitives.*;

/**
 * ...
 * @author
 */
class CollisionStruct {                       // functions should return null when no collision found

    public var offset:Pt2;              // offset before collision
    public var normal:Pt2;              // normal vector
    public var c1:Collider;             // colliders
    public var c2:Collider;             // can get object from collider
    public var pr1:Primitive;           // collided primitives
    public var pr2:Primitive;

    public function new(offset:Pt2,
                        normal:Pt2,
                        c1:Collider,
                        c2:Collider,
                        pr1:Primitive,
                        pr2:Primitive) {
        this.offset = offset;
        this.normal = normal;
        this.c1 = c1;
        this.c2 = c2;
        this.pr1 = pr1;
        this.pr2 = pr2;
    }

}
