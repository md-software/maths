#include"mouse.h"
#include"calcule.h"
/****************************/
GRAPHE *graphe= NULL;
/********************* declarations des prototypes ************************/
void page_0(int*,int*);
void page_1(int*,int*,GRAPHE*);
void page_2(int*,int*,GRAPHE*);
void page_3(int*,int*,GRAPHE*);
void page_4(int*,int*,GRAPHE*);

/********************************************************************/
void bri_carreau(int x,int y,int l,int L,int c1,int c2,int c3)
{  //dessin d'un carreau
   hide_mouse();//cacher la souris
   if(c3!=-1) //dessiner le milieur du carreau
    { setfillstyle(1,c3);
      bar(x,y,x+l,y+L);
    } //d' autres barres
   setfillstyle(1,c1);
   bar(x,y,x+l,y);
   bar(x,y,x,y+L);
   //changer le style du tracage
   setfillstyle(1,c2);
   bar(x,y+L,x+l,y+L);
   bar(x+l,y,x+l,y+L);
   show_mouse();//montrer la souris

}
/*******************************************************************/
//cette fonction dessine la case de sortie
void ferm_fen(int x,int y)
{  //cacher la souris
   hide_mouse();//appel a la fonction draw carreau
   bri_carreau(x,y,15,15,63,0,56);
   settextstyle(0,0,1);//changer le style
   setcolor(63);//choix de couleur
   outtextxy(x+4,y+4,"X");
}
/*******************************************************************/
void dernier_bar(int last,int next,int quitte)
{ //dessin du dernier barreau
  bri_carreau(1,459,getmaxx()-2,20,1,0,7);
  setcolor(0);
  if(last)
   {//si le boutton precedant est active
   outtextxy(20,465,"prec");
     bri_carreau(18,462,35,15,63,0,-1);
   }
  if(next)
   { //si le boutton ciuvant est active
     outtextxy(60,465,"suiv");
     bri_carreau(56,462,37,15,63,0,-1);
   }
  if(quitte)
   { //si le boutton quitter  est active
    outtextxy(557,465,"exit");
    bri_carreau(546,462,54,15,63,0,-1);
   }
}

/***********************************************************************/
//le premier carreau en haut
void premier_bar()
{ //cacher la souris
  hide_mouse();//changer le style du dessin
  setfillstyle(1,1);//dessiner 1 barre
  bar(1,1,getmaxx(),20);
  setfillstyle(1,7);//le choix de dessin
  bar(1,20,getmaxx(),35);//appel a la fonction du dessin
  //de la case a sortie
  ferm_fen(getmaxx()-20,3);
  outtextxy(200,7,"le probleme d'ordonnancement ");
  setcolor(0); //affichage du titre
  outtextxy(215,22,"-Methode des potentiels-");
  show_mouse();//montrer la souris
}
/***********************************************************************/
   //ces fonctions  font un test sur le movement de la souris
   //et son etat
/************************************************************************/

