#include<stdio.h>

/*********************** definition des structures *************/
#define NOEUD struct _noeud
#define ARC struct _arc
#define GRAPHE struct _graphe
#define CHEMIN struct _chemin
/***************************************************************/

/***************************************************************/
NOEUD
{ 
  char *nom;//le nom de la tache 
  int marque; 
  int taille;//le nombre de successeurs
  int n_x;int n_y;//la position de la tache sur l'ecran
  int ES;//date debut au plus tot
  int EF;//date fin au plus tot
  int LF;//date fin au plus tard
  int LS;//date debut au plus tard
  int ML;//marge libre
  int MT;//marge total
  ARC *debut; 
  NOEUD *suivant;   
};
/************************** structure ARC ***********************/
ARC
 { //correspond au contrainte
   NOEUD *noeud;//pointeur sur la tache suivante
   int cout;//duree d'une tache
   ARC *suivant;//pointeur sur les successeurs
 };
/*********************** structure GRAPHE *********************/
GRAPHE
{ //ponteur sur la tache debut (la tache vertuelle
  NOEUD *debut;
  int n_noeuds;//le nombre des sommets
  int duree;//la duree totale minimale
};
/*********************** structure CHEMIN  **********************/
CHEMIN
{//
 NOEUD *noeud;//pointeur sur la tache
 int cout;//le cout cummulatif
 CHEMIN *suivant;//le chemin suivant
};
/***************************************************************/
