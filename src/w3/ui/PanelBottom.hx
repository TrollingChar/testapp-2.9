package w3.ui;
import openfl.events.Event;
import openfl.events.MouseEvent;
import w3.Pt2;

/**
 * ...
 * @author
 */
class PanelBottom extends Panel {

    public var leftIcon:Icon;
    public var rightIcon:Icon;

    public function new() {
        super();

        leftIcon = new Icon();
        rightIcon = new Icon();

        leftIcon.x = 0;
        leftIcon.y = 500;
        addChild(leftIcon);

        rightIcon.x = 880;
        rightIcon.y = 500;
        addChild(rightIcon);
    }

    override function resize(event:Event = null) {
        var h:Float = stage.stageHeight * .15;
        leftIcon.scaleX =
        leftIcon.scaleY =
        rightIcon.scaleX =
        rightIcon.scaleY = h / 100;
        leftIcon.x =
        leftIcon.y =
        rightIcon.y = 0;
        rightIcon.x = stage.stageWidth - 120 * rightIcon.scaleX;
        posHidden = new Pt2(0, stage.stageHeight);
        posShown = posHidden - new Pt2(0, h);
    }
}