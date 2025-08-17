/*	CE PROGRAMME CALCULE JUSQU'A 15000 DECIMALES DE PI A L'AIDE DE
	LA FORMULE DE MACHIN:

			PI=16*ARCTG(1/5)-4*ARCTG(1/239)

	CHAQUE ARCTG EST LA SOMME DES Vn AVEC

			Vn=(-1)^n/((2*n+1)*X^(2*n+1))

	X VALANT RESPECTIVEMENT 5 ET 239. CHAQUE TERME Vn EST OBTENU PAR
	RECURRENCE SUIVANT LES FORMULES:

			V0   = 1/X
			Vn+1 = [(-1)*(2*n+1)/((2*n+3)*X*X)]*Vn.

	LES CALCULS SONT FAITS EN MULTIPRECISION. LA CONTRAINTE DUE A LA
	LIMITATION DES ENTIERS SUR 32 BITS FAIT QUE LES CALCULS DES DEUX
	ARCTG SONT FAITS DIFFEREMMENT DANS UN SOUCI D'OPTIMISATION.

	LES CALCULS SONT FAITS SUR DES ENTIERS SIGNES, DONC ON UTILISE
	LES 31 BITS DE CES NOMBRES. LA BASE DE NUMERATION UTILISEE EST
	1 000 000 JUSQU'A 1500 DECIMALES ET 100 000 JUSQU'A 15 000
	DECIMALES CECI POUR EVITER DE DEPASSER LES 31 BITS IMPOSES.
	IL Y A DONC UNE BAISSE DE PERFORMANCE AU DELA DE 1500 DECIMALES.


	fichier pim.c  Andre' Brouty (CNRS / ENST de Bretagne) decembre 1987

	[ http://www-info.enst-bretagne.fr/~brouty/Maths/pi.html ]    */


int *resul;	/* TROIS TABLEAUX DYNAMIQUES CONTENANT RESPECTIVEMENT */
int *resul1;	/* LE RESULTAT FINAL ET LES RESULTATS INTERMEDIAIRES   */
int *resul2;
int lim;	/* NOMBRE DE DECIMALES DEMANDEES */
int K;		/* POUR GERER LES CASES NULLES */
int MAX;	/* DIMENSION DES TABLEAUX */
int BASE;	/* BASE DE NUMERATION CORRESPOND AU GROUPEMENT DES CHIFFRES */
int GBASE;	/* NOMBRE DE GROUPEMENT DES CHIFFRES POUR LA SORTIE */
int I, J;	/* NOMBRE D'ITERATIONS POUR CHAQUE ARCTG */

#include <string.h>

#define SIZE_T          (size_t)

main(argc,argv)
int argc;
char *argv[];

{
	int k, i, NB;
	if(argc-1)
		lim=atoi(argv[1]);
	else {
		printf("Nombre de decimales souhaitees ( <= 15000): ");
		scanf("%d",&lim);
	}
	if(lim <= 1500) {
		BASE=1000000;
		NB=6;
		GBASE=10;
	}
	else {
		if(lim > 15000) {
			printf("Pas plus de 15000 decimales merci.\n");
			exit(0);
		}
		BASE=100000;
		NB=5;
		GBASE=12;
	}
	MAX=3+lim/NB;
	resul=(int *)malloc(4*MAX);
	resul1=(int *)malloc(4*MAX);
	resul2=(int *)malloc(4*MAX);
	memset((char *)resul1,0,SIZE_T 4*MAX);
	memset((char *)resul2,0,SIZE_T 4*MAX);
	memset((char *)resul,0,SIZE_T 4*MAX);
	I=arctg_5(resul1,5);
	memcpy((char *)resul2,(char *)resul,SIZE_T 4*MAX);
	memset((char *)resul,0,SIZE_T 4*MAX);
	J=arctg_239(resul1,239);
	K=0;
	sous(resul2,resul);
	printf("\n Decimales affichees: %d  nombre d'iterations: %d , %d (%d)\n",NB*(MAX-2),I,J,I+J);
	putchar('\n');
	todec(resul2);
}

todec(tab)	/* CONVERSION EN DECIMAL */
int tab[];

