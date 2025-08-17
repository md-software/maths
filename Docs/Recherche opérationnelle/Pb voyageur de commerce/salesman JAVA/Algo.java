import java.util.*;


/**
   Classe Abstraite commune à tout algorithme du problème de voyageur de commerce
*/
public abstract class Algo{

    Arc[] tabRes;//Contient le circuit final
    ArrayList tabDessin;// contient les étapes du dessin
    Chrono tCalcul;
    Graphe g;
    boolean avecAffichage;
    
    void run(){}
}
