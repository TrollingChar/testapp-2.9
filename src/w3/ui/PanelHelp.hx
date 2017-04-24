package w3.ui;
import openfl.events.MouseEvent;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormatAlign;

/**
 * ...
 * @author
 */
class PanelHelp extends Panel{

    public function new() {
        super();

        var label:Label = new Label(
            "Тестовое приложение 3 (с мультиплеером)\n" +
            "\n" +
            "Ползать: влево: [A], вправо: [D]\n" +
            "Прыгать: вперед: [W], вверх: [S]\n" +
            "Одновременно вверх и в сторону: [S] с зажатой [A] или [D]\n" +
            "Достать оружие: [Q]\n" +
            "Осмотреть карту: [Правая кнопка мыши]\n" +
            "ОГОНЬ: [Левая кнопка мыши]\n" +
            "\n" +
            "Выноси всех, кроме себя!\n", 28, Settings.labelTextColor, false, false, true, TextFormatAlign.CENTER, TextFieldAutoSize.NONE);
        label.x = 0;
        label.width = 1000;
        label.y = 50;
        label.height = 400;
        label.wordWrap = true;
        /*label.text =
            "Тестовое приложение 3 (с мультиплеером)\n" +
            "\n" +
            "Ползать: влево: [A], вправо: [D]\n" +
            "Прыгать: вперед: [W], вверх: [S]\n" +
            "Одновременно вверх и в сторону: [S] с зажатой [A] или [D]\n" +
            "Достать оружие: [Q]\n" +
            "Осмотреть карту: [Правая кнопка мыши]\n" +
            "ОГОНЬ: [Левая кнопка мыши]\n" +
            "\n" +
            "Выноси всех, кроме себя!\n";*/

        addChild(label);

        var btn:Button = new Button(function(e:MouseEvent) { hide(); Main.panelMain.show(); }, "Закрыть");
        btn.x = 350;
        btn.y = 450;
        addChild(btn);
    }

}