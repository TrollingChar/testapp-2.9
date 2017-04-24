package w3.war.physics;

class LandTile {
    public static inline var size:Int = 20;
    public var x:Int;
    public var y:Int;
    public var land:Int;
    public var vertices:List<Pt2>;

    public function new(x:Int, y:Int, l:Land = null) {
        this.x = x;
        this.y = y;
        if(l == null)
            erase();
        else
            recalc(l);
    }

    public function erase() {
        vertices = new List<Pt2>();
        land = 0;
    }
/*
    public function fill() {
        vertices = new List<Pt2>();
        land = size * size;
        vertices.add(new Pt2(x*size, y*size));
        if(Combat.world.land.at(x*size+size-1, y*size)) vertices.add(new Pt2(x*size+size, y*size));
        if(Combat.world.land.at(x*size, y*size+size-1)) vertices.add(new Pt2(x*size, y*size+size));
        if(Combat.world.land.at(x*size+size-1, y*size+size-1)) vertices.add(new Pt2(x*size+size, y*size+size));
    }
*/
    public function recalc(l:Land = null) {
        if (l == null) l = Combat.world.land;

        vertices = new List<Pt2>();
        land = 0;
        for (_x in x*size...x*size+size) {
            for (_y in y*size...y*size+size) {
                if (l.at(_x, _y)) ++land;
            }
        }
        for (_x in (x*size)...(x*size+size+1)) {
            for (_y in (y * size)...(y * size+size+1)) {
                var temp:Int = 0;
                if (l.at(_x-1, _y)) ++temp;
                if (l.at(_x-1, _y-1)) ++temp;
                if (l.at(_x, _y-1)) ++temp;
                if (l.at(_x, _y)) {
                    ++temp;
                }
                if (temp == 1) vertices.add(new Pt2(_x, _y));
            }
        }
        /*
        for (_x in x*size+1...x*size+size-1) {
            for(_y in y*size+1...y*size+size-1) {
                var temp:Int = 0;
                if (l.at(_x-1, _y)) ++temp;
                if (l.at(_x-1, _y-1)) ++temp;
                if (l.at(_x, _y-1)) ++temp;
                if (l.at(_x, _y)) {
                    ++temp;
                }
                if (temp == 1) vertices.add(new Pt2(_x, _y));
            }
            if (l.at(_x-1, y*size) !=
                l.at(_x, y*size)) vertices.add(new Pt2(_x, y*size));
            if (l.at(_x-1, y*size+size-1) !=
                l.at(_x, y*size+size-1)) vertices.add(new Pt2(_x, y*size+size-1));
            if (l.at(x*size, _x-1) !=
                l.at(x*size, _x)) vertices.add(new Pt2(x*size, _x));
            if (l.at(x*size+size-1, _x-1) !=
                l.at(x*size+size-1, _x)) vertices.add(new Pt2(x*size+size-1, _x));
        }
        if(l.at(x*size, y*size)) vertices.add(new Pt2(x*size, y*size));
        if(l.at(x*size+size-1, y*size)) vertices.add(new Pt2(x*size+size, y*size));
        if(l.at(x*size, y*size+size-1)) vertices.add(new Pt2(x*size, y*size+size));
        if(l.at(x*size+size-1, y*size+size-1)) vertices.add(new Pt2(x*size+size, y*size+size));
        */
    }
}

