import java.util.*;
/**
   Représentation d'un Graphe (ensemble de points)
*/
public class Graphe{

  Point[] tabPoint; //ensemble des points
  double[][] tabDist; //Matrice des distances
  int  nbPoint; //Nombre de points
  int xMax;
  int yMax;
  int typeOptimisation;
    
    /**
       Constructeur
       @param nbP le nombre de point du graphe
       @param xMax la valeur maximam d'un point sur x
       @param yMax la valeur maximam d'un point sur y
       @param typeOptimisation le type d'optimisation
    */
  public Graphe(int nbP,int xMax,int yMax,int typeOptimisation){
    nbPoint=nbP;
    this.xMax=xMax;
    this.yMax=yMax;

    this.typeOptimisation=typeOptimisation;

    tabPoint=new Point[nbPoint];
    
    randTabPoint();
    
    if(typeOptimisation==1)
    {
      tabDist=new double[nbPoint][nbPoint];
      calcTabDist();
    }
  }

  /**
     Constructeur pour changer le type d'optimisation
     @param g l'ancien graphe
     @param typeOptimisation le type d'optimisation
   */
  public Graphe(Graphe g, int typeOptimisation){
    new Graphe(g.nbPoint,g.xMax,g.yMax,typeOptimisation);
  }
  
    /**
       Construit aléatoirment les points
    */
  public void randTabPoint(){
    Random r=new Random();

    for(int i=0;i<nbPoint;++i)
    {
      Point tmp=Point.randomPoint(r,xMax,yMax);
      while(isAllreadyPresent(tmp))
	  tmp=Point.randomPoint(r,xMax,yMax);
      tabPoint[i]=tmp;
    }    
  }
    
    /**
       Cherche si un point est déjà dans le graphe
       @param p le point p
       @return vrai si le point est déjà dans le graphe, faux sinon
    */
    public boolean isAllreadyPresent(Point p){
	int i=0;
	while(tabPoint[i]!=null){
	    if(p.getX()==tabPoint[i].getX())
		if(p.getY()==tabPoint[i].getY())
		    return true;
	    ++i;
	}
	return false;
    }


    /**
       Calcul la table des distances
    */
    public void calcTabDist(){
	for(int i=0;i<nbPoint;++i)
	    for(int j=0;j<nbPoint;++j)
		tabDist[i][j]=tabPoint[i].calcDist(tabPoint[j]);
    }

  
  /**
     Calcul de la distance entre 2 points de l'arc
     @param i Indice du premier point
     @param j Indice du deuxième point
     @return la distance entre les deux points
   */
  public double calcDist(int i,int j){
    if(typeOptimisation==1)
      return tabDist[i][j];
    else
      return tabPoint[i].calcDist(tabPoint[j]);
  }

  
    /**
       Méthode to String
       @return représentation sous forme de chaine de l'objet
    */
  public String toString(){
    String tmp="GRAPHE: \n";

    for(int i=0;i<nbPoint;++i)
      tmp=tmp+"Point "+i+" : "+tabPoint[i]+"\n";

    tmp=tmp+"\n\nTableau des DISTANCES: \n";

    for(int i=0;i<nbPoint;++i)
    {
      tmp=tmp+"\n Point "+i+" ->";

      for(int j=0;j<nbPoint;++j)
	tmp=tmp+tabDist[i][j]+" - ";
    }
    return tmp;
  }

  
}

