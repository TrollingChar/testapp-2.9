package w3.war.physics.controllers;
import w3.Pt2;

class TestController extends Controller {
    public function new() {
        super();
    }

    override public function addedToObject() {
        object.velocity = /*new Pt2();/*/ Pt2.fromPolar(10 + Random.genrand_float() * 10, Random.genrand_float() * Math.PI * 2).rotateBwd(); //*/
        //object.velocity = new Pt2(-20, -20);
        timer = 5000;// + Random.genrand_int32() % 4001;
    }

    override public function work() {
        object.velocity.y += Combat.world.gravity;
        Combat.wait();
    }

    override public function timerCallback() {
        object.detonate();
    }

    override public function set_timer(value:Int):Int {
        return timer = value;
    }
}
