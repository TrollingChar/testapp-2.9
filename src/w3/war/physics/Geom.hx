package w3.war.physics;
import w3.Pt2;
import w3.war.physics.colliders.CollisionStruct;

/**
 * ...
 * @author
 */
class Geom {


    static public function scalarProd(a:Pt2, b:Pt2):Float {
        return a.x * b.x + a.y * b.y;
    }



    static public function skewProd(a:Pt2, b:Pt2):Float {
        return a.x * b.y - a.y * b.x;
    }



    static public function solveSqEq(a:Float, b:Float, c:Float):Pt2 {
        var d = b * b - a * c * 4;
        if (d < 0) return null;
        d = Math.sqrt(d);
        return b < 0 ?
            new Pt2((d + b) / (-2 * a), (d - b) / (2 * a)) :
            new Pt2((d - b) / (2 * a), (d + b) / (-2 * a));
    }



    static public function solveLinSys(a1:Float, b1:Float, c1:Float,
                                       a2:Float, b2:Float, c2:Float):Pt2 {
        var d:Float = a1*b2 - a2*b1;
        return d == 0 ? null : new Pt2((c1*b2 - c2*b1) / d, (a1*c2 - a2*c1) / d);
    }



    static public function castRayToHorizontal(p:Pt2, v:Pt2, y:Float, w:Float = 0):Float {
        if(v.y == 0) return 1;
        if(v.y < 0) y += w; else y -= w;
        var result:Float = (y - p.y) / v.y;
        return result < 0 || result >= 1 ? 1 : result;
    }



    static public function castRayToVertical(p:Pt2, v:Pt2, x:Float, w:Float = 0):Float {
        if(v.x == 0) return 1;
        if(v.x < 0) x += w; else x -= w;
        var result:Float = (x - p.x) / v.x;
        return result < 0 || result >= 1 ? 1 : result;
    }



    // возвращает расстояние до столкновения / скорость
    static public function castRayToCircle(p:Pt2, v:Pt2, c:Pt2, r:Float):Float {
        //var pc:Pt2 = p - c;
        //if (scalarProd(pc, v) >= 0) return 1;
        //var result:Pt2 = solveSqEq(
                //v.x * v.x + v.y * v.y,
                //(v.x * pc.x + v.y * pc.y) * 2,
                //pc.x * pc.x + pc.y * pc.y - r * r);
        //return result == null ? 1 : ((result.x < 0 || result.x >= 1) ? 1 : result.x);

        //return result == null ? 1 : result.x < 0 || result.x >= 1 ? 1 : result.x;

        var pc = c - p;
        if (scalarProd(v, pc) <= 0) return 1;
        var h2 = Math.pow(skewProd(v, pc), 2) / v.length2,
            r2 = r * r;
        if (h2 > r2) return 1;
        var result:Float = (Math.sqrt(pc.length2 - h2) - Math.sqrt(r2 - h2)) / v.length;
        if (result < 0) return 0;
        if (result > 1) return 1;
        return result;
    }



    static public function castRayToCircleDebug(p:Pt2, v:Pt2, c:Pt2, r:Float):Float {
        //var pc:Pt2 = p - c;
        //if (scalarProd(pc, v) >= 0) return 1;
        //var result:Pt2 = solveSqEq(
                //v.x * v.x + v.y * v.y,
                //(v.x * pc.x + v.y * pc.y) * 2,
                //pc.x * pc.x + pc.y * pc.y - r * r);
        //return result == null ? 1 : ((result.x < 0 || result.x >= 1) ? 1 : result.x);

        //return result == null ? 1 : result.x < 0 || result.x >= 1 ? 1 : result.x;

        Main.log(Pt2.string(p));
        Main.log(Pt2.string(c));
        Main.log(Pt2.string(v) + " = " + Std.string(v.length));
        var pc:Pt2 = c - p;
        Main.log(pc.length);
        Main.log("SCALAR PRODUCT = " + Std.string(scalarProd(v, pc)));
        if (scalarProd(v, pc) <= 0) {
            return Math.NaN;
        }
        Main.log("SKEW PRODUCT = " + Std.string(skewProd(v, pc)));
        var h2:Float = Math.pow(skewProd(v, pc), 2) / v.length2,
            r2:Float = r * r;
        Main.log("H2 = " + Std.string(h2) + ", R2 = " + Std.string(r2));
        if (h2 > r2) {
            return Math.NaN;
        }
        var result:Float = (Math.sqrt(pc.length2 - h2) - Math.sqrt(r2 - h2)) / v.length;
        //if (result < 0) return 0;
        //if (result > 1) return 1;
        return result;
    }



    static public function convertToBasis(v:Pt2, x:Pt2, y:Pt2):Pt2 {
        // коэффициенты системы уравнений
        var a0:Float = x.x;
        var b0:Float = y.x;
        var c0:Float = v.x;
        var a1:Float = x.y;
        var b1:Float = y.y;
        var c1:Float = v.y;
        // определитель матрицы при решении системы методом Крамера
        var d:Float = a0 * b1 - a1 * b0;
        // null - прямые параллельны или совпадают
        return d == 0 ? null : new Pt2(c0 * b1 - c1 * b0, a0 * c1 - a1 * c0) / d;
    }



    static public function bounce(velocity:Pt2, normal:Pt2, tangCoef:Float, normCoef:Float):Pt2 {
        var tangent:Pt2 = normal.rotateFwd(),
            convertedVelocity = Geom.convertToBasis(velocity, tangent, normal);
        if (convertedVelocity == null) {
            Main.log("VECTOR CONVERSION ERROR");
            return new Pt2();
        }
        return tangent * tangCoef * convertedVelocity.x -
                normal * normCoef * convertedVelocity.y;
    }
}
