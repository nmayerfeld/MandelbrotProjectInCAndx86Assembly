#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
extern int MBPixelCalc(double,double);
int main(int argc, char *argv[]){
    char *ptr1;
    char *ptr2;
    double d1=strtod(argv[1],&ptr1);
    double d2=strtod(argv[2],&ptr2);
    printf("MBPixelCalc() returned %d.\n", MBPixelCalc(d1,d2));
    return 0;
}
