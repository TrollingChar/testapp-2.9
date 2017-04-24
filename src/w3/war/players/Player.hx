package w3.war.players;
import w3.war.physics.objects.Worm;

/**
 * ...
 * @author
 */
class Player {

    public var color:Int;
    var wormsCount:Int;
    var activeWorm:Worm;
    var worms:List<Worm>;

    public function new(color:Int) {
        this.color = color;
        wormsCount = 0;
        worms = new List();
    }

    public function addWorm(worm:Worm) {
        worm.player = this;
        worms.add(worm);
        wormsCount++;
        worm.onAddToTeam();
    }

    public function nextWorm():Worm {
        do {
            activeWorm = worms.pop();
            if (activeWorm == null) return null;
        } while (activeWorm.hp <= 0);
        worms.add(activeWorm);
        return activeWorm;
    }


}