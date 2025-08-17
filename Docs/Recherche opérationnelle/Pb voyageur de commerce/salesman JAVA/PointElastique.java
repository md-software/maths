import java.awt.geom.*;

public class PointElastique extends Point2D.Double{
  
    public PointElastique(double x, double y){
	super(x,y);
    }
    
    public void translate(double dx,double dy){
	this.x+=dx;
	this.y+=dy;
    }
    
    /**
       Méthode statique calculant la distance entre deux points
       @param p1 le premier point
       @param p2 le deuxième point
       @return la distance
    */
    public static double calcDist(PointElastique p1,PointElastique p2){
	return Math.sqrt((p1.x-p2.x)*(p1.x-p2.x)+(p1.y-p2.y)*(p1.y-p2.y));
    }
    
}
