package w3.ui;

import format.SVG;
import openfl.Assets;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormatAlign;

/**
 * ...
 * @author
 */
class InputBox extends Sprite {
    var shape:Shape;
    var label:Label;
    public var text(get, set):String;

    public function new(text:String = "", textSize:Int = 42) {
        super();
        var svg:SVG = new SVG(Assets.getText("img/button.svg"));
        shape = new Shape();
        svg.render(shape.graphics);
        addChild(shape);

        label = new Label(text, textSize, Settings.labelTextColor, true, true, false, TextFormatAlign.CENTER, TextFieldAutoSize.NONE);
        label.height = textSize * 100 / 42;
        label.width = 250;
        label.x = 25;
        label.y = 50 - textSize * 25 / 42;
        addChild(label);
    }

    function get_text():String {
        return label.text;
    }

    function set_text(value:String):String {
        return label.text = value;
    }

}