int testmouse(int x,int y,int l,int L,int* t)
{ //lire la position
  get_pos();
  if(sx>x&&sx<x+l&&sy>y&&sy<y+L&&(*t)==1)
   { //dessin du carreau en montrant l'effet clique
     bri_carreau(x,y,l,L,0,63,-1);
     (*t)=0;
   }
  if((sx<x||sx>x+l||sy<y||sy>y+L)&&(*t)==0)
   { //dessin d'anti carreau en montrant l'effet relache
     bri_carreau(x,y,l,L,63,0,-1);
     (*t)=1;
   }
   return 0;
}
/************************************************************************/
int testsouris0a(int x,int y,int l,int L,int *M,int *m)
{
  get_pos();
  if(sx>x&&sx<x+l&&sy>y&&sy<y+L&&button)
  page_1(M,m,graphe);
  return 0;
}
/************************************************************************/
int testsouris0b(int x,int y,int l,int L)
{
  get_pos();
  if(sx>x&&sx<x+l&&sy>y&&sy<y+L&&button)
  exit(0);
  return 0;
}
/************************************************************************/
int testsouris1a(int x,int y,int l,int L,int *M,int *m)
{
  get_pos();
  if(sx>x&&sx<x+l&&sy>y&&sy<y+L&&button)
  page_2(M,m,graphe);
  return 0;
}
/************************************************************************/
int testsouris1b(int x,int y,int l,int L,int *M,int *m)
{
  get_pos();
  if(sx>x&&sx<x+l&&sy>y&&sy<y+L&&button)
  page_0(M,m);
  return 0;
}
/************************************************************************/
int testsouris2a(int x,int y,int l,int L,int *M,int *m)
{
  get_pos();
  if(sx>x&&sx<x+l&&sy>y&&sy<y+L&&button)
  page_3(M,m,graphe);
  return 0;
}
/************************************************************************/
int testsouris2b(int x,int y,int l,int L,int *M,int *m)
{
  get_pos();
  if(sx>x&&sx<x+l&&sy>y&&sy<y+L&&button)
  page_1(M,m,graphe);
  return 0;
}
/************************************************************************/
int testsouris3a(int x,int y,int l,int L,int *M,int *m)
{
  get_pos();
  if(sx>x&&sx<x+l&&sy>y&&sy<y+L&&button)
  page_4(M,m,graphe);
  return 0;
}
/************************************************************************/
int testsouris3b(int x,int y,int l,int L,int *M,int *m)
{
  get_pos();
  if(sx>x&&sx<x+l&&sy>y&&sy<y+L&&button)
  page_2(M,m,graphe);
  return 0;
}
/************************************************************************/
int testsouris4a(int x,int y,int l,int L,int *M,int *m)
{
  get_pos();
  if(sx>x&&sx<x+l&&sy>y&&sy<y+L&&button)
  page_3(M,m,graphe);
  return 0;
}
/************************************************************************/
int testsouris4b(int x,int y,int l,int L,int *M,int *m)
{
  get_pos();
  if(sx>x&&sx<x+l&&sy>y&&sy<y+L&&button)
  page_0(M,m);
  return 0;
}

/************************************************************************/
void quitter(int x,int y,int l,int L)
{
  get_pos();
  if(sx>x&&sx<x+l&&sy>y&&sy<y+L&&button==1)
  exit(0);
}
/************************************************************************/
void dessine_rectangle(int i,int j)
{
  int s=0;
  char *nom,*nom1,*nom2,*cout_ch;
  FILE * fuchier;hide_mouse();
  fuchier = fopen(nomfichier,"r") ;
  while(j--&&fscanf(fuchier,"%s",nom) != EOF)
   {
    if (nom != NULL)
     { nom1 = strtok(nom, ",");
       cout_ch= strtok(NULL, ",");
       nom2 = strtok(NULL, "");}
       bri_carreau(1,110+s,getmaxx()-2,30,7,7,7);
       outtextxy(40,105+s+i/2,nom1);
       outtextxy(117,105+s+i/2,cout_ch);
       if(nom2)
       outtextxy(170,105+s+i/2,nom2);
       rectangle(17,110+s,85,110+i+s);
       rectangle(85,110+s,153,110+i+s);
       rectangle(153,110+s,273,110+i+s);
       s+=i;
     }
    show_mouse();
    fclose(fuchier);
}

/************************************************************************/
void dessine_grille(int i,GRAPHE *graf)
{
  int j;
  char *msen;
  int s=0;
  NOEUD * noeud=graf->debut->suivant;
  j=graf->n_noeuds-2;
  hide_mouse();
  while(j--)
  {
    bri_carreau(1,110+s,480,30,7,7,7);
    rectangle(17,110+s,85,110+i+s);
    outtextxy(30,107+s+i/2,noeud->nom);
    rectangle(85,110+s,153,110+i+s);
    itoa(noeud->debut->cout,msen,10);
    outtextxy(115,107+s+i/2,msen);
    rectangle(153,110+s,200,110+i+s);
    itoa(noeud->ES,msen,10);
    outtextxy(172,107+s+i/2,msen);
    rectangle(200,110+s,250,110+i+s);
    itoa(noeud->EF,msen,10);
    outtextxy(221,107+s+i/2,msen);
    rectangle(250,110+s,300,110+i+s);
    itoa(noeud->LF,msen,10);
    outtextxy(271,107+s+i/2,msen);
    rectangle(300,110+s,350,110+i+s);
    itoa(noeud->LS,msen,10);
    outtextxy(321,107+s+i/2,msen);
    rectangle(350,110+s,400,110+i+s);
    itoa(noeud->ML,msen,10);
    outtextxy(371,107+s+i/2,msen);
    rectangle(400,110+s,450,110+i+s);
    itoa(noeud->MT,msen,10);
    outtextxy(421,107+s+i/2,msen);
    s+=i;
    noeud=noeud->suivant;
  }
  show_mouse();
}

