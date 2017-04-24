package w3.ui;
import openfl.events.MouseEvent;
import w3.net.Connection;

/**
 * ...
 * @author
 */
class PanelCancel extends Panel{

    public function new() {
        super();

        var label:Label = new Label(42);
        label.x = 500;
        label.y = 150;
        label.text = "Ожидание соперника";
        addChild(label);

        var btn:Button = new Button(function(e:MouseEvent) { Connection.sendCancel(); }, "Отмена");
        btn.x = 350;
        btn.y = 300;
        addChild(btn);
    }

}