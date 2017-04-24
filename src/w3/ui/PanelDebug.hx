package w3.ui;
import openfl.display.FPS;
import openfl.events.Event;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormatAlign;

/**
 * ...
 * @author
 */
class PanelDebug extends Panel {
    //public var fps:FPS;
    public var label:Label;

    public function new() {
        super();

        label = new Label("HACK TERMINAL INITIALIZED\n", 20, Settings.debugTextColor, false, true, true, TextFormatAlign.LEFT, TextFieldAutoSize.NONE);
        label.background = true;
        label.backgroundColor = Settings.debugBackgroundColor;
        addChild(label);

        //fps = new FPS(600, 0, Settings.debugTextColor);
        //addChild(fps);

        alpha = 0.7;
    }

    override function resize(e:Event = null):Void {
        label.width = stage.stageWidth;
        label.height = stage.stageHeight;
        posShown = new Pt2();
        posHidden = new Pt2(0, stage.stageHeight);
        position = position;
    }

    override function hide() {
        super.hide();
        position = 0;
    }

    override function show() {
        super.show();
        position = 1;
    }

}