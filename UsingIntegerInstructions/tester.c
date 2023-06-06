#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
long convertTo658(double d);
void displayBits(long value);
extern int MBPixelCalc(long,long);
int main(int argc, char *argv[]) {
    //int i=argc;
    //printf("number of inputs is %d. \n",i);
    char *ptr1;
    char *ptr2;
    double d1=strtod(argv[1],&ptr1);
    double d2=strtod(argv[2],&ptr2);
    //printf("value of d1 is %f. \n",d1);
    long l1=convertTo658(d1);
    //displayBits(l1);
    //printf("value of d2 is %f. \n",d2);
    long l2=convertTo658(d2);
    //displayBits(l2);
    printf("MBPixelCalc() returned %d.\n", MBPixelCalc(l1,l2));
    //printf("finished assembly code");
    return 0;
}
long convertTo658(double d){
    int bitNumber=1;
    if(d>=0){
        long result=0;
        //displayBits(result);
        result*=2;
        bitNumber+=1;
        double currentPlace=16;
        while(bitNumber<=64){
            if(d>=currentPlace){
                result+=1;
                d-=currentPlace;
            }
            else{
                result+=0;
            }
            if(bitNumber!=64){
                result*=2;
            }
            bitNumber+=1;
            currentPlace=currentPlace/2;
        }
        return result;

    }
    else{
        long result=1;
        //displayBits(result);
        double currentPlace=16;
        double myPositiveToFill=32+d;
        result*=2;
        bitNumber+=1;
        while(bitNumber<=64){
            if(myPositiveToFill>=currentPlace){
                result+=1;
                myPositiveToFill-=currentPlace;
            }
            else{
                result+=0;
            }
            //displayBits(result);
            //printf("current bit number is %d. \n", bitNumber);
            //printf("current value of positiveToFill is %f. \n",myPositiveToFill);
            //printf("current place is %f. \n\n",currentPlace);
            if(bitNumber!=64){
                result*=2;
            }
            bitNumber+=1;
            currentPlace=currentPlace/2;
        }
        return result;
    }
}
void displayBits(long value){
    long displayMask=0x8000000000000000;
    printf("%10lu = ",value);
    for(long c=1;c<=64;++c){
        putchar(value & displayMask ? '1' : '0');
        value <<=1;
        if(c%8==0){
            putchar(' ');
        }
    }
    putchar('\n');
}