package w3.ui;
import openfl.events.MouseEvent;
import openfl.system.Security;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormatAlign;
import w3.net.Connection;

/**
 * ...
 * @author
 */
class PanelConnect extends Panel {
    var ip:InputBox;
    var id:InputBox;

    public function new() {
        super();

        var label:Label;
        label = new Label("Сервер", 42, Settings.labelTextColor, false, false, false, TextFormatAlign.LEFT, TextFieldAutoSize.LEFT);
        label.x = 200;
        label.y = 125;
        addChild(label);

        label = new Label("№ игрока", 42, Settings.labelTextColor, false, false, false, TextFormatAlign.LEFT, TextFieldAutoSize.LEFT);
        label.x = 200;
        label.y = 225;
        addChild(label);

        ip = new InputBox("100.90.171.149", 32);
        ip.x = 500;
        ip.y = 100;
        addChild(ip);

        id = new InputBox(Std.string(Math.floor(Math.random() * 10000)));
        id.x = 500;
        id.y = 200;
        addChild(id);

        var btn:Button = new Button(function(e:MouseEvent) {
            var i:Null<Int> = Std.parseInt(id.text);
            if (i == null) {
                id.text = Std.string(Math.floor(Math.random() * 10000));
                return;
            }
            Connection.init(ip.text, 7675);
            Security.allowDomain("*");
            Security.allowInsecureDomain("*");
            //Security.loadPolicyFile("xmlsocket://" + ip.text + ":843");
            Connection.connect(i);
        }, "Соединение");
        btn.x = 350;
        btn.y = 350;
        addChild(btn);
    }

}