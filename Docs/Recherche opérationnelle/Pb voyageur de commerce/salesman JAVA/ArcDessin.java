public class ArcDessin{
    
    protected int p1;
    protected int p2;
    protected double distance;
    protected boolean detruire;
    
    public ArcDessin(Arc a,boolean d){
	this.p1=a.p1;
	this.p2=a.p2;
	this.distance=a.distance;
	this.detruire=d;
    }
    
    public ArcDessin(ArcDessin a,boolean d){
	this.p1=a.p1;
	this.p2=a.p2;
	this.distance=a.distance;
	this.detruire=d;
    }

    public void setDetruire(boolean d){
	this.detruire=d;
    }

    public String toString(){
	return "{"+p1+" à "+p2+"}";
    }
  
}
