/*	CE PROGRAMME EST ASSOCIE AU PROGRAMME pim2 DE CALCUL DES DECIMALES
	DE PI. IL SERT A VERIFIER QUE LES DECIMALES DE PI CALCULEES EN BASE 2
	SONT CORRECTES. POUR CELA IL PREND EN ENTREE UN FICHIER CONTENANT
	LES DECIMALES DE PI EN BASE 2 ET LES PASSE EN BASE 10.

	POUR LE COMPILER IL FAUT CHOISIR LA TAILLE DES MOTS MEMOIRE
	QU'ACCEPTE LA MACHINE, ICI 32 OU 64 BITS.

	cc -o verifpib2 -DS64BITS verifpib2.c
	cc -o verifpib2 -DS32BITS verifpib2.c

	Usage verifpib2 [-dec] [fichier-pi-base-2]

	fichier verifpib2.c		Andre Brouty	mars 1996	*/

#include <stdio.h>

#ifdef S64BITS  			/* MACHINE CALCULANT SUR 64 BITS */
#define	TypInt	long			/* TYPE DE LA DONNEE TRAITEE	*/
#define NBOCT   8			/* NOMBRE D'OCTETS SUR 64 BITS	*/
#define BASE1	1000000000000000000L	/* BASE DE LA NUMERATION UTILISEE*/
#define NB1	18			/* NOMBRE DE ZEROS DE BASE1	*/
#define GBASE1	4			/* GROUPEMENT POUR LA SORTIE	*/
#define LIMP3   100000000		/* LIMITE IMPOSEE		*/
#endif

#ifdef S32BITS				/* MACHINE CALCULANT SUR 32 BITS */
#define	TypInt	long			/* TYPE DE LA DONNEE TRAITEE	*/
#define NBOCT   4			/* NOMBRE D'OCTETS SUR 32 BITS	*/
#define BASE1	1000000000L		/* BASE DE LA NUMERATION UTILISEE*/
#define NB1	9			/* NOMBRE DE ZEROS DE BASE1	*/
#define GBASE1	7			/* GROUPEMENT POUR LA SORTIE	*/
#define LIMP3	10000000		/* LIMITE IMPOSEE		*/
#endif

#define LOGb10_2 0.30103/* LOG BASE 10 DE 2 POUR CONVERSION EN DECIMAL	*/

TypInt *resul;	/* DEUX TABLEAUX DYNAMIQUES CONTENANT RESPECTIVEMENT */
TypInt *resul1;	/* LE RESULTAT FINAL ET LE RESULTAT INTERMEDIAIRE    */

int lim;	/* NOMBRE DE DECIMALES DEMANDEES */
int K;		/* GESTION DES CASES NULLES: INDICE DE LA 1ERE CASE NON NULLE */
int MAX;	/* DIMENSION DES TABLEAUX */
TypInt BASE;	/* BASE DE NUMERATION CORRESPOND AU GROUPEMENT DES CHIFFRES */
int GBASE;	/* NOMBRE DE GROUPEMENT DES CHIFFRES POUR LA SORTIE */


main(argc,argv)
int argc;
char *argv[];

{
	char nam[256];
	nam[0] = 0;
	--argc; ++argv;
	lim = 0;
	while(argc) {
		switch(*argv[0]) {
			case '-':
				lim = atoi(argv[0] + 1);
				break;
			default:
				strcpy(nam,argv[0]);
				break;
		}
		--argc; ++argv;
	}
	if(lim == 0) {
		printf("Nombre de decimales souhaitees ( <= %d): ",LIMP3);
		scanf("%d",&lim);
	}
	if(nam[0] == 0) {
		printf("Fichier a examiner: ");
		scanf("%s",nam);
	}
	if(lim > LIMP3) {
		printf("Pas plus de %d decimales merci.\n",LIMP3);
		exit(0);
	}
	BASE=BASE1;
	GBASE=GBASE1;
	MAX=3+(TypInt)(LOGb10_2*(double)lim/(double)(NB1));
	resul=(TypInt *)malloc(NBOCT*MAX);
	resul1=(TypInt *)malloc(NBOCT*MAX);
	Verif(nam,lim);
}

todec(tab,n)	/* CONVERSION EN DECIMAL */
TypInt tab[];
int n;

{
	register i;
	TypInt a;
	TypInt BS10 = BASE/10;
	MAX=1 + (int)(LOGb10_2*(double)n/(double)(NB1));
	printf("\nDecimales en base 10 affichees: %d ( E[(log 2)*%d/%d]*%d )\n\n",NB1*(MAX - 1),n,NB1,NB1);
	for(i=1;i<MAX;++i) {
		a=tab[i];
		a = a == 0 ? 1L : a;
		while(a < BS10) {
			putchar('0');
			a=10*a;
		}
		printf("%lu%s",tab[i],i%GBASE ? " " : "\n");
	}
	putchar('\n');
}

add(a,b)	/* ADDITION DE DEUX TABLEAUX DE NOMBRES */
TypInt a[], b[];

{
	register i;
	TypInt register r=0;		/* r EST LA RETENUE */
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

divisi(t,n)	/* DIVISION D'UN TABLEAU DE NOMBRES PAR UN ENTIER */
TypInt t[], n;

{
	register i;
	TypInt register a;
	a=t[K];
	for(i=K;i<MAX;++i) {
		t[i]=a/n;
		a=BASE*(a%n)+t[i+1];
	}
	while(t[K] == 0) ++K;	/* GESTION DES CASES NULLES */
	return(K);
}

Verif(fich,nb)
char *fich;
int nb;

{
	int i, un, zero;
	FILE *fp;
	char Buf[256];
	memset((char *)resul1,0, NBOCT*MAX);
	memset((char *)resul,0, NBOCT*MAX);
	if((fp = fopen(fich,"r")) == NULL) {
		fprintf(stderr,"Pas de fichier %s, verif terminee\n",fich);
		return(0);
	}
	K = 0;
	un = 0;
	zero = 0;
	resul1[0] = 1;
	while(fgets(Buf,255,fp) != NULL) {
		i = 0;
		while(Buf[i]) {
			switch(Buf[i]) {
				case '1':
					divisi(resul1,2);
					add(resul,resul1);
					++un;
					break;
				case '0':
					divisi(resul1,2);
					++zero;
					break;
				case ' ':
				case 9  :
				case 10 :
				case 13 :
					break;
				default:
					fprintf(stderr,"Caractere lu: %c ce n'est pas un fichier de decimales de PI en base 2! Desole.\n",Buf[i]);
					exit(1);
			}
			if(un + zero >= nb)
				goto FIN;
			++i;
		}
	}
FIN:
	printf("\nNombre de uns lus: %d , de zeros: %d ( %d )\n",un,zero,un+zero);
	todec(resul,un+zero);
}
