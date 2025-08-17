#include "stdlib.h"
#include "stdio.h"
#include "time.h"
#include "math.h"

#define DMAX 50

typedef double T_MATRICE[DMAX][DMAX];

double determinant(int n, T_MATRICE a)
{
	double det;
	double c,z,e;
	int m,r,i,j;

if (n == 1)
	det = a[0][0];
else
	{
	c = 1;
	for (r = 0; r < n - 1; r++)
		{
		z = fabs(a[r][r]);
		m = r;
		for (i = r+1; i < n; i++)
			if (fabs(a[i][r]) >= z)
				{
				z = fabs(a[i][r]);
				m = i;
				}
		if (z < 1.e-8)
			return 0;
		if (m != r)
			c = -c;
		for (j = 0; j < n; j++)
			{
			e = a[m][j];
			a[m][j] = a[r][j];
			a[r][j] = e;
			}
		for (i = r+1; i < n; i++)
			{
			a[i][r] = a[i][r] / a[r][r];
			for (j = r+1; j < n; j++)
				a[i][j] = a[i][j] - a[i][r]*a[r][j];
			}
		}
	if (fabs(a[n-1][n-1]) < 1.e-8)
		return 0;
	det = 1;
	for (i = 0; i < n; i++)
		det = det*a[i][i];
	det = det*c;
	}

return det;
}

int main()
{
	int i,j;
	T_MATRICE a;
	int n;
	char buf[80];

printf("\nDimension de la matrice: ");
gets(buf);
n = atoi(buf);
if ((n > 0) && (n <= DMAX))
{
randomize();
for (i=0; i < n; i++)
{
for (j=0; j < n; j++)
	printf("%f ",(a[i][j] = (double) random(1000)));
printf("\n");
}

printf("Le d‚terminant vaut: %f\n",determinant(n,a));
gets(buf);
}
}