package w3.ui;

import openfl.display.Sprite;
import openfl.events.Event;
import w3.Pt2;

/**
 * ...
 * @author
 */
class Panel extends Sprite {
    public var posHidden:Pt2;
    public var posShown:Pt2;
    public var shown(get, null):Bool; // direction in which panel moves
    @:isVar public var position(get, set):Float; // 0 - hidden, 1 - shown

    public function new() {
        super();
        addEventListener(Event.ADDED_TO_STAGE, addedToStage);
    }

    function addedToStage(e:Event):Void {
        removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
        stage.addEventListener(Event.RESIZE, resize);
        stage.addEventListener(Event.ENTER_FRAME, update);
        resize(null);
    }

    public function show() {
        shown = true;
    }

    public function hide() {
        shown = false;
    }

    public function toggle() {
        if (shown) hide(); else show();
    }

    function update(e:Event = null):Void {
        if (shown) {
            if (position < 0.9) position += 0.1; else position = 1.0;
        } else {
            if (position > 0.1) position -= 0.1; else position = 0.0;
        }
    }

    function resize(e:Event = null):Void {
        var scX:Float = stage.stageWidth / 1000;
        var scY:Float = stage.stageHeight / 600;
        var scale:Float = scaleX = scaleY = Math.min(scX, scY);
        posShown = new Pt2(stage.stageWidth / 2 - 500 * scale, stage.stageHeight / 2 - 300 * scale);
        posHidden = new Pt2(posShown.x, stage.stageHeight);
        position = position;
    }

    function get_position():Float {
        return position;
    }

    function set_position(value:Float):Float {
        var pos:Pt2 = value * posShown + (1 - value) * posHidden;
        x = pos.x; y = pos.y;
        return position = value;
    }

    function get_shown():Bool {
        return shown;
    }

}