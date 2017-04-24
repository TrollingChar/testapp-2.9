package w3.ui;

import flash.filters.GlowFilter;
import openfl.Assets;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFieldType;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

/**
 * ...
 * @author
 */
class Label extends TextField {
    @:isVar public var glow(get, set):Bool;
    @:isVar public var color(get, set):Int;
    @:isVar public var glowColor(get, set):Int;
    @:isVar public var glowFilter(get, set):GlowFilter;

    public function new(
            text:String = "",
            textHeight:Int = 42,
            color:Int = Settings.labelTextColor,
            input:Bool = false,
            selectable:Bool = false,
            bold:Bool = false,
            align:TextFormatAlign = TextFormatAlign.CENTER,
            autosize:TextFieldAutoSize = TextFieldAutoSize.CENTER,
            glowColor:Int = Settings.labelTextGlowColor,
            glow:Bool = false,
            glowFilter:GlowFilter = null) {
        super();
        var textFormat:TextFormat = new TextFormat(Assets.getFont("font/" + (bold ? "Jura-DemiBold" : "Jura-Medium") + ".ttf").fontName, textHeight);
        type = input ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
        embedFonts =
        cacheAsBitmap =
        textFormat.kerning = true;
        textFormat.align = align;
        this.autoSize = autosize;
        this.selectable = selectable;
        defaultTextFormat = textFormat;
        this.color = color;
        this.glowColor = glowColor;
        if (glowFilter == null) glowFilter = new GlowFilter(Settings.labelGlowColor);
        this.glowFilter = glowFilter;
        this.glow = glow;
        this.text = text;
    }

    function get_glow():Bool {
        return glow;
    }

    function set_glow(value:Bool):Bool {
        if (glow) {
            if (!value) {
                // убрать свечение
                textColor = color;
                var filt = filters;
                filt.pop();
                filters = filt;
            }
        } else {
            if (value) {
                // сделать свечение
                textColor = glowColor;
                var filt = filters;
                filt.push(glowFilter);
                filters = filt;
            }
        }
        return glow = value;
    }

    function get_glowFilter():GlowFilter {
        return glowFilter;
    }

    function set_glowFilter(value:GlowFilter):GlowFilter {
        if (glow) {
            var filt = filters;
            filt.pop();
            filt.push(value);
            filters = filt;
        }
        return glowFilter = value;
    }

    function get_color():Int {
        return color;
    }

    function set_color(value:Int):Int {
        if (!glow) textColor = value;
        return color = value;
    }

    function get_glowColor():Int {
        return glowColor;
    }

    function set_glowColor(value:Int):Int {
        if (glow) textColor = value;
        return glowColor = value;
    }

}