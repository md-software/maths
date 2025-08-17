import java.util.*;
/**
   Algorithme de deux-échange
*/
public class Algo2opt extends Algo{
    
  AlgoPpv ppv;
    
    /**
       Constructeur de l'algo
       @param g le graphe sur lequel on applique l'algo
       @param avecAffichage affichage: oui ou non
    */
    public Algo2opt(Graphe g,boolean avecAffichage){
	ppv=new AlgoPpv(g,avecAffichage);
	ppv.run();
	this.avecAffichage=avecAffichage;
	this.g=g;
	tabDessin=ppv.tabDessin;
	tabRes=ppv.tabRes;
	tCalcul=new Chrono();
    }
    
    /**
       Méthode lançant le calcul
    */
    public void run(){
	
	boolean isEchange=true;
	tCalcul.start(); //Début chrono
	
	while(isEchange){
	    isEchange=false;
	    for(int i=0;i<g.nbPoint-1;++i)
		for(int j=i+2;j<g.nbPoint;++j)
		    {
			if(ppv.tabRes[i].distance+ppv.tabRes[j].distance
			   >
			   g.calcDist(ppv.tabRes[i].p1,ppv.tabRes[j].p1)+g.calcDist(ppv.tabRes[i].p2,ppv.tabRes[j].p2)
			   ){
			    inverse(i,j);
			    isEchange=true;
			}
		    }
	}
	tCalcul.stop();
	if(!avecAffichage){ // On veut juste l'affichage final
	    tabDessin=new ArrayList();
	    for(int l=0;l<tabRes.length;++l){
		tabDessin.add(new ArcDessin(tabRes[l],false));
	    }
	}
    }
    
  /**
     fonction qui inverse les arcs i et j
     @param i l'arc i
     @param j l'arc j
   */
  public void inverse(int i,int j)
    {
	Arc tmpArc;
	int tmpInt;
	int k=1;
	int milieu=(j-i)/2;

	//pour dessin
	if(avecAffichage){
	tabDessin.add(new ArcDessin(tabRes[i],true));
	tabDessin.add(new ArcDessin(tabRes[j],true));
	}
	//Swap i,j
	tmpInt=ppv.tabRes[i].p2;
	ppv.tabRes[i]=new Arc(ppv.tabRes[i].p1,
			      ppv.tabRes[j].p1,
			      g.calcDist(ppv.tabRes[i].p1,ppv.tabRes[j].p1));
	ppv.tabRes[j]=new Arc(tmpInt,
			      ppv.tabRes[j].p2,
			      g.calcDist(tmpInt,ppv.tabRes[j].p2));

	//Pour le dessin
	if(avecAffichage){
	tabDessin.add(new ArcDessin(tabRes[i],false));
	tabDessin.add(new ArcDessin(tabRes[j],false));
	}
	
	//Inverse les arrête entre i et j
	while(k < milieu)
	    {
		tmpArc=ppv.tabRes[i+k];
		ppv.tabRes[i+k]=ppv.tabRes[j-k];
		ppv.tabRes[j-k]=tmpArc;
		swapPoint(ppv.tabRes[i+k]);
		swapPoint(ppv.tabRes[j-k]);
		++k;
	    }
	if((j-i)%2==0)
	    swapPoint(ppv.tabRes[(j+i)/2]);
	else
	  {
	      ++k;
	      tmpArc=ppv.tabRes[i+k];
	      ppv.tabRes[i+k]=ppv.tabRes[j-k];
	      ppv.tabRes[j-k]=tmpArc;
	      swapPoint(ppv.tabRes[i+k]);
	      swapPoint(ppv.tabRes[j-k]);  
	  }
    }

    /**
       inversion des points d'un arc
       @param a l'arc
    */
    public void swapPoint(Arc a)
    {
	int tmp;
	tmp=a.p1;
	a.p1=a.p2;
	a.p2=tmp;
    }

    
    /**
       Méthode toString de l'algo 2-Opt
       @return représentation sous forme de chaine du resulat de l'algo
    */
    public String toString(){
	String tmp="\n Resultat 2-Opt: \n\n";
	
	for(int i=0;i<g.nbPoint;++i)
	    {
		tmp=tmp+ppv.tabRes[i]+" => ";
	    }
	return tmp;
    }	
    
}
