package w3.ui;

import format.SVG;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.filters.GlowFilter;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormatAlign;
import w3.ui.Label;

/**
 * ...
 * @author
 */
class Button extends Sprite {
    var shape:Shape;
    var label:Label;

    public function new(callback:MouseEvent->Void = null, text:String = "") {
        super();
        var svg:SVG = new SVG(Assets.getText("img/button.svg"));
        shape = new Shape();
        svg.render(shape.graphics);
        addChild(shape);

        label = new Label(
            "",
            42,
            Settings.labelTextColor,
            false,
            false,
            false,
            TextFormatAlign.CENTER,
            TextFieldAutoSize.CENTER,
            Settings.labelTextGlowColor,
            false,
            new GlowFilter(Settings.labelGlowColor));
        label.height = 100;
        label.x = 150;
        label.y = 25;
        label.text = text;
        addChild(label);

        addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
        addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
        if(callback != null) addEventListener(MouseEvent.CLICK, callback);
    }

    private function mouseOut(e:MouseEvent):Void {
        label.glow = false;
    }

    private function mouseOver(e:MouseEvent):Void {
        label.glow = true;
    }

}