/*************************************************************************/
void  chemin_critique()
{
  int saut=53;
  char *nbro;
  int index;
  setcolor(9);
  setfillstyle(1,9);
  fillellipse(560,400,20,15);
  fillellipse(30,400,20,15);
  setcolor(15);
  outtextxy(550,398,"FIN");
  outtextxy(12,398,"DEBUT");
  line(50,400,538,400) ;
  outtextxy(55,390,"0");
  for(index=longueur2-2;index>0;index--)
  {
    setcolor(9);
    setfillstyle(1,9);
    fillellipse(30+saut,400,12,12);
    setcolor(15);
    outtextxy(25+saut,400,plus_long2[index].noeud->nom);
    saut+=53;
    itoa(plus_long2[index].noeud->debut->cout,nbro,10);
    outtextxy(saut,390,nbro);
  }
   setfillstyle(1,7);
   bar(200,425,400,445);setcolor(0);
   setcolor(0);
   outtextxy(240,430,"Chemin critique");
}
/*************************************************************************/

void dessine_gantt(int c,GRAPHE *G)
{
  char * msg;
  NOEUD*noeud;
  int s=0;
  int cont=date_min(G),T=cont;
  int a; int b=11; setcolor(c);
  dessine_fleche(70,300,570,300,4,200) ;
  dessine_fleche(70,300,70,300-(G->n_noeuds-2)*15,6,120) ;

  while(b--)
   {
     line(70+s,297,70+s,303);
     a=(int)((T*s)/500);
     itoa(a,msg,10);
     outtextxy(67+s,306,msg);
     s=s+50;

   }

  noeud=G->debut->suivant;
  s=12; cont=1;
  while(noeud->suivant)
  {
   setcolor(cont);
   line(70+(int)((noeud->ES)*500/T),300-s,70+(int)((noeud->ES+noeud->debut->cout)*500/T),300-s);
   setlinestyle(2,1,1);
   line(70+(int)((noeud->ES+noeud->debut->cout)*500/T),300-s,70+(int)(noeud->LF*500/T),300-s);
   setlinestyle(0,0,0);
   outtextxy(20,295-s,noeud->nom);
   noeud=noeud->suivant;
   cont++;if(cont==7)
   cont++;s+=12;
  }

}

/****************************************************************************/
void page_0(int *by,int * next)
{
  graphe=NULL;
  graphe=lecture_graphe();
  cleardevice();
  premier_bar();
  ini_mouse();
  bri_carreau(130,110,360,20,9,9,9);
  setcolor(15);
  outtextxy(170,117,"Plan du programme");
  setcolor(0);
  bri_carreau(130,130,360,120,7,7,7);
  outtextxy(170,150,"  I/ Position du probleme");
  outtextxy(170,170," II/ Representation par un graphe");
  outtextxy(170,190,"III/ Resolution du probleme");
  outtextxy(170,210," IV/ Diagramme de Gantt");
  dernier_bar(0,1,1);
  show_mouse();
  while(1)
   {
    testmouse(546,462,54,15,by);
    testmouse(56,462,37,15,next);
    testsouris0a(56,462,37,15,by,next);
    testsouris0b(546,462,54,15);
    quitter( getmaxx()-20,3,15,15);
   }
}

