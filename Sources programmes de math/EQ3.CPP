#include "stdio.h"
#include "stdlib.h"
#include "math.h"

#define SGN(x) ( ((x) >= 0 ) ? 1 : -1 )
#define TEST_NUL(x)  if ( fabs((x)) < 1e-6 ) (x) = 0

double a,b,c,d;
double a0,b0,c0,d0;

void saisie_poly(void)
{
	char buf[80];

printf("\nSaisie du polynome ax^4+bx^3+cx^2+dx+e\n");

printf("a: ");
gets(buf);
a = atof(buf);
a0 = a;

printf("b: ");
gets(buf);
b = atof(buf);
b0 = b;

printf("c: ");
gets(buf);
c = atof(buf);
c0 = c;

printf("d: ");
gets(buf);
d = atof(buf);
d0 = d;
}

double pol(double x)
{
return (a0*x*x*x+b0*x*x+c0*x+d0);
}

void det_neg(double p, double q)
{
	double r;
	double rho,teta;
	double x;

r = sqrt(-p/3);
if ( fabs(r) < 1.e-6 )
	teta = 0;
else
	{
	rho = - q/(2*r*r*r);
	teta = (M_PI_2 - atan(rho/sqrt(1-rho*rho))) / 3.0;
	}

x = 2*r*cos(teta) - b/(3*a);
TEST_NUL(x);
printf("%f\n",x);

x = 2*r*cos(teta + 2*M_PI/3) - b/(3*a);
TEST_NUL(x);
printf("%f\n",x);

x = 2*r*cos(teta + 4*M_PI/3) - b/(3*a);
TEST_NUL(x);
printf("%f\n",x);


}

void det_pos(double de, double q)
{
	double u,v;
	double alpha,beta;
	double y,re,im;

u = sqrt(de) - q/2.0;
v = - u - q;
if (u != 0)
	u = SGN(u) * pow((u*SGN(u)),(double) (1.0/3.0));
if (v != 0)
	v = SGN(v) * pow((v*SGN(v)),(double) (1.0/3.0));

alpha = u+v;
beta = alpha*alpha + 4*q/alpha;

y = alpha - b/(3*a);
TEST_NUL(y);
printf("%f\n",y);

re = y - 3*alpha/2.0;
im = sqrt(-beta)/2.0;
printf("%f + %f\n",re,im);
printf("%f - %f\n",re,im);
}


void calculer_racines(void)
{
	double de;
	double p,q;

p = c/a - b*b/(a*a*3.0);
TEST_NUL(p);

q = 2.0*b*b*b/(27.0*a*a*a) - b*c/(3.0*a*a) + d/a;
TEST_NUL(q);

de = p*p*p/27.0 + q*q/4.0;
TEST_NUL(de);

if (de <= 0)
	det_neg(p,q);
else
	det_pos(de,q);

}

int main(void)
{
	char buf[80];

do
	{
	saisie_poly();
	calculer_racines();
	printf("Autre calcul ? ");
	gets(buf);
	} while ( (buf[0] != 'n') && (buf[0] != 'N') );
}