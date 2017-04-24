package w3.war.view;

import openfl.events.Event;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import w3.war.view.cam.Camera;

/**
 * ...
 * @author
 */
class Layers extends Sprite {
    var skyBmd:BitmapData;
    var landBmd:BitmapData;

    public var layerSky:Sprite;         // камера не обрабатывает
    public var layerWaterFar:Sprite;    // смещение только по y
    public var layerLand:Sprite;
    public var layerWorms:Sprite;
    public var layerProjectiles:Sprite;
    public var layerDarkSmoke:Sprite;
    public var layerLightSmoke:Sprite;
    public var layerWaterNear:Sprite;   // смещение только по y
    public var layerHud:Sprite;

    public var camera:Camera;

    public function new(sky:BitmapData, land:BitmapData) {
        super();

        addChild(layerSky = new Sprite());
        addChild(layerWaterFar = new Sprite());
        addChild(layerLand = new Sprite());
        addChild(layerWorms = new Sprite());
        addChild(layerProjectiles = new Sprite());
        addChild(layerDarkSmoke = new Sprite());
        addChild(layerLightSmoke = new Sprite());
        addChild(layerWaterNear = new Sprite());
        addChild(layerHud = new Sprite());
        layerSky.addChild(new Bitmap(sky));
        layerLand.addChild(new Bitmap(land));

        addEventListener(Event.ADDED_TO_STAGE, addedToStage);
    }

    function addedToStage(e:Event):Void {
        removeEventListener(Event.ADDED_TO_STAGE, addedToStage);

        stage.addEventListener(Event.RESIZE, stage_resize);
        stage_resize();

        camera = new Camera(new Pt2(1000, 500));
    }

    public function update() {
        // update camera
        camera.update();

        // move sprites
        layerLand.x =
        layerWorms.x =
        layerProjectiles.x =
        layerDarkSmoke.x =
        layerLightSmoke.x =
        layerHud.x = stage.stageWidth / 2 - camera.currentView.x;
        //layerWaterFar.y =
        layerLand.y =
        layerWorms.y =
        layerProjectiles.y =
        layerDarkSmoke.y =
        layerLightSmoke.y =
        //layerWaterNear.y =
        layerHud.y = stage.stageHeight / 2 - camera.currentView.y;
    }

    function stage_resize(e:Event = null):Void {
        var scX:Float = stage.stageWidth / 1000;
        var scY:Float = stage.stageHeight / 600;
        var scale:Float =
        layerSky.scaleX =
        layerSky.scaleY = Math.max(scX, scY);
        layerSky.x = stage.stageWidth / 2 - 500 * scale;
        layerSky.y = stage.stageHeight / 2 - 300 * scale;
    }

}
