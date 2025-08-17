import java.util.*;

/**
   Algorithme du récuit simulé
*/

public class AlgoRecuit extends Algo{

    Algo ppv; // Circuit de départ
    Arc[] circuitS;
  //Arc[] circuitS0;
    
    /**
       Constructeur
       @param g le graphe sur lequel l'algorithme doit être appliqué
       @param avecAffichage affichage: oui ou non
    */
    public AlgoRecuit(Graphe g,boolean avecAffichage){
	ppv=new AlgoPpv(g,avecAffichage);
	ppv.run();
	this.avecAffichage=avecAffichage;
	tabRes=ppv.tabRes;
	tabDessin=ppv.tabDessin;
	this.g=g;
	tCalcul=new Chrono();

	circuitS=new Arc[tabRes.length];
	for(int i=0;i<tabRes.length;++i){ // Copie du tableau
	    circuitS[i]=new Arc();
	    circuitS[i].p1=tabRes[i].p1;
	    circuitS[i].p2=tabRes[i].p2;
	    circuitS[i].distance=tabRes[i].distance;
	}
    }


    /**
       Méthode run lançant le calcul
    */
    public void run(){
      int essais=g.nbPoint*g.nbPoint;
	int i,j;
    
	double epsilon=0.00001;
	double deltaC;
	double mu=0.75;
	double t=40;//Math.sqrt(g.nbPoint)/0.8;
	Random r=new Random();
	
	tCalcul.start();
	while(t>epsilon){
	  for(int etape=0;etape<essais;++etape){
	    i=r.nextInt(g.nbPoint); 
	    do{
	      j=r.nextInt(g.nbPoint-1);
	    }while(j==(i+1)%g.nbPoint || j==(g.nbPoint+i-1)%g.nbPoint || j==i);
	    
	    deltaC=gain(i,j); // calcul du gain

	    if(deltaC<=0){
	      if(i<j)
		inverse(i,j);
	      else
		inverse(j,i);
	    }
	    else{
	      if(r.nextDouble()<Math.exp(-deltaC*Math.sqrt(g.nbPoint)/t)){
		if(i<j)
		  inverse(i,j);
		else
		  inverse(j,i);
	      }
	    }
	  }
	  t=mu*t;
	}
	tCalcul.stop();
	tabRes=circuitS;
	if(!avecAffichage){//On veut juste l'affichage final
	  tabDessin=new ArrayList();
	  for(int k=0;k<tabRes.length;++k)
	    tabDessin.add(new ArcDessin(circuitS[k],false));
	}
    }


    /**
       Méthode de copie d'un circuit
       @param oldC un circuit
       @param c le circuit a copié dans oldC
       
    */
    public void copieCircuit(Arc[] oldC,Arc[] c){
	for(int i=0;i<tabRes.length;++i){ // Copie du tableau
	    oldC[i].p1=c[i].p1;
	    oldC[i].p2=c[i].p2;
	    oldC[i].distance=c[i].distance;
	}
    }
    
    /**
       Méthode qui calcul la distance totale d'un circuit c
       @param c le circuit dont on veut calculer la distance
       @return la distance totale du circuit
    */
    public double distTotale(Arc[] c){
	double dist=0;
	
	for(int i=0;i<c.length-1;++i){
	    dist+=c[i].distance;
	}
	return dist;
    }

  /**
     Méthode de calcul du gain d'un échange
     @param i le premier arc
     @param j le second arc
     @return le gain obtenu
   */
  public double gain(int i, int j){
    return  (g.calcDist(circuitS[i].p1,circuitS[j].p1)+g.calcDist(circuitS[i].p2,circuitS[j].p2))
      - (circuitS[i].distance+circuitS[j].distance);
  }
  
    /**
       fonction qui inverse les arcs i et j
       @param i l'indice du premier arc
       @param j l'indice du deuxième arc
    */
    public void inverse(int i,int j)
    {
	Arc tmpArc;
	int tmpInt;
	int k=1;
	int milieu=(j-i)/2;
	
	//pour dessin
	if(avecAffichage){
	tabDessin.add(new ArcDessin(circuitS[i],true));
	tabDessin.add(new ArcDessin(circuitS[j],true));
	}
	//Swap i,j
	tmpInt=circuitS[i].p2;
	circuitS[i]=new Arc(circuitS[i].p1,
			      circuitS[j].p1,
			      g.calcDist(circuitS[i].p1,circuitS[j].p1));
	circuitS[j]=new Arc(tmpInt,
			      circuitS[j].p2,
			      g.calcDist(tmpInt,circuitS[j].p2));
	
	//Pour le dessin
	if(avecAffichage){
	    tabDessin.add(new ArcDessin(circuitS[i],false));
	    tabDessin.add(new ArcDessin(circuitS[j],false));
	}
	//Inverse les arrête entre i et j
	while(k < milieu)
	    {
		tmpArc=circuitS[i+k];
		circuitS[i+k]=circuitS[j-k];
		circuitS[j-k]=tmpArc;
		swapPoint(circuitS[i+k]);
		swapPoint(circuitS[j-k]);
		++k;
	    }
	if((j-i)%2==0)
	    swapPoint(circuitS[(j+i)/2]);
	else
	  {
	      ++k;
	      tmpArc=circuitS[i+k];
	      circuitS[i+k]=circuitS[j-k];
	      circuitS[j-k]=tmpArc;
	      swapPoint(circuitS[i+k]);
	      swapPoint(circuitS[j-k]);  
	  }
    }

    /**
       inversion des points d'un arc
       @param a l'arc a inverser
    */
    public void swapPoint(Arc a)
    {
	int tmp;
	tmp=a.p1;
	a.p1=a.p2;
	a.p2=tmp;
    }


    /**
       Méthode toString de l'algo Récuit Simulé
       @return une chaine représentant l'objet
    */
    public String toString(){
	String tmp="\n Resultat Récuit Simulé: \n\n";
	
	for(int i=0;i<g.nbPoint;++i)
	    {
		tmp=tmp+tabRes[i]+" => ";
	    }
	return tmp;
    }	
}
