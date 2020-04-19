#include "math.h"
#include "stdio.h"

void quad1(float);

quad1(float a,float b,float c)
{
double aval,bval,cval,ans;

ans = (-b + sqrt((b*b)-4*a*c))/(2*a);
return(ans);
}