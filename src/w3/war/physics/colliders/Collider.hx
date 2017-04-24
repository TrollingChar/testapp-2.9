package w3.war.physics.colliders;
import haxe.ds.HashMap;
import w3.Pt2;
import w3.war.physics.AABB;
import w3.war.physics.World;
import w3.war.physics.WorldTile;
import w3.war.physics.WorldTile;
import w3.war.physics.WorldTile;
import w3.war.physics.WorldTile;
import w3.war.physics.WorldTile;
import w3.war.physics.WorldTile;
import w3.war.physics.colliders.CCircle;
import w3.war.physics.objects.Object;

/**
 * ...
 * @author
 */
class Collider {
    static var nextId:Int = 0;
    var id:Int;

    public var object:Object;
    var tiles:List<WorldTile>;
    public var aabb(get, never):AABB;

    public var tangBounce:Float;
    public var normBounce:Float;

    public function new(tangBounce:Float = 0.5, normBounce:Float = 0.9) {
        id = nextId++;

        this.tangBounce = tangBounce;
        this.normBounce = normBounce;

        tiles = new List<WorldTile>();
    }

    public function hashCode():Int {
        return id;
    }

    public function freeTiles() {
        for (tile in tiles) tile.removeCollider(this);
        tiles.clear();
    }

    public function occupyTiles() {
        var box:AABB = aabb.toTiles(WorldTile.size);

        for (x in Math.floor(box.left)...Math.floor(box.right)) {
            for (y in Math.floor(box.top)...Math.floor(box.bottom)) {
                var tile:WorldTile = object.world.tile(x, y);
                tile.addCollider(this);
                tiles.add(tile);
            }
        }

        //Main.log(tiles.length);
    }

    public function update() {
        freeTiles();
        occupyTiles();
    }

    public function findOverlapping(w:World, v:Pt2 = null):HashMap<Collider, Collider> {
        var box:AABB = v == null ? aabb : aabb.expand(v),
            result:HashMap<Collider, Collider> = new HashMap<Collider, Collider>();
        box = box.toTiles(WorldTile.size);

        for (x in Math.floor(box.left)...Math.floor(box.right)) {
            for (y in Math.floor(box.top)...Math.floor(box.bottom)) {
                for (c in object.world.tile(x, y).colliders) {
                    if(overlapsWith(c)) result.set(c, c);
                }
            }
        }
        return result;
    }

    public function findObstacles(world:World, v:Pt2 = null) {
        var box:AABB = v == null ? aabb : aabb.expand(v),
            result:HashMap<Collider, Collider> = new HashMap<Collider, Collider>();
        box = //new AABB(0, 0, 2000 / 20, 1000 / 20);
              box.toTiles(WorldTile.size);

        for (x in Math.floor(box.left)...Math.floor(box.right)) {
            for (y in Math.floor(box.top)...Math.floor(box.bottom)) {
                for (c in object.world.tile(x, y).colliders) {
                    result.set(c, c);
                }
            }
        }
        return result;

    }

    public function collideWith(other:Collider, v:Pt2):Collision {
        Main.log("COLLIDING NOT IMPLEMENTED");
        return null;
    }

    public function collideWithLL() {
        Main.log("LOW LEVEL COLLIDING NOT IMPLEMENTED");
        return null;
    }

    public function collideWithTiles(land:Land, v:Pt2):Collision {
        Main.log("COLLIDING NOT IMPLEMENTED");
        return null;
    }

    public function collideWithLand(land:Land, v:Pt2):Collision {
        Main.log("COLLIDING NOT IMPLEMENTED");
        return null;
    }

    public function collideWithLandLL() {
        Main.log("LOW LEVEL COLLIDING NOT IMPLEMENTED");
        return null;
    }

    public function collideWithCircle(other:CCircle, v:Pt2):Collision {
        Main.log("COLLIDING NOT IMPLEMENTED");
        return null;
    }

    public function collideWithRectangle(other:CRectangle, v:Pt2):Collision {
        Main.log("COLLIDING NOT IMPLEMENTED");
        return null;
    }

    public function collideWithPolygon(other:CPolygon, v:Pt2):Collision {
        Main.log("COLLIDING NOT IMPLEMENTED");
        return null;
    }

    public function overlapsWith(other:Collider):Bool {
        return false;
    }

    public function overlapsWithTiles(land:Land, v:Pt2):Bool  {
        return false;
    }

    public function overlapsWithLand(land:Land, v:Pt2):Bool {
        return false;
    }

    public function overlapsWithCircle(other:CCircle, v:Pt2):Bool {
        return false;
    }

    public function overlapsWithRectangle(other:CRectangle, v:Pt2):Bool {
        return false;
    }

    public function overlapsWithPolygon(other:CPolygon, v:Pt2):Bool {
        return false;
    }

    public function get_aabb():AABB {
        Main.log("get AABB from empty collider");
        return null;
    }
}
/*
    public function markTiles() {
        // сначала посчитать затронутые тайлы
        var leftTile:Int = Math.ceil(getLeft() / Tile.size) - 1;
        var	topTile:Int = Math.ceil(getTop() / Tile.size) - 1;
        var	rightTile:Int = Math.ceil(getRight() / Tile.size);
        var	bottomTile:Int = Math.ceil(getBottom() / Tile.size);

        // затем в каждый записать наш коллайдер
        for (x in leftTile...rightTile+1)
        {
            for (y in topTile...bottomTile+1)
            {
                var tile:Tile = Main.I.world.getTileAt(x, y);
                tile.addCollider(this);
                tiles.add(tile);
            }
        }
    }

    public function freeTiles() {
        for (tile in tiles) tile.removeCollider(this);
        tiles.clear();
    }

    @:deprecated
    public function passableFor(collider:Collider) {
        // ну хотя бы так:
        return collider.object != null;

        // объекты не сталкиваются сами с собой
        return collider.object == object;
    }

    public function getTop() : Float
    {
        return object.position.y;
    }

    public function getLeft() : Float
    {
        return object.position.x;
    }

    public function getBottom() : Float
    {
        return object.position.y;
    }

    public function getRight() : Float
    {
        return object.position.x;
    }

}
*/
