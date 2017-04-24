package w3.ui;
import openfl.display.StageDisplayState;
import openfl.events.Event;
import openfl.events.MouseEvent;
import w3.Pt2;

/**
 * ...
 * @author
 */
class PanelTop extends Panel {
    var btn:Icon;

    public function new() {
        super();

        btn = new Icon(function(e:MouseEvent) {
            if (stage.displayState == StageDisplayState.NORMAL) {
                stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
            } else {
                stage.displayState = StageDisplayState.NORMAL;
            }
        });

        btn.x = 880;
        btn.y = 0;
        addChild(btn);
    }

    override function resize(event:Event = null) {
        var h:Float = stage.stageHeight * .05;
        btn.scaleX = btn.scaleY = h / 100;
        btn.x = stage.stageWidth - 120 * btn.scaleX;
        posShown = new Pt2();
        posHidden = new Pt2(0, -h);
    }

}