{
	register i;
	int a;
	int BS10 = BASE/10;
	printf("pi = %d,",tab[0]);
	for(i=1;i<MAX-1;++i) {
		a=tab[i];
		a = a == 0 ? 1 : a;
		while(a < BS10) {
			putchar('0');
			a=10*a;
		}
		printf("%d%s",tab[i],i%GBASE ? " " : "\n       ");
	}
	putchar('\n');
}

add(a,b)	/* ADDITION DE DEUX TABLEAUX DE NOMBRES */
int a[], b[];

{
	register i, r=0;		/* r EST LA RETENUE */
	for(i=MAX-1;i >= K;--i) {
		r=a[i]+r+b[i];
		if(r >= BASE) {
			a[i]=r-BASE;
			r=1;
		}
		else {
			a[i]=r;
			r=0;
		}
	}
	while(r) {	/* PROPAGATION DE LA RETENUE */
		r=a[i]+r;
		if(r >= BASE) {
			a[i]=r-BASE;
			r=1;
		}
		else {
			a[i]=r;
			r=0;
		}
		--i;
	}
}

sous(a,b)	/* SOUSTRACTION DE DEUX TABLEAUX DE NOMBRES. LE SIGNE DU */
int a[], b[];	/* RESULTAT EST SUPPOSE POSITIF				 */

{
	register i, r=0;
	for(i=MAX-1;i >= K;--i) {
		r=a[i]-r-b[i];
		if(r < 0) {
			a[i]=r+BASE;
			r=1;
		}
		else {
			a[i]=r;
			r=0;
		}
	}
	while(r) {	/* PROPAGATION DE LA RETENUE */
		r=a[i]-r;
		if(r < 0) {
			a[i]=r+BASE;
			r=1;
		}
		else {
			a[i]=r;
			r=0;
		}
		--i;
	}
}

mul(tab,n)     /* MULTIPLICATION D'UN TABLEAU DE NOMBRES PAR UN ENTIER POSITIF*/
int tab[], n;

{
	register i, S=0;
	for(i=MAX-1;i>=K;--i) {
		tab[i]=tab[i]*n+S;
		S=tab[i]/BASE;
		tab[i] = tab[i]%BASE;
	}
	tab[i]=tab[i]*n+S;
	while((S=tab[i])>=BASE) {
		tab[i-1] = tab[i-1] + S/BASE;
		tab[i] = S%BASE;
		--i; --K;
	}
	--K;
	while(tab[K] == 0) ++K;
}

divisi(t,n)	/* DIVISION D'UN TABLEAU DE NOMBRES PAR UN ENTIER */
int t[], n;

{
	register a, i;
	a=t[K];
	for(i=K;i<MAX;++i) {
		t[i]=a/n;
		a=BASE*(a%n)+t[i+1];
	}
	while(t[K] == 0) ++K;	/* GESTION DES CASES NULLES */
}

arctg_239(tab,p)	/* 4*arctg(1/p) POUR p DE L'ORDRE DE GRANDEUR DE 239 */
int tab[], p;

{
	register i;
	K=0;
	tab[0]=4;
	divisi(tab,p);
	add(resul,tab);
	for(i=0;K < MAX;++i) {
		divisi(tab,(2*i+3));
		divisi(tab,p);/*ON FAIT 2 DIVISIONS SUCCESSIVES AU LIEU D'UNE*/
		divisi(tab,p);/*POUR EVITER DE DEPASSER LES 31 BITS          */
		mul(tab,(2*i + 1));
		(i+1)%2 ? sous(resul,tab) : add(resul,tab);
	}
	return(i);
}

arctg_5(tab,p)	/* 16*arctg(1/p) POUR p DE L'ORDRE DE GRANDEUR DE 5 */
int tab[], p;

{
	register i;
	K=0;
	tab[0]=16;
	divisi(tab,p);
	add(resul,tab);
	p=p*p;
	for(i=0;K < MAX;++i) {
		divisi(tab,(2*i+3));
		divisi(tab,p);/*ICI p EST TROP PETIT POUR RISQUER DE DEPASSER */
		mul(tab,(2*i + 1));/*LES 31 BITS.                             */
		(i+1)%2 ? sous(resul,tab) : add(resul,tab);
	}
	return(i);
}
