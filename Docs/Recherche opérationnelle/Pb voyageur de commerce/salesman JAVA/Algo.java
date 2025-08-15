import java.util.*;


/**
   Classe Abstraite commune � tout algorithme du probl�me de voyageur de commerce
*/
public abstract class Algo{

    Arc[] tabRes;//Contient le circuit final
    ArrayList tabDessin;// contient les �tapes du dessin
    Chrono tCalcul;
    Graphe g;
    boolean avecAffichage;
    
    void run(){}
}
