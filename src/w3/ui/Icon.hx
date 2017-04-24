package w3.ui;

import format.*;
import openfl.*;
import openfl.display.*;
import openfl.events.*;
import openfl.filters.*;
import openfl.text.*;

/**
 * ...
 * @author
 */
class Icon extends Sprite {
    var label:Label;
    var shape:Shape;
    var icon:Sprite;
    var iconVisible(get, set):Bool;
    public var text(get, set):String;

    public function new(callback:MouseEvent->Void = null, text:String = "", icon:Sprite = null) {
        super();

        var svg:SVG;
        svg = new SVG(Assets.getText("img/button-icon.svg"));
        shape = new Shape();
        svg.render(shape.graphics);
        addChild(shape);

        this.icon = new Sprite();
        this.icon.x = shape.width / 2;
        this.icon.y = shape.height / 2;
        if (icon != null) {
            this.icon.addChild(icon);
        }
        addChild(this.icon);

        label = new Label(
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
        label.x = 60;
        label.y = 25;
        label.text = text;
        addChild(label);

        /*
        super(text, 0x889999, new GlowFilter(0xFFFF00), false);
        textField.x = 0;
        textField.width = 120;
        */

        addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
        addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
        if(callback != null) addEventListener(MouseEvent.CLICK, callback);
    }

    function mouseOut(event:MouseEvent) {
        if (icon != null)
            icon.scaleX =
            icon.scaleY = 1;
        label.glow = false;
    }

    function mouseOver(event:MouseEvent) {
        if (icon != null)
            icon.scaleX =
            icon.scaleY = 1.2;
        label.glow = true;
    }

    function get_iconVisible():Bool {
        if (icon == null) return false;
        return icon.visible;
    }

    function set_iconVisible(value:Bool):Bool {
        if (icon == null) return value;
        return icon.visible = value;
    }

    function get_text():String {
        return label.text;
    }

    function set_text(value:String):String {
        return label.text = value;
    }
}