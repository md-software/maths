#include <conio.h>
#include <string.h>
#include <stdlib.h>
#include "graphe.h"
#include "dessin.h"

/** declaration des noms de fichier **/
char * nomfile[17]={"0.txt","1.txt","2.txt","3.txt"};
char nomfichier[70];
int nbrfichier=4;
/*** chemin pour le calcul des dates ***/
int longueur= 0;
CHEMIN *plus_long=NULL;
/*** chemin critiqye ***/
int longueur2= 0;
CHEMIN *plus_long2=NULL;

/******************** fonction pour creer un nouvaeu noeud ****************/
NOEUD * nouveau_noeud( char *nom)
{  /*  Fait une demande de r‚servation d'espace m‚moire */
   NOEUD *noeud= (NOEUD *) malloc(sizeof(NOEUD));
  if (noeud != NULL) /* si l'allocation est reussie */
  { noeud->nom= strdup(nom);
    if (noeud->nom != NULL) /* si l'affectation est reussie */
     {    /* instanciation de la tache */
       noeud->debut= NULL; noeud->suivant= NULL;
       noeud->marque=0; noeud->taille=0;
       noeud->n_x=0; noeud->n_y=0;  noeud->ES=0;   noeud->EF=0;
       noeud->LF=0; noeud->LS=0;  noeud->ML=0;   noeud->MT=0;
     }
     else // si l'affectation n'est pas reussie
     { free(noeud); noeud= NULL;
       // libŠre le bloc m‚moire dans le tas externe allou‚ au noeud
     }
  } return noeud;
}

/************** fonction elementaire d'insertion d'une tache ****************/
NOEUD * insere_noeud(GRAPHE *graphe, NOEUD *noeud)
{ NOEUD * ptr;
 if(!graphe->debut) graphe->debut=noeud; // si le graphe n'est pas vide
  else  //sinon
   { ptr=graphe->debut;
       // pour se positionner au dernier noeud de la liste des taches
     while(ptr->suivant) ptr=ptr->suivant;
     ptr->suivant=noeud; // insertion du noeud a la fin
   }
  noeud->suivant= NULL;  // le noeud ajouter pointe sur NULL
  return noeud;
}

/******** fonction envoie un noeud s'il exite un pointeur NULL sinon ********/
NOEUD * trouve_noeud( GRAPHE *graphe, char *nom)
{
  NOEUD *noeud; // pour le parcours de la listes des taches
  for (noeud= graphe->debut; noeud != NULL; noeud= noeud->suivant)
    //si elle trouve le noeud elle arrete le parcours
  if (strcmp(nom, noeud->nom) == 0) break;
  return noeud;
}

/***** fonction principale de l'ajout d'une tache … la liste des taches *****/
NOEUD * ajoute_noeud(GRAPHE *graphe, char *nom)
{  //tester si la tƒche est d‚j… ajouter
  NOEUD *noeud= trouve_noeud(graphe, nom);
  if (noeud == NULL)  // si la tache est inconue
  { noeud= nouveau_noeud(nom); // allouer de la m‚moire
    if (noeud != NULL)        // si l'allocation est reussie
     { graphe->n_noeuds++;  // incr‚menter le nombre des taches du graphe
       return insere_noeud(graphe, noeud);
     }       // retourner la tache ins‚r‚e
  }
  return noeud;
}

/***************** fonction pour ajouter une contrainte ******************/
void  ajoute_arc(NOEUD *depart, NOEUD *arrivee, int cout)
{
  ARC *arc= (ARC *) malloc(sizeof(ARC));// allocation de m‚moire
  if (arc != NULL)  // si l'allocation est r‚ussie
   { arc->noeud= (NOEUD *) arrivee; // pointer sur la tache puit
     arc->cout=cout;  // affecter le cout a l'arc
     // l'ajout se fait dans le debut de la liste des arcs(successeurs)
     arc->suivant= depart->debut;
     depart->debut= arc;
     depart->taille++;
     //incr‚menter le nombre des succ‚sseurs de la "tache" source
   }
}

