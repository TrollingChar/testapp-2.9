package w3;


/**
 * ...
 * @author
 */
class Random
{
    static var N:Int = 624;
    static var M:Int = 397;
    static var MATRIX_A:Int = 0x9908b0df;  /* constant vector a */
    static var UPPER_MASK:Int = 0x80000000;/* most significant w-r bits */
    static var LOWER_MASK:Int = 0x7fffffff;/* least significant r bits */

    static var mt:Array<Int>; /* the array for the state vector  */
    static var mti:Int;
    static var seed:Int;
    static var returnLength:Int;
    static var maxSize:Int;

    static var returnArray:Array<Int>;


    static public function init(seed:Int) {
        mt = new Array<Int>();
        init_genrand(seed);
    }

    static public function twist(_seed:Int, _returnLength:Int, _maxSize:Int):Array<Int> {
        seed = _seed;
        returnLength = _returnLength;
        maxSize = _maxSize;
        mt = [];

        returnArray = [];

        mti = N+1; /* mti==N+1 means mt[N] is not initialized */
        var i:Int;
        //var initArray=(0x123, 0x234, 0x345, 0x456);    //2010.04.20    modiied to the below
        var initArray:Array<Int> = [0x123, 0x234, 0x345, 0x456];
        init_by_array(initArray,initArray.length);
        for (i in 0...returnLength) {
            returnArray[i] = genrand_int32()%maxSize;
        }
        //returnArray.sort(16);
        //trace(returnArray);
        /*
        trace("\n1000 outputs of genrand_real2()\n");
        for (i=0; i<returnLength; i++) {
          trace(" " + genrand_real2());
          if (i%5==4) trace("\n");
        }
        */
        return returnArray;

    }


    /* initializes mt[N] with a seed */
    static public function init_genrand(_seed:Int) {
        mt[0]= _seed & 0xffffffff;
        for (mti in 1...N) {
            mt[mti] = (1812433253 * (mt[mti-1] ^ (mt[mti-1] >> 30)) + mti);
            mt[mti] &= 0xffffffff;
            /* for >32 bit machines */
        }
    }

    /* initialize by an array with array-length */
    /* init_key is the array for initializing keys */
    /* key_length is its length */
    /* slight change for C++, 2004/2/26 */
    //    void init_by_array(unsigned long init_key[], int key_length)

    static function init_by_array(_seedArray:Array<Int>, _seedArrayLength:Int) {
        var i:Int = 1;
        var j:Int = 0;
        init_genrand(seed);
        //init_genrand(19650218);
        var k:Int = (N>_seedArrayLength) ? N : _seedArrayLength;
        while(k>0) {
            mt[i] = (mt[i] ^ ((mt[i-1] ^ (mt[i-1] >> 30)) * 1664525)) + _seedArray[j] + j; /* non linear */
            mt[i] &= 0xffffffff; /* for WORDSIZE > 32 machines */
            i++;
            j++;
            if (i >= N) {
                mt[0] = mt[N-1];
                i=1;
            }
            if (j >= _seedArrayLength) j = 0;
            k--;
        }
        k = N-1;
        while(k>0) {
            mt[i] = (mt[i] ^ ((mt[i-1] ^ (mt[i-1] >> 30)) * 1566083941)) - i; /* non linear */
            mt[i] &= 0xffffffff; /* for WORDSIZE > 32 machines */
            i++;
            if (i>=N) {
                mt[0] = mt[N-1];
                i=1;
            }
            k--;
        }

        mt[0] = 0x80000000; /* MSB is 1; assuring non-zero initial array */
    }

    /* generates a random number on [0,0xffffffff]-interval */
    static public function genrand_int32():Int {
        var y:Int;
        var mag01:Array<Int>=[0x0, MATRIX_A];
        /* mag01[x] = x * MATRIX_A  for x=0,1 */

        if (mti >= N) { /* generate N words at one time */
            var kk:Int;

                if (mti == N+1) /* if init_genrand() has not been called, */
                    init_genrand(5489); /* a default initial seed is used */

            for (kk in 0...N-M) {
                y = (mt[kk]&UPPER_MASK)|(mt[kk+1]&LOWER_MASK);
                mt[kk] = mt[kk+M] ^ (y >> 1) ^ mag01[y & 0x1];
            }
            for (kk in 0...N-1) {
                y = (mt[kk]&UPPER_MASK)|(mt[kk+1]&LOWER_MASK);
                mt[kk] = mt[kk+(M-N)] ^ (y >> 1) ^ mag01[y & 0x1];
            }
            y = (mt[N-1]&UPPER_MASK)|(mt[0]&LOWER_MASK);
            mt[N - 1] = mt[M - 1] ^ (y >> 1) ^ mag01[y & 0x1];

            mti = 0;
        }

        y = mt[mti++];

        /* Tempering */
        y ^= (y >> 11);
        y ^= (y << 7) & 0x9d2c5680;
        y ^= (y << 15) & 0xefc60000;
        y ^= (y >> 18);

        return y;
    }

    static public function genrand_float():Float {
        var float:Float = genrand_int32() / 2147483648.0;
        //if (float < 0) float += 1.0;
        //Main.I.log(Std.string(float));
        return float;
    }

    /* generates a random number on [0,0x7fffffff]-interval */
    static function genrand_int31():Int {
        return (genrand_int32()>>1);
    }
    /* These real versions are due to Isaku Wada, 2002/01/09 added */
}