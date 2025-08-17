import java.util.*;
import java.lang.*;

/**
 * Construit la solution exacte du problème du voyageur de commerce à l'aide 
 * de l'algorithme de séparation et d'évaluation.
 */
public class SepEval extends Algo{

    double borne;       // borne indiquant qu'il faut arrête l'exploration.
    int [] circuit;     // circuit que l'on calcule.
    int [] min_circuit; // circuit minimum trouvé.
    boolean [] utilise; // garde les points déjà utilisé.

    /**
     * Constructeur par défaut
     */
    SepEval(Graphe graphe,boolean avecAffichage){

	this.g=graphe;
	this.avecAffichage = avecAffichage;

	borne = 0 ;
	circuit = new int[g.nbPoint];
	min_circuit=new int[g.nbPoint];
	utilise = new boolean[g.nbPoint];

	for(int i=0;i<g.nbPoint;i++)
	    utilise[i] = false;

	tabDessin=new ArrayList();
	tCalcul=new Chrono();
	tabRes = new Arc[g.nbPoint];
    }
    
    
    /**
     * Recherche le circuit le plus court pour relier tous les points.
     * @param niveau nombre de ville insérée dans le circui.
     * @param distance longueur du circuit
     */
    void recherche(int niveau,double distance) {
	double d;
	int i;

	// Si on a pas fini le circuit
	if (niveau < g.nbPoint) {
	   
	    for (i=0;i<g.nbPoint;i++) {
		if(utilise[i]!=true){
		    d=distance+g.calcDist(circuit[niveau-1],i);
		    if ( d<borne ) {
			circuit[niveau]=i;
			utilise[i]=true;
			recherche(niveau+1,d);
			utilise[i]=false;
		    }
		}
	    }
	}
	// Sinon on regarde si celui-ci est minimal
	else {
	    d=distance+g.calcDist(circuit[niveau-1],0);
	    if (d<borne){
		borne=d;
		for(i=0;i<g.nbPoint;i++)
		    min_circuit[i]=circuit[i];
	    }
	}
    }

    /**
     * Application de l'algorithme de séparation et évaluation
     * @param graphe les informations sur le graphe
     */
    public void run() {
	
	// circuit initial: 0 -> 2->..->(nonbre points-1)->0 
	int i;
	tCalcul.start(); //démarage du chrono
	double distance = 0;
	for (i=0;i<g.nbPoint-1;i++) {
	    distance += g.calcDist(i,i+1);
	    min_circuit[i]=i;
	}
	distance+=g.calcDist(g.nbPoint-1,0);
	
	borne = distance;
	circuit[0]=0;
	utilise[0] = true;

	// recherche du circuit minimal
	recherche(1,0);
	tCalcul.stop(); //Fin Chron
	// dessin du circuit final.
	int j,p1,p2,p3=0;

	for(i=0;i<g.nbPoint-1;i++){
	    j=i+1;

	    p1=min_circuit[i];
	    p2=min_circuit[j];

	    tabRes[i] = new Arc(p1,p2,g.calcDist(p1,p2));
	    tabDessin.add(new ArcDessin(new Arc(p1,p2,g.calcDist(p1,p2)),false));
	    p3++;
	}

	p1=min_circuit[g.nbPoint-1];
	p2=min_circuit[0];

	tabRes[p3] = new Arc(p1,p2,g.calcDist(p1,p2));
	tabDessin.add(new ArcDessin(new Arc(p1,p2,g.calcDist(p1,p2)),false));
    }
}