/********** efface la tache intermidiare pour la saisie du graphe *********/
GRAPHE * ok_graphe(GRAPHE *G)
{  // pointeurs pour le parcours de la liste des taches
   NOEUD * ptr1,* ptr2;
   ARC * str; // pointeur pour le parcours des listes des arcs
   ptr1=G->debut; // initialisations
   ptr2=G->debut->suivant->suivant;
   // se positionner … la fin de la liste
   while(ptr1->suivant) ptr1=ptr1->suivant;
   while(ptr2)// tant que c'est pas la fin de la liste des taches
   { //parcours de la liste des successeurs de la tache point‚e par ptr2
     str=ptr2->debut;
     while(str->suivant)
     // la liste des arcs n'est pas encore atteinte
     str=str->suivant;
     str->noeud=ptr1;       //c'est lors de la saisie du graphe qu'on comprend
      ptr2=ptr2->suivant;   //l'utilit‚ de cette proc‚dure
   } //ecraser la tache fictive qui ‚tait au d‚but
   G->debut=trouve_noeud(G,"DEBUT");
   G->n_noeuds-=1; // incr‚menter le nombre de taches du graphe
   return G;
}
/******** fonctions auxiliares pour le calcul des dates  ***********/
/********************************************************************/

/******** fonction auxiliare1 pour le calcul des dates  ***********/
//elle copie le chemin lu comme argument dans le chemin d‚finie en haut
// de page comme variable globale elle est appel‚e par la fonction cl‚
//de tout se projet.Qui consite aux calcul r‚cursif des dates et chemin
//critique
void copie_chemin(const CHEMIN *chemin)
{ longueur= 0;
  while (chemin){ plus_long[longueur]=*chemin;
  chemin= chemin->suivant;longueur++; }}

/******* fonction auxilliare2 pour le calcul des dates ***************/
void traite_chemin(const CHEMIN *chemin)
{  if (longueur ==0 || chemin->cout > plus_long->cout)
   //appel de la fonction pr‚c‚dente
   copie_chemin(chemin);
}

/******** fonction principale et jocker pour tout le projet *************/

//le calcul est r‚cursif utilis‚ pour toutes les fonctions des dates
//qui suivent. elle  calcule le plus long chemin entre de taches donn‚s
//en argument dont la tache de depart est "depart" et celle de l'arriv‚e
//est "arrivee".
void  tous_chemins( GRAPHE *graphe, NOEUD *depart,
NOEUD *arrivee, CHEMIN *chemin, int cout)
{
  CHEMIN etape; //structure de type CHEMIN sert comme chemin fictif ou test
  etape.noeud= depart;
  etape.suivant= chemin;///le chemin de d‚part doit etre NULL
  etape.cout= cout;///on commencera normalement par un cout =0
  //si on arrive a la tache puit
  if (depart==arrivee)//copier le chemin parcouru dans long_chemin
  traite_chemin(&etape);
  else //sinon
  {
    ARC *arc;//pour le parcours des listes des arcs
    depart->marque= 1;//indiquer qu'on a pass‚ par ce sommet
    for (arc= depart->debut; arc != NULL; arc= arc->suivant)
    if (arc->noeud->marque == 0)
    // si la tache qui suit n'est pas marqu‚e faire le meme
    //traitement pour cette nouvelle tache.mais le cout augmente
    //par arc->cout et le nouveau chemin n'est que etape
    tous_chemins(graphe, arc->noeud, arrivee,&etape,cout + arc->cout);
    depart->marque= 0;//c'est obligatoire pour un eventuel chemin critique
    //s'il existe et la recursivit‚ continue c'est assez simpa comme
    //m‚thode.sans se casser avec l'algorithme de Djikstra qui est
    //limit‚ pour les co–ts positifs et pour les plus court chemin
    //on avait une autre possibilit‚ c'est celui de Ballman Kalaba....
  }
}

/*************************** fonction elementaire ************************/
//pour effacer le chemin global pour une ‚ventuelle utilisation
void efface_chemin()
{ //nouveau chemin vide
   plus_long=NULL;
   longueur=0;
}

/****************** date au plus t“t (ES) *********************************/
int date_tot(GRAPHE * graphe,char *nom)
{  //avant de faire le traitement on doit actualiser notre chemin de stockage
   efface_chemin();
   //calcule de la plus longue dur‚e entre le d‚but de l'ordonnancement
   //et la tache donn‚e … la fonction on argument.
   tous_chemins(graphe,trouve_noeud(graphe,"DEBUT"),
   trouve_noeud(graphe,nom),NULL, 0);
   return plus_long[0].cout;
}

/****************** date totale minimale du problŠme  *********************/
int date_min(GRAPHE * graphe)
{  efface_chemin();
   longueur2=0;plus_long2=NULL;
   //calcule de la plus longue dur‚e entre le d‚but de l'ordonnancement
   //et sa fin.
   tous_chemins(graphe,trouve_noeud(graphe,"DEBUT"),
   trouve_noeud(graphe,"FIN"),NULL, 0);
   //le chemin global plus_long2 pour stocker le chemin global
   //avant qu'il soit utilis‚ par une autre fonction
   plus_long2=plus_long;longueur2=longueur;
   return plus_long2[0].cout;
}

