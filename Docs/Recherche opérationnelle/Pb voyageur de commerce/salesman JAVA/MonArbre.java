import java.util.*;
/**
 * Gereur d'arbre contenant des entiers pour les algorithmes de Kruskal et 
 * de Prim.
 */
public class MonArbre {

    MonArbre filsGauche;
    MonArbre frereDroit;
    int valeur; 

    static final MonArbre NIL = new MonArbre();

    /**
     * Constructeur par défaut d'une cellule d'un arbre.
     */
    MonArbre(){
	filsGauche = null;
	frereDroit = null;
	valeur = -1;
    }

    /**
     * Constructeur
     *
     * @param valeur valeur de l'entier contenu dans la cellule.
     * @param fils fils de la cellule considérée.
     * @param frere frere de la cellule considérée.
     */
    MonArbre(int valeur, MonArbre fils, MonArbre frere)
    {
	this.valeur = valeur;
	filsGauche = fils;
	frereDroit = frere;
    }

    /**
     * Recherche une cellule dans un arbre selon un parcours préfixe.
     *
     * @param sommet valeur de la cellule que l'on cherche.
     * @return la cellule contenant la valeur recherchée
     */
    private MonArbre rechercheObjet(int sommet){
	if ( valeur == sommet ) {
	    return this;
	} else {
	    if (filsGauche != NIL) {
		MonArbre r=filsGauche.rechercheObjet(sommet);
		if ( r != NIL ) return r;
	    }
	    if( frereDroit != NIL) {
		MonArbre r=frereDroit.rechercheObjet(sommet);
		if ( r != NIL ) return r;
	    }
	}
	return NIL;
    }


    /**
     * Construit un arbre à partir d'un tableau contenant toutes les arêtes 
     * de cet arbre .
     *
     * @param tableauArete tableau contenant les arêtes de l'arbre à construire
     * .
     * @return l'arbre construit.
     */
    MonArbre construitArbre(Vector tableauArete){
	
	Arc arete;
	LinkedList file= new LinkedList();
	
	// on prend la première arete
	arete = (Arc) tableauArete.get(0);
	tableauArete.remove(0);
	
	// on ajoute ces sommets dans la file
	file.addLast(new Integer(arete.getP1()));
	file.addLast(new Integer(arete.getP2()));

	// création de la racine et de son premier fils
	MonArbre racine = new MonArbre(arete.getP1(),new MonArbre(arete.getP2(),NIL,NIL),NIL);

	// On construit l'arbre.
	while (file.size()!=0){
	   
	    // on enlève un element de la file
	    int sommet= ((Integer) file.getFirst()).intValue();
	    file.removeFirst();

	    // on recheche l'élement dans l'arbre
	    MonArbre arbre = racine.rechercheObjet(sommet);

	    // on recherche des arêtes contenant le sommet "sommet".
	    int i=0;
	    while(i < tableauArete.size()){
		MonArbre arbreTmp = arbre;
		arete = (Arc) tableauArete.get(i);
		
		// si on trouve un point de l'arête dans l'arbre, 
		// on l'ajoute le second point de l'arête dans l'arbre
		if( arete.getP1()== sommet || arete.getP2()== sommet){
		    tableauArete.remove(i);

		    int sommet2;    // fils à inserer
		    
		    if(arete.getP1() == sommet){ 
			sommet2=arete.getP2();
		    }
		    else{
			sommet2=arete.getP1();
		    }
		    
		    // insertion en tant que fils de la cellule considérée
		    if(arbreTmp.filsGauche == NIL){
			arbreTmp.filsGauche = new MonArbre(sommet2,NIL,NIL);
		    }
		    // insertion en tant que frère du fils de la cellule 
		    // considérée
		    else{
			arbreTmp = arbreTmp.filsGauche;
			// on l'insére en tant que dernier frère
			while(arbreTmp.frereDroit!=NIL)
			    arbreTmp = arbreTmp.frereDroit;
			arbreTmp.frereDroit= new MonArbre(sommet2,NIL,NIL);
		    }
		    file.addLast(new Integer(sommet2));
		}
		else i++;
	    }
	}    
	return racine;
    }


    /**
     * Crée un tableau contenant le parcours du graphe. Le circuit correspond 
     * au parcours préfixe de l'arbre.
     *
     * @param circuit circuit actuel du graphe
     * @return le circuit. 
     */
    Vector creeCircuit(Vector circuit){

	circuit.addElement(new Integer(valeur));
	
	if (filsGauche != NIL)
	    filsGauche.creeCircuit(circuit);

	if (frereDroit != NIL)
	    frereDroit.creeCircuit(circuit);
	 
	return circuit;
    }
}
