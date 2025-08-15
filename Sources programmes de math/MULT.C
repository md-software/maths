#include <stdlib.h>
#include <stdio.h>


unsigned long mult(int a, int b)
{
	unsigned long res;
	int i;

res = 0;

for (i = 0; i < 8*sizeof(int); i++)
	{
	res = res + a * (b & (1 << i));
        }

return res;
} 
void main()
{
	int a;
	int b;


printf("int : %d    long : %d\n",sizeof(int),sizeof(long));

a = 60000;
b = 60000;

printf("%d %lu\n",a+b,mult(a,b));

}
