package w3.ui;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormatAlign;

/**
 * ...
 * @author
 */
class PanelCenterText extends Panel {
    var label:Label;
    public var text(get, set):String;

    public function new() {
        super();

        label = new Label(42, Settings.labelTextColor, false, false, true, TextFormatAlign.CENTER, TextFieldAutoSize.NONE, Settings.labelTextGlowColor, true);
        label.x = 0;
        label.width = 1000;
        label.y = 100;
        label.height = 400;
        label.wordWrap = true;
        addChild(label);
    }

    function get_text():String {
        return label.text;
    }

    function set_text(value:String):String {
        return label.text = value;
    }

}