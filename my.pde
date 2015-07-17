    int num = 65;
    int [] x = new int[num];
    boolean bDone = false;
    int step, nSize, aBeginArg, bBeginArg, aLenArg, bLenArg;
  int iGlobal;

    void setup(){
        size(510, num * 10);
        frameRate(10);
        background(0);
        for (int p = 0; p <= num-1; p++){
            x[p] = (int)random(1,100);
            rect(0,10*p,5*x[p],10);
            text(x[p],5*x[p],10*p+10);}

        println(x);
        step = 1;
        nSize = x.length;
    iGlobal = 0;
    }


    int[] compare(int[] arSrc, int aBegin, int aLen, int bBegin, int bLen )
    {
        println("ab:", aBegin, "alen:", aLen, "bBegin:", bBegin, "bLen:", bLen);
        int retLen = aLen + bLen;
        int[] retTmp  = new int[retLen];
        int indexa = 0, indexb = 0;

        int cacheIndex = 0;
        int j = bBegin, i = 0;
        int aDie = 0, bDie = 0;
        for(i = aBegin; i < (aLen + aBegin) && aDie != aLen && bDie != bLen;)
        {
            println("ai:", arSrc[i], "bj:", arSrc[j]);
            if (i >= arSrc.length || j >= arSrc.length) {
                // all sorted already
                break;
            }
            if (arSrc[i] < arSrc[j]) {
                retTmp[cacheIndex] = arSrc[i];
                aDie++;
            } else {
                retTmp[cacheIndex] = arSrc[j];
                bDie++;
                j++;
                i -=1;
            }
            cacheIndex++;
            i += 1;
        }
        //println("adie:", aDie, "bdie", bDie);
        if (aDie == aLen) {
            for(j=bBegin + bDie; j < bLen + bBegin; j++) {
                println("ci:", cacheIndex, "bI:", j);
                retTmp[cacheIndex++] = arSrc[j];
            }
        }
        if (bDie == bLen) {
            for(j=aBegin + aDie; j < aLen + aBegin; j++) {
                println("ci:", cacheIndex, "aI:", j);
                retTmp[cacheIndex++] = arSrc[j];
            }
        }
//  println(retTmp);
        return retTmp;
    }

    void drawArray(int[] array) {
        background(0);
        for (int p = 0; p < array.length; p++){
            fill(255);
            rect(0, 10*p ,5 * array[p], 10)
            text(array[p],5*array[p],10*p+10);;

        }
    }

    void draw()
    {
            aBeginArg = iGlobal; bBeginArg = iGlobal + step; aLenArg = step; bLenArg = step;

            if (aBeginArg >= nSize) aLenArg = 0;
            else if ((aBeginArg + aLenArg) >= nSize) aLenArg = nSize - aBeginArg;

            if (bBeginArg >= nSize) bLenArg = 0;
            else if ((bBeginArg + bLenArg) >= nSize) bLenArg = nSize - bBeginArg;

            int [] cacheSorted = compare(x, aBeginArg, aLenArg, bBeginArg, bLenArg);

            println("cache sorted:", cacheSorted);
            for (int j = iGlobal, ci = 0; j < cacheSorted.length + iGlobal; j++, ci++)
            {
                x[j] = cacheSorted[ci];
            }
            drawArray(x);
            if (cacheSorted.length == x.length) {
                bDone = true;
            }
      if (iGlobal < nSize) {
        iGlobal += step * 2;
      }
      
      if (iGlobal >= nSize) {
        step *= 2;
        if(step >= nSize) step = 1;
        iGlobal = 0;
      }
     
      
        println(step);
        //drawArray(x);

    }
