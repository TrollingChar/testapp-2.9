package w3.war.physics;

class AABB {
    public var left:Float;
    public var top:Float;
    public var right:Float;
    public var bottom:Float;

    public function new(left:Float,
                        top:Float,
                        right:Float,
                        bottom:Float) {
        this.left = left;
        this.top = top;
        this.right = right;
        this.bottom = bottom;
    }

    public function expand(v:Pt2):AABB {
        var result:AABB = new AABB(left, top, right, bottom);
        if(v.x < 0) result.left += v.x;
        if(v.y < 0) result.top += v.y;
        if(v.x > 0) result.right += v.x;
        if(v.y > 0) result.bottom += v.y;
        return result;
    }

    public function toTiles(tileSize:Float):AABB {
        return new AABB(Math.floor(left / tileSize),
                        Math.floor(top / tileSize),
                        Math.floor(right / tileSize) + 1,
                        Math.floor(bottom / tileSize) + 1);
    }
}
