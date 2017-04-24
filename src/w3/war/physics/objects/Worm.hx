package w3.war.physics.objects;
import w3.ui.Label;
import w3.war.physics.colliders.CCircle;
import w3.war.physics.colliders.CRectangle;
import w3.war.physics.colliders.Collider;
import w3.war.players.Player;

/**
 * ...
 * @author
 */
class Worm extends Object {
    public static inline var SIZE:Float = 5;
    public static inline var SPEED:Float = 1;

    public var player:Player;
    public var hp:Int;

    public var nameLabel:Label;
    public var hpLabel:Label;

    public function new() {
        super();
    }

    function setupColliders() {
        addCollider(new CCircle(new Pt2(), SIZE));
        addCollider(new CCircle(new Pt2(0, SIZE), SIZE));
        addCollider(new CRectangle(-SIZE, 0, SIZE, SIZE));
    }

    function setupGraphics() {

    }

    public function onAddToTeam() {

    }

}
