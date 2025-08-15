import java.util.*;
import java.io.*;
import java.awt.Point;

/**
 * Construit une approche du problème du voyageur de commerce à l'aide de 
 * l'heuristique appelée insertion du plus proche 
 */
public class InsertionPlusProche extends Algo{

    Vector circuit;
    double distTot;

    /**
     * Constructeur par défaut
     * @param graphe  contient les informations sur les points du circuit et 
     *                les distances entre les points.
     * @param avecAffichage
     */
    InsertionPlusProche(Graphe graphe,boolean avecAffichage){
	distTot=0;
	this.g=graphe;
	this.avecAffichage = avecAffichage;
	circuit=new Vector();
	tabDessin=new ArrayList();
	tCalcul=new Chrono();
	tabRes = new Arc[g.nbPoint];
    }

    /*
     *Algorithme de L'insertion deu plus proche voisin
     */
    public void run(){

	tCalcul.start(); //démarage du chrono

	int taille = g.nbPoint;              // nombre de points à relier
	boolean []  visite = new boolean[taille]; // tableau indiquant si un 
	                                           // point déjà été relié.

	// initialisation du tableau des points visités.
	for(int i=0; i<taille; i++)
	    visite[i] = false;

	// Au debut, le circuit est réduit à 1 point.
	circuit.addElement(new Integer(0));
	circuit.addElement(new Integer(0));
	visite[0] = true;

	tabDessin.add(new ArcDessin(new Arc(0,0,g.calcDist(0,0)),false));

	// Insertion de tois les points
	while(circuit.size() != (g.nbPoint+1)){
	    
	    // recherche du point le plus proche
	    int element;
	    double distanceMin=0;
	    int indicePoint=0;
	    double distanceCourante=0;
	    double dist;

	    for(int i = 0; i <circuit.size(); i++){
		element = ((Integer) circuit.elementAt(i)).intValue();

		for(int j = 0 ; j < taille ; j++){
		    if(!visite[j])
			distanceCourante = g.calcDist(element,j);
		    
		    if(distanceMin == 0 || distanceCourante < distanceMin){
			distanceMin = distanceCourante;
			indicePoint = j;
			
		    }
		}
	    }

	    // mise à jour du tableau de points
	    visite[indicePoint] = true;

	    // recherche de l'endroit où a lieu l'insertion
	    double distanceInsertion = -1;

	    // par défaut on insere en seconde position
	    int indexInsertion =1;

            // recherche de l'endroit où on va faire l'insertion
	    for(int index = 1; index <circuit.size()-1 ; index++){
		distanceCourante = 0;

		distanceCourante -= g.calcDist(((Integer) circuit.elementAt(index-1)).intValue(),((Integer) circuit.elementAt(index)).intValue());

		distanceCourante += g.calcDist(((Integer) circuit.elementAt(index-1)).intValue(),indicePoint);

		distanceCourante += g.calcDist(indicePoint,((Integer) circuit.elementAt(index)).intValue());

		if(distanceInsertion == -1 || distanceInsertion > distanceCourante){
		    distanceInsertion = distanceCourante;
		    indexInsertion = index;
		}
	    }

	    // insertion au bon endroit
	    circuit.insertElementAt(new Integer(indicePoint),indexInsertion);
	    
	    int p1 = ((Integer) circuit.elementAt(indexInsertion-1)).intValue();
            int p2 = ((Integer) circuit.elementAt(indexInsertion+1)).intValue();
	    int pi = ((Integer) circuit.elementAt(indexInsertion)).intValue();

	    dist=g.calcDist(p1,p2);

	    tabDessin.add(new ArcDessin(new Arc(p1,pi,dist),false));
	    tabDessin.add(new ArcDessin(new Arc(pi,p2,dist),false));
	    tabDessin.add(new ArcDessin(new Arc(p1,p2,dist),true));
	}

	tCalcul.stop(); //Fin Chrono

	int lastPoint= ((Integer)circuit.elementAt(circuit.size()-2)).intValue();
	tabDessin.add(new ArcDessin(new Arc(lastPoint,0,g.calcDist(lastPoint,0)),false));

	int j,p1,p2;
	for(int i=0;i<circuit.size()-1;++i){
	    j=i+1;
	    p1=((Integer)circuit.elementAt(i)).intValue();
	    p2=((Integer)circuit.elementAt(j)).intValue();
	    tabRes[i] = new Arc(p1,p2,g.calcDist(p1,p2));
	}
    }
}
