package w3.war.physics.objects;
import haxe.ds.HashMap;
import openfl.display.Sprite;
import openfl.filters.GlowFilter;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormatAlign;
import w3.Pt2;
import w3.ui.Label;
import w3.ui.Settings;
import w3.war.physics.World;
import w3.war.physics.colliders.Collider;
import w3.war.physics.colliders.Collision;
import w3.war.physics.colliders.CollisionStruct;
import w3.war.physics.controllers.Controller;

/**
 * ...
 * @author
 */
class Object {
    static var nextId:Int = 0;
    var id:Int;

    @:isVar public var position(get, set):Pt2;
    public var velocity:Pt2;
    public var world:World;

    public var movement:Float;
    public var excluded:HashMap<Object, Object>;
    public var colliders:List<Collider>;
    @:isVar public var controller(get, set):Controller;

    public var sprite:Sprite;
    public var hud:Sprite;
    public var timerLabel:Label;
    public var timerText(get, set):String;

    public var mass:Float;

    public function new(mass:Float = 60) {
        id = nextId++;

        this.mass = mass;

        sprite = new Sprite();
        hud = new Sprite();
        colliders = new List<Collider>();

        position = new Pt2();
        velocity = new Pt2();
    }

    public function update() {
        controller.update();
    }

    public function addedToWorld() {
        initColliders();
        initGraphics();
        initController();
    }

    public function nextCollision():Collision {
        var v:Pt2 = velocity * movement;
        var cObj:Collision = collideWithObjects(v);
        if(cObj != null) v = cObj.offset;
        var cLand:Collision = collideWithLand(v);
        return //cLand;
               cLand == null ? cObj : cLand;
    }

    public function nextCollisionLL():Collision {

        // var v:Pt2 = velocity * movement;
        LL.xa = velocity.x * movement;
        LL.ya = velocity.y * movement;

        //var cObj:Collision = collideWithObjects(v);
        LL.oa = this;
        //collideWithObjectsLL();

        //if (cObj != null) v = cObj.offset;

        //var cLand:Collision = collideWithLand(v);
        collideWithLandLL();

        return null;

        //return //cLand;
               //cLand == null ? cObj : cLand;
    }

    public function collideWithLand(v:Pt2):Collision {
        var min:Collision = null;
            //v:Pt2 = velocity * movement;
        for (c in colliders) {
            var temp:Collision = c.collideWithLand(world.land, v);
            if(temp < min) min = temp;
        }
        return min;
    }

    // min collision must be in  ca
    // velocity must be in       xa ya
    public function collideWithLandLL() {//:Collision {
        //var min:Collision = null;

        for (c in colliders) {

            c.collideWithLandLL();
            //if(temp < min) min = temp;
        }
        //return min;
    }

    public function excludeObjects() {
        for(collider in colliders) {
            for(obstacle in collider.findOverlapping(world)) {
                if (excluded.exists(obstacle.object)) continue;
                excluded.set(obstacle.object, obstacle.object);
                //obstacle.object.excluded.set(this, this);
            }
        }
    }

    public function collideWithObjects(v:Pt2):Collision {
        var min:Collision = null;
            //v:Pt2 = velocity * movement;
        for (c in colliders) {
            var obstacles:HashMap<Collider, Collider> = c.findObstacles(world, v);
            for (d in obstacles) {
                obstacles.remove(d);
                if (d.object.passableFor(this)) continue;
                if (excluded.exists(d.object)) continue;
                ++Combat.world.debugO;
                var temp:Collision = c.collideWith(d, v);
                if(temp < min) min = temp;
            }
        }
        return min;
    }

