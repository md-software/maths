import java.util.*;
import java.lang.*;

/*
 * l'algorithme de Prim. 
 */
public class AlgoPrim extends Algo{

    Vector circuit; // veteur contenant le cparcours de l'arbre recouvrant
    double distTot;
   
    /**
    * Constructeur par défaut
    * @param graphe les informations sur le graphe
    * @param avecAffichage
    */
    public AlgoPrim(Graphe graphe, boolean avecAffichage){
	distTot=0;

	this.g=graphe;
	this.avecAffichage = avecAffichage;

	circuit = new Vector();

	tabDessin=new ArrayList();

	tCalcul=new Chrono();

	tabRes = new Arc[g.nbPoint];
    }

    /**
     * Construction des arêtes de l'arbre recouvrant avec l'algorithme de Prim.
     * @return le tableau des arêtes de l'arbre recouvrant.
     */
    Vector arbreRecouvrant(){
	
	int nSommets = g.nbPoint;     // nombre de points du graphe
	Vector tableauArete = new Vector();// tableau d'arêtes
	

	// le premier sommet est 0
	circuit.addElement(new Integer(0));

	// on crée le circuit
	while(circuit.size() < nSommets){
	    double distanceMin = -1;
	    int sommet1Min = 0;
	    int sommet2Min = 0;

	    // pour tous les sommets stockés
	    for(int k=0; k<circuit.size() ; k++){
		int i = ((Integer) circuit.elementAt(k)).intValue(); 
		for(int j=0; j<nSommets; j++){
		    // pour tous les sommets n'étant pas inclus dans le circuit
		    // on recherche le point le plus proche
		    if(!circuit.contains(new Integer(j))){
			double distance = g.calcDist(i,j);
			if( distance <distanceMin || distanceMin == -1){
			    distanceMin = distance;
			    sommet1Min = i;
			    sommet2Min = j;
			}
		    }
		}
	    }
	    
	    circuit.addElement(new Integer(sommet2Min));

	    tabDessin.add(new ArcDessin(new Arc(sommet1Min,sommet2Min,g.tabDist[sommet1Min][sommet2Min]),false));

	    tableauArete.addElement(new Arc(sommet1Min,sommet2Min,g.calcDist(sommet1Min,sommet2Min)));
	}
	return tableauArete;
    }

    /**
     * Alogo de Prim
     **/
    public void run(){

	tCalcul.start(); //démarage du chrono

	Vector v =arbreRecouvrant();   // création de l'arbre recouvrant

	MonArbre monarbre = new MonArbre();  // création effective de l'arbre
	monarbre = monarbre.construitArbre(v);
	
	// création du circuit par un parcours préfixe de l'arbre recouvrant
	circuit = monarbre.creeCircuit(new Vector());
	circuit.addElement(circuit.elementAt(0));

	tCalcul.stop(); //Fin Chrono

	//save l'arbre
	ArrayList tmp1 = new ArrayList(tabDessin);

	tabDessin = null;
	tabDessin = new ArrayList();

	for(int i = 0; i< (circuit.size()-1) ; i++){

	    int p1 = ((Integer) circuit.elementAt(i)).intValue();
	    int p2 = ((Integer) circuit.elementAt(i+1)).intValue();

	    distTot += g.calcDist(p1,p2);
	    tabRes[i] = new Arc(p1,p2,g.calcDist(p1,p2));
	    tabDessin.add(new ArcDessin(new Arc(p1,p2,g.calcDist(p1,p2)),false));
	}
	//save du circuit final
	ArrayList tmp2 = new ArrayList(tabDessin);
	
	tabDessin = null;
	tabDessin = new ArrayList();

	for(int i=0;i<tmp1.size();++i){
	   tabDessin.add(new ArcDessin((ArcDessin)tmp1.get(i),false));
	}

	for(int i=0;i<tmp1.size();++i){
	    tabDessin.add(new ArcDessin((ArcDessin)tmp1.get(i),true));
	}

	for(int i=0;i<tmp2.size();++i){
	    tabDessin.add(new ArcDessin((ArcDessin)tmp2.get(i),false));
	}
    }
}
