package w3.war.physics.objects;
import format.SVG;
import openfl.Assets;
import openfl.display.Shape;
import openfl.display.Sprite;
import w3.ui.Label;
import w3.war.physics.colliders.CCircle;
import w3.war.physics.controllers.TestController;

class Ball extends Object {
    var size:Float;

    public function new(size:Float) {
        super();

        this.size = size;

        var shape:Shape = new Shape();
        var svg:SVG = new SVG(Assets.getText("img/ball.svg"));
        svg.render(shape.graphics);
        shape.scaleX =
        shape.scaleY = .04 * size;
        shape.x =
        shape.y = -size;
        sprite.addChild(shape);
    }

    override function initColliders() {
        addCollider(new CCircle(new Pt2(), size));
    }

    override function initController() {
        try {
            controller = new TestController();
        } catch (e:Dynamic) {
            Main.log(e);
        }
    }

    override function initGraphics() {
        super.initGraphics();
        Combat.layers.layerProjectiles.addChild(sprite);
        Combat.layers.layerHud.addChild(hud);
    }

    override function removeGraphics() {
        super.removeGraphics();
        Combat.layers.layerProjectiles.removeChild(sprite);
        Combat.layers.layerHud.removeChild(hud);
    }
}
