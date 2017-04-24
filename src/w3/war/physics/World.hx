package w3.war.physics;
import haxe.ds.HashMap;
import haxe.ds.IntMap;
import openfl.display.BitmapData;
import w3.Pt2;
import w3.war.physics.World;
import w3.war.physics.colliders.Collision;
import w3.war.physics.colliders.CollisionStruct;
import w3.war.physics.objects.Ball;
import w3.war.physics.objects.Object;

/**
 * ...
 * @author
 */
class World {
    public var debugL:Int;
    public var debugO:Int;
    public var debugP:Int;

    public var land:Land;
    public var objects:List<Object>;
    public var waterLevel:Float;
    public var gravity:Float = 0.5;
    public var tiles:IntMap<IntMap<WorldTile>>;

    public function new(bmd:BitmapData) {
        land = new Land(bmd);
        land.recalc();
        objects = new List<Object>();
        waterLevel = 1000;
        tiles = new IntMap<IntMap<WorldTile>>();
    }

    public function tile(x:Int, y:Int):WorldTile {
        if (tiles.exists(x))
            if (tiles.get(x).exists(y))
                return tiles.get(x).get(y);
        return new WorldTile(x, y);
    }

    public function writeTile(tile:WorldTile) {
        var x:Int = tile.x,
            y:Int = tile.y;
        if (!tiles.exists(x)) tiles.set(x, new IntMap<WorldTile>());
        tiles.get(x).set(y, tile);
    }

/**************************************************************************************************
 * physics                                                                                        *
 **************************************************************************************************
 *                                                                                                *
 * 1 assign to each object number 1.0, their movement value                                       *
 * 2 predict where each object will collide with tiles with land > 0                              *
 * 3 move each object by small small distance, detecting collisions between them                  *
 * 4 distance passed by object is divided by velocity and subtracted from movement value          *
 * 5 objects collide with other objects which movement = 0                                        *
 * 6 collisions with land are recalculated after collision                                        *
 * 7 when object is close to tile with 0 < land < 400 they are also recalculated                  *
 * 8 on last iteration all collision are detected as if movement = 0                              *
 *                                                                                                *
 * ??????                                                                                         *
 *                                                                                                *
 * PROFIT                                                                                         *
 *                                                                                                *
 * Recalculate approximate collision with land when:                                              *
 *   Algorithm starts                                                                             *
 *   Object changes its velocity                                                                  *
 * Recalculate precise collision with land when:                                                  *
 *   Object reaches point of approximate collision                                                *
 *   Approximate collision not applicable                                                         *
 * Detect collision when:                                                                         *
 *   Object reaches point of precise collision                                                    *
 *   Object flies into other impassable object                                                    *
 *                                                                                                *
 * Objects can not change their velocity too many times                                           *
 *                                                                                                *
 *                                                                                                *
 **************************************************************************************************/

    public function cutSpeed(v:Pt2):Pt2 {
        v = v.copy();
        var len:Float = v.length;
        len -= 0.01;
        if (len < 0) return new Pt2();
        v.length = len;
        return v;
    }

