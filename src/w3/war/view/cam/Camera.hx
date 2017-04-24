package w3.war.view.cam;
import openfl.display.Stage;

/**
 * ...
 * @author
 */
class Camera {

    public var currentView:Pt2;
    public var target:Pt2;
    var controller:CameraController;

    public function new(currentView:Pt2) {
        target = (this.currentView = currentView).copy();
        reset();
    }

    public function lookAt(target:Pt2) {
        this.target = target.copy();
    }

    public function update() {
        controller.update();
        currentView = 0.7 * currentView + 0.3 * target;
    }

    public function reset() {
        controller = new CameraController();
    }

    public function setManual(stage:Stage) {
        controller = new CameraControllerManual(this, stage);
    }

}