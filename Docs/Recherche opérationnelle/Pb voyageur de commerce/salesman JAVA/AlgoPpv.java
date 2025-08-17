import java.util.*;

/**
   Algorithme du plus proche voisin
*/

public class AlgoPpv extends Algo{

  boolean[] tabUtiliser;
    

    /**
       Constructeur
       @param g le graphe sur lequel s'applique l'algorithme
       @param avecAffichage affichage: oui ou non
    */
  public AlgoPpv(Graphe g,boolean avecAffichage){
    this.g=g;
    this.avecAffichage=avecAffichage;
    tabRes=new Arc[g.nbPoint];
    tabUtiliser=new boolean[g.nbPoint];
    tabDessin=new ArrayList();
    tCalcul=new Chrono();
  }
  
    /**
       Méthode lançant le calcul
    */
  public void run(){
      
      tCalcul.start(); //démarage du chrono
    
      int temp=searchPpv(0);
    Arc tmp=new Arc(0,temp,g.calcDist(0,temp));
    tabRes[0]=tmp;
    tabUtiliser[0]=true;

    tabDessin.add(new ArcDessin(tmp,false)); //pour le dessin
    
    for(int i=1;i<g.nbPoint;++i)
    {
	temp=searchPpv(tabRes[i-1].p2);
      tmp=new Arc(tabRes[i-1].p2,temp,g.calcDist(tabRes[i-1].p2,temp));
      tabRes[i]=tmp;
      tabDessin.add(new ArcDessin(tmp,false)); //Pour le dessin
    }
    
    tCalcul.stop(); //Fin Chrono
  }

    /**
       Méthode de recherche du plus proche voisin d'un point
       @param p l'indice dans g.tabPoint du point
       @return l'indice du plus proche voisin dans g.tabPoint
    */
  public int searchPpv(int p){
    double min=Double.MAX_VALUE;
    int indiceMin=0;
    
    for(int i=0;i<g.nbPoint;++i)
    {
      if(i!=p && tabUtiliser[i]==false)
	if(g.calcDist(p,i)<min)
	 {
	   min=g.calcDist(p,i);
	   indiceMin=i;
	 }
    }
    tabUtiliser[indiceMin]=true;
    return indiceMin;
  }

  
    /**
       Méthode toString de l'algo du plus proche voisin
       @return une chaine représentant l'objet
    */
  public String toString(){
    String tmp="\n Resultat Plus Proche Voisin: \n\n";

    for(int i=0;i<g.nbPoint;++i)
    {
      tmp=tmp+tabRes[i]+" => ";
    }
    return tmp;
  }
  
}
