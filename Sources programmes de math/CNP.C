
#include <stdlib.h>
#include <stdio.h>

#define MIN(x,y) ((x) < (y) ? (x) : (y))
#define MAX(x,y) ((x) > (y) ? (x) : (y))

unsigned long int cnp(n,p)
	int n;
	int p;
{
	unsigned long int Cnp;
	int i;
	int min,max;

min = MIN(n,p);
max = MAX(n,p);

Cnp = 1;

for(i = max-min+1; i < max+1; i++)
	{
	Cnp = Cnp * (unsigned long int) i;
	Cnp = Cnp / (unsigned long int) (i - max + min);
	}

return Cnp;
}

int main()
{
	int i;
	int j;

/*for (j = 1; j < 100; j++)*/
for (j = 49; j < 50; j++)
for (i = 1; i < 8; i++)
	printf("Cnp(%d,%d): %lu\n",j,i,cnp(j,i));

#ifdef vms
return 1;
#else
return 0;
#endif
}
