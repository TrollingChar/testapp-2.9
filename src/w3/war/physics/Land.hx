package w3.war.physics;
import haxe.ds.*;
import openfl.display.*;
import w3.*;
import w3.war.physics.colliders.*;
import w3.war.physics.primitives.*;

class Land {
    public var bmd:BitmapData;
    public var tiles:Array<Array<LandTile>>;
    public var w:Int;
    public var h:Int;
    public var wTiles:Int;
    public var hTiles:Int;

    public var tangBounce:Float;
    public var normBounce:Float;

    public var pixels:Array<Array<Bool>>;

    public function new(bmd:BitmapData, tangBounce:Float = 0.9, normBounce:Float = 0.5) {
        this.bmd = bmd;
        w = bmd.width;
        h = bmd.height;
        wTiles = Math.ceil(w / LandTile.size);
        hTiles = Math.ceil(h / LandTile.size);

        this.tangBounce = tangBounce;
        this.normBounce = normBounce;

        pixels = [for (x in 0...w) [for (y in 0...h) bmd.getPixel32(x, y) & 0xFF000000 != 0]];
        //tiles = [for (x in 0...wTiles) [for (y in 0...hTiles) new LandTile(x, y, this)]];
    }

    public function at(x:Int, y:Int):Bool {
        if (y < 0 || y >= h || x < 0 || x >= w) return false;
        return pixels[x][y];// bmd.getPixel32(x, y) >>> 24 != 0;
    }

    public function tile(x:Int, y:Int):LandTile {
        if (x < 0 || y < 0 || x >= wTiles || y >= hTiles) return new LandTile(x, y);
        return tiles[x][y];
        /*if (tiles.exists(x))
            if (tiles.get(x).exists(y))
                return tiles.get(x).get(y);
        return new LandTile(x, y);*/
    }

    /*public function writeTile(tile:LandTile) {
        var x:Int = tile.x,
            y:Int = tile.y;
        if (!tiles.exists(x)) tiles.set(x, new IntMap<LandTile>());
        if (!tiles.get(x).exists(y)) tiles.get(x).set(y, tile);
    }*/