    public function collideWithObjectsLL() {//:Collision {
        ////var min:Collision = null;
//
        //for (c in colliders) {
            ////var obstacles:HashMap<Collider, Collider> = c.findObstacles(world, v);
            //var obstacles:HashMap<Collider, Collider> = c.findObstaclesLL();
//
            //for (cc in obstacles) {
                //obstacles.remove(cc);
                //if (cc.object.passableFor(this)) continue;
                //if (excluded.exists(cc.object)) continue;
                //++Combat.world.debugO;
                ////var temp:Collision = c.collideWith(cc, v);
                //LL.ca = c;
                //LL.cb = cc;
                //c.collideWithLL();
//
                ////if(temp < min) min = temp;
            //}
        //}
        ////return min;
    }
/*
    @:deprecated
    public function procCollision(c:Collision, bounce:Bool) {
        try {

            // calculate true offset (objects must not overlap)
            //var offset:Pt2;
            //if (c == null) {
                //offset = velocity*movement*0.99;
                //movement = 0;
            //} else {
                //offset = c.offset;
                //movement -= Math.sqrt(offset.length2 / velocity.length2);
                //var lower:Float = 0,
                    //upper:Float = 1.98;
                //while (upper - lower > 0.01 && lower < 0.99) {
                    //var middle = (lower + upper) / 2;
                    //if (c.pr1.locate(c.pr2, offset * middle) < 0) {
                        //upper = middle;
                    //} else {
                        //lower = middle;
                    //}
                //}
                //offset *= lower;
            //}

            //TODO: move that to world class (now it's causing bugs with movement)
            var offset:Pt2;
            if (c == null) {
                offset = velocity * movement;
                movement = 0;
            } else {
                offset = c.offset.copy();
                movement -= Math.sqrt(offset.length2 / velocity.length2);
            }
            var len:Float = offset.length;
            len -= 0.000001;
            if (len < 0) len = 0;
            offset.length = len;

            position += offset;

            // bounce and collide
            if (!bounce || c == null) return;
            onCollision(c);

        } catch (e:Dynamic) {
            Main.log("COLLISION PROCESSING ERROR");
            Main.log(c);
            Main.log(bounce);
            Main.log("");
        }
    }

    function onCollision(c:Collision) {
        //if (c.c2 != null) detonate();

        var normal:Pt2 = c.normal,
            tangent:Pt2 = normal.rotateFwd(),
            convertedVelocity = Geom.convertToBasis(velocity, tangent, normal);
        if (convertedVelocity == null) Main.log("VECTOR CONVERSION ERROR");
        velocity = tangent * 0.9 * convertedVelocity.x
                 + normal * -0.6 * convertedVelocity.y;
    }
*/
    function passableFor(o:Object):Bool {
        return this == o;
    }

    function addTimerLabel() {
        timerLabel = new Label("", 20, 0, false, false, true,
                               TextFormatAlign.CENTER,
                               TextFieldAutoSize.CENTER,
                               Settings.labelTextGlowColor,
                               true,
                               new GlowFilter(0, 1, 2, 2, 2));
        timerLabel.x = 0;
        timerLabel.y = 20;
        hud.addChild(timerLabel);
    }

    function removeTimerLabel() {
        hud.removeChild(timerLabel);
        timerLabel = null;
    }

    public function removedFromWorld() {
        for (c in colliders) {
            c.freeTiles();
            c.object = null;
        }
        removeGraphics();
    }

    public function detonate() {
        world.removeObject(this);
    }

    // get set controller

    function initColliders() {
        // addCollider(...);
        // addCollider(...);
    }

    function addCollider(c:Collider) {
        c.object = this;
        colliders.add(c);
        c.update();
    }

    function removeCollider(c:Collider) {
        c.freeTiles();
        colliders.remove(c);
    }

    function initController() {
        // controller = ...;
    }

    function initGraphics() {
        // sprite.addChild(...);
        //hud.addChild(timerLabel = new Label(
    }

    function updateGraphics() {}

    public function moveGraphics() {
        sprite.x =
        hud.x = position.x;
        sprite.y =
        hud.y = position.y;
    }

    function removeGraphics() {
        timerText = "";
    }

    function get_timerText():String {
        return timerLabel == null ? "" : timerLabel.text;
    }

    function set_timerText(value:String):String {
        if (value == "") {
            if (timerLabel != null) {
                removeTimerLabel();
            }
        } else if (timerText != value) {
            if (timerLabel == null) addTimerLabel();
            timerLabel.text = value;
        }
        return value;
    }

    function get_position():Pt2 {
        return position;
    }

    function set_position(value:Pt2):Pt2 {
        position = value;
        for (c in colliders) {
            c.update();
        }
        //moveGraphics();
        return value;
    }

    function get_controller():Controller {
        return controller;
    }

    function set_controller(value:Controller):Controller {
        if (controller != null)
            controller.removedFromObject();
        if (value != null) {
            value.object = this;
            value.addedToObject();
        }
        return controller = value;
    }

    public function hashCode():Int {
        return id;
    }

}
