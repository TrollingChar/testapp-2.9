package w3.war.physics;
import w3.war.physics.colliders.Collider;

class WorldTile {
    public static inline var size:Int = 20;
    public var x:Int;
    public var y:Int;
    var _colliders:List<Collider>;
    public var colliders(get, set):List<Collider>;

    public function new(x:Int, y:Int) {
        this.x = x;
        this.y = y;
        _colliders = null; // for emptiness check
    }

    public function addCollider(collider:Collider) {
        if (_colliders == null) {
            _colliders = new List<Collider>();
            Combat.world.writeTile(this);
        }
        _colliders.add(collider);
    }

    public function removeCollider(collider:Collider) {
        _colliders.remove(collider);
    }

    function get_colliders():List<Collider> {
        return _colliders == null ? new List<Collider>() : _colliders;
    }

    function set_colliders(value:List<Collider>):List<Collider> {
        return _colliders = value;
    }
}
