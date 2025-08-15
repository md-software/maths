#include "stdio.h"
#include "stdlib.h"
#include "math.h"

#define SGN(x) ( ((x) >= 0 ) ? 1 : -1 )
#define TEST_NUL(x)  if ( fabs((x)) < 1e-6 ) (x) = 0

double a,b,c,d,e;
double a0,b0,c0,d0,e0;

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

printf("e: ");
gets(buf);
e = atof(buf);
e0 = e;
}

double det_neg(double p, double q)
{
	double r;
	double t;

r = sqrt(-p/3);
if ( fabs(r) < 1.e-6 )
	t = a/6;
else
	{
		double rho,teta;

	rho = - q/(2*r*r*r);
	teta = (M_PI_2 - atan(rho/sqrt(1-rho*rho))) / 3.0;
	t = 2*r*cos(teta) + a/6.0;
	}

return t;
}

double det_pos(double de, double q)
{
	double u,v;

u = sqrt(de) - q/2.0;
v = - u - q;
if (u != 0)
	u = SGN(u) * pow((u*SGN(u)),(double) (1.0/3.0));
if (v != 0)
	v = SGN(v) * pow((v*SGN(v)),(double) (1.0/3.0));

return (u + v + a/6.0);
}

double pol(double x)
{
return (a0*x*x*x*x+b0*x*x*x+c0*x*x+d0*x+e0);
}

void afficher_racines(double aa, double bb, double hh)
{
	double de;

de = aa*aa - 4*bb;
TEST_NUL(de);
if (de >= 0)
	{
	de = sqrt(de);
	printf("%f (%f)\n",(-aa+de)/2 + hh, pol((-aa+de)/2 + hh));
	printf("%f (%f)\n",(-aa-de)/2 + hh, pol((-aa-de)/2 + hh));
	}
else
	{
	de = sqrt(-de)/2;
	printf("%f + %f I\n",(-aa/2+hh),de);
	printf("%f - %f I\n",(-aa/2+hh),de);
	}
}

void calculer_racines(void)
{
	double t,m,n,de;
	double h,p,q;

h = -b/(4*a);
a = c/a0 - 6*h*h;
b = d/a0 + 4*h*h*h + 2*h*a;
c = e/a0 - h*h*(a+h*h) + b*h;
p = -c - (a*a)/12.0;
q = -a*a*a/108.0 - a*c/6.0 + (4*a*c - b*b)/8.0;
de = p*p*p/27.0 + q*q/4.0;
TEST_NUL(de);

if (de <= 0)
	t = det_neg(p,q);
else
	t = det_pos(de,q);

TEST_NUL(t);

m = -sqrt(2*t-a);
if ( m == 0 )
	n = 0;
else
	n = b/(2*m*m);

a = -m;
b = t + m*n;
afficher_racines(a,b,h);

a = m;
b = t - m*n;
afficher_racines(a,b,h);

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