import java.math.*;
import java.util.*;

public class AlgoElastique extends Algo{

  private final double seuil = 0.01;
  private double k = 0.5; // requit de 1% toutes les n itération 
  private final double alpha = 0.5, beta = 1.8, cst = 200, n = 1;
  private final int nbPointElastique, itMax = 8000;
  private Point [] villes;
  protected PointElastique [] elastique; // points de l'élastique
  private Point cGravite; // centre de gravité de l'ensemble de points

  /**
     Constructeur de l'algo Elastique
     @param g le graphique
     @param avecAffichage affichage: oui ou non
   */
  public AlgoElastique(Graphe g,boolean avecAffichage){
    tabRes=new Arc[g.nbPoint];
    this.avecAffichage=avecAffichage;
    this.g=g;
    villes = g.tabPoint;
    nbPointElastique = (int)(2.5*g.nbPoint);
    tabDessin=new ArrayList();
    tCalcul=new Chrono();
    cGravite=initCGravite();
    initElastique();
  }


  /**
     Méthode lançant le calcul - l'algo
   */
  public void run(){
    double moyD,      // moyenne des delta
      rX, rY,    // resistance de l'elastique
      infX,infY, // influances des villes
      deltaX, deltaY;
    
    
    // ajout de la premiere etape à tabDessin
    if(avecAffichage){
	LinkedList l0 = new LinkedList();
	for( int i = 0 ; i < nbPointElastique ; ++i )
	    l0.add(new PointElastique(elastique[i].x,elastique[i].y));
	tabDessin.add(l0);
    }
    
    tCalcul.start(); //démarage du chrono
    for(int cpt = 1 ; cpt <= itMax ; ++cpt){
      moyD  = 0.;
      //pour tout les sommets de l'elastique
      for( int j = 0 ; j < nbPointElastique ; ++j ){
	// force d'attraction des villes 
	infX = alpha*influanceX(j); 
	infY = alpha*influanceY(j);
	//resistance de l'élastique
	rX = resistanceX(j);
	rY = resistanceY(j);
	// calcul de la moyenne
	deltaX = infX + rX;
	deltaY = infY + rY;
	if( deltaX < 0 ) moyD += -deltaX;
	else moyD += deltaX;
	if( deltaY < 0 ) moyD += -deltaY;
	else moyD += deltaY;
	// translation du point de l'elastique
	elastique[j].translate(deltaX,deltaY);
      }
      
      
      moyD /= (nbPointElastique*2);
      if( moyD < seuil )
	  cpt = itMax+1;
      
      // diminution de k
      if( (cpt % n) == 0 ) k -= (k/10);             
      
      // ajout d'une etape au dessin si on veut l'affichage
      if(avecAffichage){
	  LinkedList l = new LinkedList();
	  for( int i = 0 ; i < nbPointElastique ; ++i ){
	      l.add(new PointElastique(elastique[i].x,elastique[i].y));
	  }
	  tabDessin.add(l);        
      }
    }
    tCalcul.stop();
    if(!avecAffichage){
	LinkedList l = new LinkedList();
	for( int i = 0 ; i < nbPointElastique ; ++i ){
	    l.add(new PointElastique(elastique[i].x,elastique[i].y));
	}
	tabDessin.add(l);
    }
  }

  /**
     Methode de calcul du centre de gravité en fonction des point du graphe
     @return le centre de gravité
  */
  public Point initCGravite(){
    
    // init a partir de centre du repere
    Point cGravite = new Point(0,0);
    
    for( int i = 0 ; i < g.nbPoint; ++i ){
      cGravite.x += g.tabPoint[i].x;
      cGravite.y += g.tabPoint[i].y;
    }
    cGravite.x/= g.nbPoint ;
    cGravite.y/= g.nbPoint ;
    return cGravite ;
  }
  
  /**
     Calcul de la fonction phi
     @param d distance entre 2 points
     @return phi
  */
  private double phi(double d){
    d/= cst;
    return Math.exp( -(d*d)/ (2*k*k) );
  }
  
  /**
     Methode d'initialisation de l'elastique    
  */
  private void initElastique(){
    int rayon = 100; // rayon du cercle
    double a = 2*Math.PI/nbPointElastique; // angle entre chaque point
    elastique = new PointElastique [nbPointElastique];
    
    for( int i = 0 ; i < nbPointElastique ; ++i ){ 
      // calcul des coordonnées
      elastique[i] = new PointElastique((rayon*Math.cos(a*i)+cGravite.x),
					(rayon*Math.sin(a*i)+cGravite.y));         
    }
  }

   
  
    /**
     * Methode de normalisation de l'influance des villes
     * @param une ville
     * @param un point de l'elastique
     */
     private double w(int i, int j ){
        
       double d = Point.calcDist(villes[i],elastique[j]); // distance entre i et j
       double res = phi( d );
       double div =  0.;
       
       for(int ind = 0 ; ind < nbPointElastique ; ++ind){
	   d =Point.calcDist(villes[i],elastique[ind]);  //Distance entre i et ind
	   div += phi(d);
       }
       if(div!=0)
	 return res/div;
       else return 0.;
     }
    
    /**
     * Metode de calcule de l'influance des villes sur un point de l'elastique
     * @param un point de l'elastique
     * @return la valeur de cette force
     */ 
    private double influanceX(int j){
        double res = 0.;
        
        for( int i = 0 ; i < g.nbPoint ; ++i ){
            double d = villes[i].x - elastique[j].x ;           
            res += w(i,j)*d;            
        }
        
        return res;
    }
 
     /**
      * @see influanceX
      */
     private double influanceY(int j){
         double res = 0.;
         
         for( int i = 0 ; i < g.nbPoint ; ++i ){
             double d = villes[i].y - elastique[j].y;
             res += w(i,j)*d;
         } 
         return res ;
     }
    
      
     
     /**
      * Methode de calcul de la resistance de l'elastique
      * @param un point de l'elastique
      * @return la force de resistance
      */
     private double resistanceX(int j){
         double res;
         int t;
         if( j == 0 ) t = nbPointElastique-1;
         else t = j-1;
         res = beta*k*(elastique[(j+1)%nbPointElastique].x - 2 * elastique[j].x + elastique[t].x) ;           
         return res;
     }
     
     /**
      * @see resistanceX
      */
      private double resistanceY(int j){
         double res;
         int t;
         if( j == 0 ) t = nbPointElastique-1;
         else t = j-1;       
         res = beta*k*(elastique[(j+1)%nbPointElastique].y - 2 * elastique[j].y + elastique[t].y) ;               
         return res;
     }
}
