import java.util.Random;
/**
   Classe représentant un point
*/
public class Point
{
    protected int  x,y;
    public Point(){}
    
    /**
       Construit le point
       @param xx coordonnée en x
       @param yy coordonnee en y
    */
    public Point(int xx,int yy){
	x=xx;
	y=yy;  
    }

    /**
       Méthode calculant la distance entre deux points
       @param p le point distant de l'objet
       @return la distance
    */
    public double calcDist(Point p){
	return Math.sqrt((x-p.x)*(x-p.x)+(y-p.y)*(y-p.y));
    }
    
    /**
       Méthode statique calculant la distance entre deux points
       @param p1 le premier point
       @param p2 le deuxième point
       @return la distance
    */
    public static double calcDist(Point p1,Point p2){
	return Math.sqrt((p1.x-p2.x)*(p1.x-p2.x)+(p1.y-p2.y)*(p1.y-p2.y));
    }

    /**
       Méthode statique calculant la distance entre deux points
       @param p1 le premier point
       @param p2 le deuxième point de l'elastique
       @return la distance
    */
    public static double calcDist(Point p1,PointElastique p2){
	return Math.sqrt((p1.x-p2.x)*(p1.x-p2.x)+(p1.y-p2.y)*(p1.y-p2.y));
    }
   
    /**
       Méthode statique qui génère un point aléatoirement
       @param r Un objet Random
       @param xMax la valeur maximum sur x
       @param ymax la valeur maximum sur y
       @return un point
    */
    public static Point randomPoint(Random r,int xMax,int yMax){
	Point p=new Point();
	p.x=r.nextInt(xMax);
	p.y=r.nextInt(yMax);
      return p;
    }

  /**
     
   */
  public void translate(int dx,int dy){
    this.x+=dx;
    this.y+=dy;
  }
    /**
       @return la coordonnée en x
    */
    public int getX(){
	return this.x;
    }
    /**
      @return la coordonnée en y 
    */
    public int getY(){
	return this.y;
    }
    
    /**
       @return une chaine représentant l'objet
    */
    public String toString(){
	return new String("("+x+","+y+")");
    }
}

