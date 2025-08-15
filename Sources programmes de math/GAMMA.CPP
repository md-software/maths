#include "stdlib.h"
#include "stdio.h"
#include "math.h"

int main ()
{
	unsigned long i;
	double s,reste;

s=0.0;
reste=0;
for (i=1; i <= 100000000; i++)
	{
	s=s+1.0/((double) i);
	if ( (i % 1000000) == 0 )
		{
		printf("Euler (%9.9ld): %20.20g %20.20g\n",
			i,s-log((double) i),reste-s+log((double) i));
		reste=s-log((double) i);
		}
	}
}