/*************************************************************************/
void page_1(int * last,int * next,GRAPHE* G)
{
  cleardevice();
  premier_bar();
  ini_mouse();
  setcolor(0);
  bri_carreau(1,40,200,15,9,9,9);
  setcolor(15);
  outtextxy(5,45,"I/ Position du probleme");
  bri_carreau(1,60,getmaxx()-2,110,7,7,7);
  setcolor(0);
  outtextxy(10,64,"Exemple : ");
  outtextxy(85,64,nomfichier);
  setfillstyle(1,0);
  bar(10,78,160,74);
  outtextxy(27,95,"Taches");
  outtextxy(100,95,"Duree");
  outtextxy(170,95,"Contraintes");
  dessine_rectangle(15,G->n_noeuds-2);
  dernier_bar(1,1,0);
  show_mouse();
  while(1)
    {
     testmouse(18,462,35,15,last);
     testmouse(56,462,37,15,next);
     testsouris1a(56,462,37,15,last,next);
     testsouris1b(18,462,35,15,last,next);
     quitter( getmaxx()-20,3,15,15);
    }
}

/**************************************************************************/
void page_2(int * last,int * next,GRAPHE * G)
{
  cleardevice();
  premier_bar();
  ini_mouse();
  setcolor(0);
  bri_carreau(1,40,265,15,9,9,9);
  setcolor(15);
  outtextxy(5,45,"II/ Representation par un graphe");
  bri_carreau(1,60,175,25,7,7,7);
  setcolor(0);
  outtextxy(10,64,"Exemple : ");
  outtextxy(85,64,nomfichier);
  setfillstyle(1,0);
  bar(10,78,160,74);
  setcolor(15);
  dessine_graphe(G);
  setcolor(0);
  dernier_bar(1,1,0);
  show_mouse();
  while(1)
   {
    testmouse(18,462,35,15,last);
    testmouse(56,462,37,15,next);
    testsouris2a(56,462,37,15,last,next);
    testsouris2b(18,462,35,15,last,next);
    quitter( getmaxx()-20,3,15,15);
   }
}
/**************************************************************************/
void page_3(int * last,int * next,GRAPHE* G)
{
  char * mezage;
  cleardevice();
  premier_bar();
  ini_mouse();
  setcolor(0);
  bri_carreau(1,40,225,15,9,9,9);
  bri_carreau(1,60,480,110,7,7,7);
  setcolor(0);
  outtextxy(10,64,"Exemple : ");
  outtextxy(85,64,nomfichier);
  setfillstyle(1,0);
  bar(10,78,160,74);
  outtextxy(27,95,"Taches");
  outtextxy(100,95,"Duree");
  outtextxy(170,95,"ES");
  outtextxy(220,95,"EF");
  outtextxy(270,95,"LF");
  outtextxy(320,95,"LS");
  outtextxy(370,95,"ML");
  outtextxy(420,95,"MT");
  dessine_grille(15,G);
  setfillstyle(1,7);
  bar(0,130+15*(G->n_noeuds-2),481,130+15*(G->n_noeuds-2)+20);
  outtextxy(40,135+15*(G->n_noeuds-2),"La duree totale minimale est T = ");
  itoa(date_min(G),mezage,10);
  outtextxy(300,135+15*(G->n_noeuds-2),mezage);
  setcolor(15);
  outtextxy(5,45,"III/ Resolution du probleme");
  chemin_critique();
  setcolor(0);
  dernier_bar(1,1,0);
  show_mouse();
  while(1)
   {
     testmouse(18,462,35,15,last);
     testmouse(56,462,37,15,next);
     testsouris3a(56,462,37,15,last,next);
     testsouris3b(18,462,35,15,last,next);
     quitter( getmaxx()-20,3,15,15);
   }
}

/************************************************************************/
void page_4(int * next,int *last,GRAPHE*G)
{
  cleardevice();
  premier_bar();
  ini_mouse();
  setcolor(0);
  bri_carreau(1,40,183,15,9,9,9);
  bri_carreau(1,60,637,300,7,7,7);
  setcolor(0);
  outtextxy(85,64,nomfichier);
  setfillstyle(1,0);
  bar(10,78,160,74);
  dessine_gantt(0,G);
  dernier_bar(1,0,0);
  setcolor(0);
  outtextxy(557,465,"menu");
  outtextxy(10,64,"Exemple : ");
  setcolor(15);
  outtextxy(5,45,"VI/ Diagramme de Gantt");
  show_mouse();
  while(1)
   {
    testmouse(18,462,35,15,next);
    testmouse(546,462,54,15,last);
    testsouris4a(18,462,35,15,next,last);
    testsouris4b(546,462,54,15,next,last);
    quitter( getmaxx()-20,3,15,15);
   }
}