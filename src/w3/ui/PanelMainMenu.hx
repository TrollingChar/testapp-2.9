package w3.ui;
import openfl.events.MouseEvent;
import w3.net.Connection;

/**
 * ...
 * @author
 */
class PanelMainMenu extends Panel {

    public function new() {
        super();

        var btn:Button = new Button(function(e:MouseEvent) {
            Connection.sendToBattle();
            hide();
            Main.panelCancel.show();
        }, "Бой");
        btn.x = 350;
        btn.y = 150;
        addChild(btn);

        var btn:Button = new Button(function(e:MouseEvent) {
            hide();  Main.panelHelp.show();
        }, "Инструктаж");
        btn.x = 350;
        btn.y = 300;
        addChild(btn);
    }

}