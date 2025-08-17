/* ========================================================================== */
/*                                                                            */
/*   pi3.c                                                                    */
/*   (c) 2009 MD                                                              */
/*                                                                            */
/*   Description                                                              */
/*                                                                            */
/* ========================================================================== */

#include <stdio.h>

//long a=10000,b=0,c=2800,d,e=0,f[2801],g; // 800 décimales
//long a=10000,b,c=8400,d,e,f[8401],g; // 2400 décimales
//long a=10000,b,c=35000,d,e,f[35001],g; // 10000 décimales
//long a=10000,b,c=56000,d,e,f[56001],g; // 16000 décimales
//unsigned long int a=10000,b,c=113400,d,e,f[113401],g; // 32400 décimales
unsigned long int a=10000,b,c=3500000,d,e,f[3500001],g; // 1000000 décimales

int main()
{
for (;b-c;)
   f[b++]=a/5;

for (;d=0,g=c*2;c-=14,printf("%.4d",e+d/a),e=d%a)
   for (b=c;d+=f[b]*a,f[b]=d%--g,d/=g--,--b;d*=b);

return 0;
}