    public function castRay(beg:Pt2, end:Pt2, width:Float = 0):Collision {
        var
        bp:Pt2,
        ep:Pt2,
        offset:Pt2 = null,
        normal:Pt2 = null,
        pr:Primitive = null,

        dist:Float = 1;

        try {
            // луч проходит вправо, пересекая вертикали
            if (beg.x < end.x) {
                bp = beg + new Pt2(width, 0);
                ep = end + new Pt2(width, 0);
                //ep = bp * (1 - dist) + (end + new Pt2(width, 0)) * dist;
                var x:Int = Math.ceil(Math.max(0, bp.x)), eCol:Int = Math.ceil(Math.min(w, ep.x)); while (x < eCol) {
                    ++Combat.world.debugL;

                    var d:Float = (x - bp.x) / (ep.x - bp.x);
                    var y:Int = Math.floor(bp.y * (1 - d) + ep.y * d);
                    if (at(x, y)) {
                        if(d < 1) {
                            dist = d;
                            normal = new Pt2(-1, 0);
                            pr = new PrVertical(x, true);
                        }
                        break;
                    }
                ++x; }
            }
        } catch (e:Dynamic) {
            Main.log("right");
        }

        try {
            // луч проходит влево, пересекая вертикали
            if (beg.x > end.x) {
                bp = beg - new Pt2(width, 0);
                ep = end - new Pt2(width, 0);
                //ep = bp * (1 - dist) + (end - new Pt2(width, 0)) * dist;
                var x:Int = Math.floor(Math.min(w, bp.x)), eCol:Int = Math.floor(Math.max(0, ep.x)); while (x > eCol) {
                    ++Combat.world.debugL;

                    var d:Float = (x - bp.x) / (ep.x - bp.x);
                    var y:Int = Math.floor(bp.y * (1 - d) + ep.y * d);
                    if (at(x-1, y)) {
                        if(d < 1) {
                            dist = d;
                            normal = new Pt2(1, 0);
                            pr = new PrVertical(x, false);
                        }
                        break;
                    }
                --x; }
            }
        } catch (e:Dynamic) {
            Main.log("left");
        }

        try {
            // луч падает вниз, пересекая горизонтали
            if (beg.y < end.y) {
                bp = beg + new Pt2(0, width);
                ep = bp * (1 - dist) + (end + new Pt2(0, width)) * dist;
                //ep = bp * (1 - dist) + (end + new Pt2(0, width)) * dist;
                var y:Int = Math.ceil(Math.max(0, bp.y)), eRow:Int = Math.ceil(Math.min(h, ep.y)); while (y < eRow) {
                    ++Combat.world.debugL;

                    var d:Float = (y - bp.y) / (ep.y - bp.y);
                    var x:Int = Math.floor(bp.x * (1 - d) + ep.x * d);
                    if (at(x, y)) {
                        if(d < 1) {
                            dist *= d;
                            normal = new Pt2(0, -1);
                            pr = new PrHorizontal(y, true);
                        }
                        break;
                    }
                ++y; }
            }
        } catch (e:Dynamic) {
            Main.log("down");
        }

        try {
            // луч проходит вверх, пересекая горизонтали
            if (beg.y > end.y) {
                bp = beg - new Pt2(0, width);
                ep = bp * (1 - dist) + (end - new Pt2(0, width)) * dist;
                //ep = bp * (1 - dist) + (end - new Pt2(0, width)) * dist;
                var y:Int = Math.floor(Math.min(h, bp.y)), eRow:Int = Math.floor(Math.max(0, ep.y)); while (y > eRow) {
                    ++Combat.world.debugL;

                    var d:Float = (y - bp.y) / (ep.y - bp.y);
                    var x:Int = Math.floor(bp.x * (1 - d) + ep.x * d);
                    if (at(x, y-1)) {
                        if(d < 1) {
                            dist *= d;
                            normal = new Pt2(0, 1);
                            pr = new PrHorizontal(y, false);
                        }
                        break;
                    }
                --y; }
            }
        } catch (e:Dynamic) {
            Main.log("up");
        }

        try {
            // и теперь обойти вершины в тайлах.
            bp = beg;
            ep = beg * (1 - dist) + end * dist;
            var
            bCol:Int = Math.floor(Math.max(0,      Math.min((bp.x - width) / LandTile.size, (ep.x - width) / LandTile.size))),
            eCol:Int = Math.ceil (Math.min(wTiles, Math.max((bp.x + width) / LandTile.size, (ep.x + width) / LandTile.size))),
            bRow:Int = Math.floor(Math.max(0,      Math.min((bp.y - width) / LandTile.size, (ep.y - width) / LandTile.size))),
            eRow:Int = Math.ceil (Math.min(hTiles, Math.max((bp.y + width) / LandTile.size, (ep.y + width) / LandTile.size)));
            var x:Int = bCol; while(x < eCol) {
                var y:Int = bRow; while (y < eRow) {
                    for (v in tile(x, y).vertices) {
                        ++Combat.world.debugL;

                        var d:Float = Geom.castRayToCircle(beg, end - beg, v, width);
                        if(d < dist) {
                            dist = d;
                            normal = beg*(1-d) + end*d - v;
                            pr = new PrCircle(v);
                        }
                    }
                ++y; }
            ++x; }
        } catch (e:Dynamic) {
            Main.log("points");
        }

        try {
            return dist < 1 ? new Collision((end-beg)*dist, normal, null, null, new PrCircle(beg, width), pr) : null;
        } catch (e:Dynamic) {
            Main.log("return");
            return null;
        }
    }

    public function recalc() {
        tiles = [for (x in 0...wTiles) [for (y in 0...hTiles) new LandTile(x, y, this)]];
    }
/*
    public function makeHole(center:Pt2, radius:Float) {
        // change bitmapdata
        for(x) {
            for(y) {
                if(tile(x, y).land > 0) tile(x, y).recalc();
            }
        }
    }
*/
}