/**************************** date au plus tard (LS)**************************/
int date_tard(GRAPHE * graphe,char *nom)
{ //pour stocker la date minimale de l'ordonnacemet car la date au plus tard
  //n'est que la date critique moins (-) la dur‚e maximal entre la tache et
  //la fin de l'ordonnancement en question
  int T=date_min(graphe);
  efface_chemin();
  tous_chemins(graphe,trouve_noeud(graphe,nom),
  trouve_noeud(graphe,"FIN"),NULL, 0);
  return (T-plus_long[0].cout);
}

/************* calcul de la marge libre d'une tƒche (ML)**********************/
//ML(i)=inf_j(ES(j)-EF(i)) tel que j suit i
int marge_libre(NOEUD * noeud)
{   //pointeur pour le parcours de la liste des arcs dans la tƒche
  ARC *ptr;//encapsul‚e dans noeud est la source
  int min_ES_j;//entier stockera inf(ES(j)) tel que j suit i
  ptr=noeud->debut;//initialiser ptr au debut de la liste des successeurs
  min_ES_j=ptr->noeud->ES;//initialiser min_ES_j … ES du premier successeur
  while(ptr->suivant)//tant qu'il existe de successeurs
  {//si ES du successeur n'est pas la plus petite
   if(min_ES_j>ptr->noeud->ES)
   //actualiser min_ES_j
   min_ES_j =ptr->noeud->ES;
   //passer au successeur suivant
   ptr=ptr->suivant;
  }
  return (min_ES_j-noeud->EF);
}

/**** fonction qui attribue a chaque tƒche les dates de l'ordonnancement ****/
GRAPHE * dates(GRAPHE * graphe)
{ //pointeur pour le parcours de la liste des tƒches
  NOEUD * noeud;
  noeud=graphe->debut;//initialis‚ au debut
  while(noeud)//tant qu'il reste des taches a examiner
  {//appels aux fonctions ‚l‚mentaires
   noeud->ES=date_tot(graphe,noeud->nom);//date debut au plus t“t
   noeud->LS=date_tard(graphe,noeud->nom);//date debut au plus tard
   noeud->EF=noeud->ES+noeud->debut->cout;//date fin au plus t“t
   noeud->LF=noeud->LS+noeud->debut->cout;//date fin au plus tard
   noeud->MT=noeud->LS-noeud->ES;//la marge Totale
   noeud=noeud->suivant;
  } //pour la marge Libre
  noeud=graphe->debut;
  while(noeud)
  { //la marge libre
    noeud->ML=marge_libre(noeud);
    noeud=noeud->suivant;
  } //cette boucle nous'est obligatoire car on ne connait pas tous les ES
    //des taches qui suivent la tƒche i.sinon il faut reflechir a une
    //procedure recursive
  return  graphe;
}

/********* procedure de dessin des sommets representants les tƒches *********/
void dessine_sommets(GRAPHE*graphe)
{ //entiers pour distribution des tƒches sur l'ecran
  int j=1, k=0,l=1;
  NOEUD * ptr=graphe->debut->suivant;//pour le parcours de la liste des tƒches
  setfillstyle(1,9);//le style de remplissage
  while(ptr->suivant)
   { if(j%4==0)
      { k+=80;     //pour la distribution des tƒches
	j=1;
      }
     if(l%8==0)
      l=1;        //pour la distribution des tƒches
     ptr->n_x=100+k;//determine les positions des tƒches
     ptr->n_y=70+40*(l+j);
     fillellipse(ptr->n_x,ptr->n_y,15,15);//dessin des taches sous forme
     //de cercles remplits en couleur BLUE
     outtextxy(95+k,67+40*(l+j),ptr->nom);
     j++; l++;  ptr=ptr->suivant;//passer … la tƒche suivante
   }

}

