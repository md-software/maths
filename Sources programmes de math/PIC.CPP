#include "stdlib.h"
#include "stdio.h"
#include "string.h"
#include "math.h"

#define PREC 5

unsigned long *dec;
FILE *stream;

/* Calcul des d‚cimales de PI */

int main(void)
{
	char fmt[10], fmtlast[10], ndecs[10], buf[10], fichier[40];
	unsigned long ndec, nmem, n, nb0, nb, i;
	unsigned long ni, nj, ad, m, z, k;
	double ss, s, s1, s2;
	double log2   = log10(2.0);
	double log_10 = log(10.0);

sprintf(fmt,"%%%02.2dlu ",PREC);

printf("\nNombre de d‚cimales: ");
gets(ndecs);
ndec = atoi(ndecs);
if ( strcmp(ndecs, "") == 0)
	exit(1);
if (ndec == 0)
	exit(1);

/* Calcul du nombre de boucles */
printf("Patience...\n");

nmem = ndec / PREC;
if ((ndec % PREC) != 0)
	nmem = nmem + 1;
/*
n = (long) (((double) (ndec + PREC)) * log_10);
ss = 0.0;
nb0 = 1;
do
{
	nb0++;
	ss = ss + log(2.0 + 1.0 / (double) nb0);
} while ((double) n > ss);
printf("\nNombre de boucles (0): %ld\n\n",nb0);
*/

s1 = 0.0;
s2 = 0.0;
nb = 1;
do
{
	nb++;
	s1 = s1 + log10(2*nb+1);
	s2 = s2 + log10(nb);
	s = s1 - s2 - log2;
} while ((double) ndec > s);
printf("\nNombre de boucles: %ld\n\n",nb);

/* Initialisations */

if ( (dec = (unsigned long near *) malloc((nmem+1) * sizeof(long))) == 0)
	{
	printf("Not enough memory\n");
	exit(1);
	}


dec[1] = 1;
for (i = 0; i < PREC; i++)
	dec[1] = dec[1] * 10;

ni = dec[1];
nj = ni * 10;
ad = 2 * ni;

/* Calcul des d‚cimales */

for (n = nb; n >= 1; n--)
	{
	if ( (nb-n+1) % (nb/10) == 0 )
		printf("%lu / %lu\n",nb-n+1,nb);

	m = 0;
	k = 2 * n + 1;
	for (i = 1; i <= nmem; i++)
		{
		z = dec[i] + m;
		dec[i] = z / k;
		m = (z % k) * ni;
		}
	m = 0;
	for (i = nmem; i >= 2; i--)
		{
		dec[i] = dec[i] * n + m;
		m = dec[i] / ni;
		dec[i] = dec[i] % ni;
		}
	dec[1]=dec[1] * n + m;
	m = dec[i] / nj;
	dec[1] = (dec[1] % nj) + ad;
	}

/* Affichage des d‚cimales */
sprintf(fichier,"i:\\michel\\math\\PI_%d.txt",ndec);
stream = fopen(fichier,"w+");
printf("%s %d\n",fichier,stream);

m = (long) (dec[1] / ni);
dec[1] = dec[1] % ni;
printf("\n\t*** PI avec %lu d‚cimales ***\n\n %lu, ",ndec,m);
fprintf(stream,"\n\t*** PI avec %lu d‚cimales ***\n\n %lu, ",ndec,m);

for ( i = 0; i < (nmem * PREC) - ndec; i++)
	dec[nmem] = dec[nmem] / 10;
sprintf(fmtlast,"%%%02.2dlu ",PREC - (nmem * PREC) + ndec);

n = 0;
for (i = 1; i <= nmem; i++)
	{
	if ( n == 80/(PREC+2) )
		{
		n = 0;
		printf("\n    ");
		fprintf(stream,"\n    ");
		}
	if (i == nmem)
		{
		printf(fmtlast,dec[i]);
		fprintf(stream,fmtlast,dec[i]);
		}
	else
		{
		printf(fmt,dec[i]);
		fprintf(stream,fmt,dec[i]);
		}
	n = n + 1;
	}
fclose(stream);

printf("\n");
gets(buf);
}




