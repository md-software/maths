/**
   Classe représentant un Arc (arrete entre deux point)
*/

public class Arc{
    
    protected int p1;
    protected int p2;
    protected double distance;
    
    /** 
	Constructeur d'un arc nul
    */
    public Arc(){
	this.p1=0;
	this.p2=0;
	this.distance=0;
    }
    
    /**
       Constructeur
       @param p1 le premier point
       @param p2 le deuxième point
       @param d la distance entre ces deux points
    */
    public Arc(int p1,int p2,double d){
	this.p1=p1;
	this.p2=p2;
	this.distance=d;
    }

    /**
       retoune le point 1
       @return l'indice du point 1
    */
    public int getP1(){
	return p1;
    }

    /**
       retoune le point 2
       @return l'indice du point 2
    */
    public int getP2(){
	return p2;
    }
    
    /**
       Méthode toString de l'arc
       @return une chaine représentant l'objet
    */
    public String toString(){
	return "{"+p1+" à "+p2+" -dist: "+distance+"}";
    }
    
}