    public function update(td:TurnData) {
        try {
            //Main.panelCenterText.text = TurnData.string(td);
            //Main.centerText(objects.length);

            // add object
            if (Combat.state.timer % 100 == 0 && td != null && (td.flags & TurnData.mb != 0)) {
                for (i in 0...3) {
                    var b:Ball = new Ball(10);
                    b.position = new Pt2(td.x, td.y);
                    addObject(b);
                }
            }

            //Main.centerText(objects.length);
            debugL = debugO = debugP = 0;

            for (obj in objects) obj.controller.update();

            for (obj in objects) {
                obj.movement = 1;// (obj.velocity.x == 0 && obj.velocity.y == 0) ? 0 : 1;
                // TODO: clear it properly
                obj.excluded = new HashMap<Object, Object>();
                obj.excludeObjects();
            }

            var iter:Int = 5;
            for (i in 0...iter) {
                for (obj in objects) {
                    if (obj.movement * obj.velocity.length <= 0.01) continue;

                    var c:Collision = obj.nextCollision();
                    if(c == null) {
                        obj.position += obj.velocity * obj.movement * 0.99;
                        obj.movement = 0;
                    } else if(c.c2 == null) {
                        obj.position += cutSpeed(c.offset);
                        obj.movement -= Math.sqrt(c.offset.length2 / obj.velocity.length2);
                        obj.velocity = Geom.bounce(obj.velocity, c.normal, Math.sqrt(c.c1.tangBounce * land.tangBounce), Math.sqrt(c.c1.normBounce * land.normBounce));
                    } else if (i > iter - 3) { // не трогайте это магическое число!
                        obj.position += cutSpeed(c.offset);
                        obj.movement -= Math.sqrt(c.offset.length2 / obj.velocity.length2);
                        obj.velocity = Geom.bounce(obj.velocity, c.normal, Math.sqrt(c.c1.tangBounce * c.c2.tangBounce), Math.sqrt(c.c1.normBounce * c.c2.normBounce));
                    } else {
                        obj.position += cutSpeed(c.offset);
                        obj.movement -= Math.sqrt(c.offset.length2 / obj.velocity.length2);

                        // найти скалярное произведение нормали столкновения и скорости второго объекта
                        // так мы узнаем мешает ли он движению первого
                        var temp = Geom.scalarProd(c.normal, c.c2.object.velocity);
                        if (temp >= 0 || c.c2.object.movement * c.c2.object.velocity.length <= 0.01) {

                            //var impulse:Pt2 = (c.c1.object.mass * c.c1.object.velocity +
                                               //c.c2.object.mass * c.c2.object.velocity);

                            var velocity:Pt2 = (c.c1.object.mass * c.c1.object.velocity +
                                                c.c2.object.mass * c.c2.object.velocity) /
                                               (c.c1.object.mass + c.c2.object.mass);
                            var v1:Pt2 = obj.velocity - velocity;
                            var v2:Pt2 = c.c2.object.velocity - velocity;
                            var tangBounce = Math.sqrt(c.c1.tangBounce * c.c2.tangBounce);
                            var normBounce = Math.sqrt(c.c1.normBounce * c.c2.normBounce);
                            obj.velocity         = velocity + Geom.bounce(v1, c.normal, tangBounce, normBounce);
                            c.c2.object.velocity = velocity + Geom.bounce(v2, c.normal, tangBounce, normBounce);

                            //var v:Pt2 = obj.velocity;
                            //obj.velocity = c.c2.object.velocity;
                            //c.c2.object.velocity = v;
                        }
                    }
                    /*
                    var cLand:Collision = obj.collideWithLand();
                    var cObj:Collision = //null;
                                         obj.collideWithObjects();

                    if (cObj < cLand) {
                        obj.position += cutSpeed(cObj.offset);
                        obj.movement -= Math.sqrt(cObj.offset.length2 / obj.velocity.length2);
                        if (cObj.c2.object.movement == 0 || i == iter - 1) {
                            // collide
                            // swap speeds
                            var v:Pt2 = obj.velocity;
                            obj.velocity = cObj.c2.object.velocity;
                            cObj.c2.object.velocity = v;
                        }
                    } else {
                        if (cLand == null) {
                            obj.position += obj.velocity * obj.movement * 0.99;
                            obj.movement = 0;
                        } else {
                            obj.position += cutSpeed(cLand.offset);
                            obj.movement -= Math.sqrt(cLand.offset.length2 / obj.velocity.length2);
                            obj.velocity = Geom.bounce(obj.velocity, cLand.normal, 0.9, -0.6);
                        }
                    }
                    */

                    if (obj.position.y > waterLevel) removeObject(obj);
                }
            }
            for (o in objects) {
                o.moveGraphics();
                o.velocity *= 1 - o.movement;
            }
            Main.centerText(Std.string(objects.length) + " OBJECTS\n" + Std.string(debugL) + " LAND COLLISION TESTS\n" + Std.string(debugO) + " OBJECT COLLISION TESTS\n" + Std.string(debugP) + " POINTS CREATED");

        } catch (e:Dynamic) {
            Main.log("WORLD: " + Std.string(e));
        }
    }

    /* object funcs:
     *  approxDistToLand
     *  distToLand
     */

    public function addObject(obj:Object) {
        obj.world = this;
        obj.addedToWorld();
        objects.add(obj);
    }

    public function removeObject(obj:Object) {
        objects.remove(obj);
        obj.removedFromWorld();
        obj.world = null;
    }

    public function makeHole(center:Pt2, radius:Float) {

    }

    public function makeSmoke(center:Pt2, amount:Int, color:Int) {

    }

    public function dealDamage(center:Pt2, maxDamage:Int, maxDamRadius:Float, radius:Float, filter:Object->Bool = null) {

    }
}
