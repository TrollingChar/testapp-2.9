package w3;

/**
 * ...
 * @author
 */
class Util
{
    static public function makeArray(from:Int, to:Int):Array<Int>
    {
        var arr:Array<Int> = new Array<Int>();
        for (i in from...to)
        {
            arr.push(i);
        }
        return arr;
    }

}