#include "stdlib.h"
#include "stdio.h"
#include "math.h"

#define PI 3.141592653589793

int main ()
{
	unsigned long i;
	double s,PI26;

PI26=PI*PI/6.0;
s=0.0;
for (i=1; i <= 100000000; i++)
	{
	s=s+1.0/((double) i*i);
	if ( (i % 1000000) == 0 )
		{
		printf("Euler (%9.9ld): %20.20g %20.20g\n",
			i,s,PI26);
		}
	}
}