package w3.war.view.cam;

import openfl.display.Stage;
import w3.Pt2;

/**
 * ...
 * @author
 */
class CameraControllerManual extends CameraController {
    public var offset:Pt2;
    var stage:Stage;

    public function new(cam:Camera, stage:Stage) {
        super();
        camera = cam;
        this.stage = stage;
        this.offset = cam.target + new Pt2(stage.mouseX, stage.mouseY);
    }

    override public function update() {
        camera.lookAt(offset - new Pt2(stage.mouseX, stage.mouseY));
        super.update();
    }

}