/******** procedure dessine les arcs repr‚sentants les contraintes *********/
void  dessine_arcs(GRAPHE * graphe)
{   //pour le parcours de la liste des tƒches
    NOEUD * noeud=graphe->debut;
    ARC *arc;//pour le parcours des
    char*msgf;//pour l'affichage des dur‚es
    setcolor(15);
    while(noeud)
    { //parcours de la liste des successeurs
      for (arc= noeud->debut; arc!= NULL; arc= arc->suivant)
      {//si la tƒche n'a qu'un seul
       if(noeud->taille==1)
	{//dessin des arcs entre les # tƒches
	  dessine_fleche(noeud->n_x+10,noeud->n_y+9,
			  arc->noeud->n_x-10,arc->noeud->n_y-7,4,80);
	  itoa(arc->cout,msgf,10);//voila les dur‚es
	  outtextxy((3*(noeud->n_x+10)+ arc->noeud->n_x-10)/4,
		    (3*(noeud->n_y+9)+arc->noeud->n_y-7)/4,msgf);
	}//sinon
       else
	if(arc->noeud!=trouve_noeud(graphe,"FIN"))
	 { //aussi les couts
	   itoa(arc->cout,msgf,10);
	   outtextxy((3*(noeud->n_x+10)+ arc->noeud->n_x-10)/4,
		     (3*(noeud->n_y+9)+arc->noeud->n_y-7)/4,msgf);
	   dessine_fleche(noeud->n_x+10,noeud->n_y+9,
			   arc->noeud->n_x-10,arc->noeud->n_y-7,4,80);
	 }
       } //au suivant
	   noeud= noeud->suivant;
    }
}

/******************** procedure dessine le ghraphe *************************/
void dessine_graphe(GRAPHE*graphe)
{  //pointeur pour le parcours de la liste des tƒches
   NOEUD * ptr=graphe->debut->suivant;
   while(ptr->suivant)
   ptr=ptr->suivant;//pour avoirla position du derniŠre tƒche
   ptr->n_x=550; ptr->n_y=420;
   graphe->debut->n_x=20;//ici celle du debut
   graphe->debut->n_y=173;
   setfillstyle(1,9);//les deux cercles des tƒches debut et fin
   fillellipse( graphe->debut->n_x, graphe->debut->n_y,20,12);
   fillellipse( ptr->n_x, ptr->n_y,25,15);
   outtextxy(3,171,"DEBUT"); 
   outtextxy(538,417,"FIN");
   dessine_sommets(graphe);
   dessine_arcs(graphe);
}

/******************** saisie du graphe a partir d' 1 fichier ***************/ 
GRAPHE * lecture_graphe()
{  //demande d'allocation dynamique de memoire
  GRAPHE *graphe=  (GRAPHE *) malloc(sizeof(GRAPHE));
  NOEUD *n1, *n2;//2 pointeurs pour le parcours
  FILE *entree;//le flus a etuliser
  int cout=0;//la duree d'une tache
  //la chine nom contient toute l'information lue a partir d'une ligne du fichier
  //nom1,nom2 et cout_ch sont extraits de la chaine nom et representent resp.
  //le nom de la tache la contrainte et la duree 
  char *nom,*nom1,*nom2,*cout_ch;
  if (graphe != NULL)
   { //si l'allocation est reussie
     graphe->debut= NULL;//creer graphe vide
     graphe->n_noeuds= 0;
     ajoute_noeud(graphe,"Ï");//ajout du noeud fictif a supprimer a l'aide de la
     //fonction ok_graphe(*)
     ajoute_noeud(graphe,"DEBUT");//ajouter la tache fictive "DEBUT"
     randomize();//appeler le generateur des entiers naturels
     strcpy(nomfichier,nomfile[random(nbrfichier)]);//saisie aleatoire du fichier
     entree = fopen(nomfichier,"r") ;//ouvertur du fichier
      {//tant qu'on la saisie est reussie et on ait pas arriver a la fin du fichier 
        while(fscanf(entree,"%s",nom) != EOF)
        if (nom != NULL)//si la ligne n'est pas vide
         { //lectures des donnes
           nom1 = strtok(nom, ",");
           cout_ch= strtok(NULL, ","); 
           cout=atoi(cout_ch);//convertion de la chaine lue en entier
           nom2 = strtok(NULL, ","); 
           n1= ajoute_noeud(graphe, nom1);//ajouter la tache du nom nom1
           ajoute_arc(n1,trouve_noeud(graphe,"Ï"),cout);//ajout du contrainte
           if(!nom2)//s'il y a une contrainte 
           ajoute_arc(trouve_noeud(graphe,"DEBUT"),n1,0);
           do
            { 
             if(nom2)//si la contrainte existe 
              {//ajouter la tache 2
               n2= ajoute_noeud(graphe, nom2);
               ajoute_arc(n2, n1,n2->debut->cout); 
               nom2 = strtok(NULL, ",");//passer a la nouvelle contrainte
              }
            }//si elle existe bien sur
           while(nom2);
          }//et fermer le flux ouvert
         fclose(entree);
       }
     }//a jouter enfin la tache vertuelle "FIN"
   ajoute_noeud(graphe,"FIN");
   dates(ok_graphe(graphe));//supprimer la tache test
   return graphe;//renvoyer le graphe

}
