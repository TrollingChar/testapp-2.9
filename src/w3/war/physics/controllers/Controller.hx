package w3.war.physics.controllers;
import w3.war.physics.objects.Object;

class Controller {
    public var object:Object;
    @:isVar public var timer(get, set):Int; // TODO

    public function new() {
        timer = 20000;
    }

    public function addedToObject() {}

    public function update() {
        if ((timer -= 20) < 0) {
            timerCallback();
        } else {
            work();
        }
    }

    public function timerCallback() {
        //object.detonate();
        work();
    }

    public function work() {

    }

    public function get_timer():Int {
        return timer;
    }

    public function set_timer(value:Int):Int {
        if (object != null) {
            var i:Int = value > 0 ? Std.int((value + 999) / 1000) : 0;
            object.timerText = i > 5 ? "" : Std.string(i);
        }
        return timer = value;
    }

    public function removedFromObject() {

    }
}
