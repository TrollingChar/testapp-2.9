package w3.ui;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.events.Event;

/**
 * ...
 * @author
 */
class PanelBackground extends Panel {
    var bmd:BitmapData;
    var bmp:Bitmap;

    public function new() {
        super();
        bmd = Assets.getBitmapData("img/main.png");
        bmp = new Bitmap(bmd);
        bmp.scaleX =
        bmp.scaleY = 0.5;
        addChild(bmp);
    }

    override function resize(e:Event = null):Void {
        //super.resize(e);
        var scX:Float = stage.stageWidth / 1000;
        var scY:Float = stage.stageHeight / 600;
        var scale:Float = scaleX = scaleY = Math.max(scX, scY);
        posShown = new Pt2(stage.stageWidth / 2 - 500 * scale, stage.stageHeight / 2 - 300 * scale);
        posHidden = new Pt2(posShown.x, stage.stageHeight);
        position = position;
    }
}