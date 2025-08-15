#include<graphics.h>
#include<math.h>

/*********************** initialiser le mode graphique ******************/
void ini_graph()
{ //predefini
  int gdrive=0,gmode;
  initgraph(&gdrive,&gmode,"");
  //initgraph initializes the graphics system by loading a graphics driver from
  //disk (or validating a registered driver) then putting the system into
//graphics mode.

}
/*********************** pour tracer l'arc orienté ***********************/
void dessine_fleche(int x1 , int y1 ,int x2 ,int y2 ,int d,double AB)
{ 
  int x3,x4,y3,y4;
  double a =0.3;//l'ouverture de la fleche
  //les 2 points crretes de la fleche
  x3 = ( d / AB )* ( ( x1 - x2 )* cos(a) - ( y1 - y2 )* sin( a) ) + x2;
  y3 = ( d / AB )* ( ( y1 - y2 )* cos(a) + ( x1 - x2 )* sin( a) ) + y2;
  x4 = ( d / AB )* ( ( x1 - x2 )* cos(a) + ( y1 - y2 )* sin( a) ) + x2;
  y4 = ( d / AB )* ( ( y1 - y2 )* cos(a) - ( x1 - x2 )* sin( a) ) + y2;
  //appel a la fonction line(,,,,) de la bibli
  line(x1,y1,x2,y2);
  line(x2,y2,x3,y3);
  line(x2,y2,x4,y4);
  }