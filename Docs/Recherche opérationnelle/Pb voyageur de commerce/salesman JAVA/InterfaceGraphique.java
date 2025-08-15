import javax.swing.*;
import java.awt.*;
import javax.swing.border.*;
import java.awt.event.*;
import javax.swing.event.*;
import java.util.*;

/**
   Interface graphique pour le projet - Utilise le DesktopPane
*/
public class InterfaceGraphique extends JFrame{
  
  
  Graphe g;
  int typeOptimisation=1; // 1 pour vitesse, 2 pour mémoire 
    // boolean avecAffichage;
  
    static String[] nomAlgo={"Plus Proche Voisin","Insertion Plus Proche","2-échange","Prim","L'élastique","Le récuit simulé","Séparation et évaluation"};

    javax.swing.Timer timer;

    JInternalFrame dessin;
    JInternalFrame menu;
    JInternalFrame fVilles;
    JInternalFrame fResult;
    JPanel panel1;
    JPanel panel2;

    JMenuBar menuBar;
    JMenu menuFichier;
    JMenuItem menuFermer;
    JMenu menuOptimisation;
    JMenuItem menuVitesse;
    JMenuItem menuMemoire;
    JMenu menuHelp;
    JMenuItem menuAPropos;
	
    JSlider jSlider;			
	
    JDesktopPane desktop;
    
    PanelDessin panelDessin;
     
    GridBagConstraints gbc=new  GridBagConstraints();
	
    JComboBox algoList;
    JLabel label1;
    JTextField field1;
    JLabel label2;
    JTextField field2;
    JLabel label3;
    JTextField field3;
    JLabel label4;
    JLabel label5;
    JTextField field4;
    JButton buttonStart;
    JButton buttonStartQuick;
    JButton buttonVilles;

    /**
       Constructeur de l'InterfaceGraphique
    */
    public InterfaceGraphique(){
	
	setDefaultCloseOperation(EXIT_ON_CLOSE);
	setTitle("Visualisation des heuristiques du PVC");
	LayoutManager[] layouts={new FlowLayout(),new GridLayout(1,0)};
	desktop=new JDesktopPane();
	setContentPane(desktop);
	
	g=new Graphe(30,500,500,1);
	panelDessin=new PanelDessin(g,10,100,null);

	dessin=new JInternalFrame("Fenêtre de Visualisation",false,false,false,true);
	dessin.setVisible(true);
	dessin.setSize(510,550);

	menu=new JInternalFrame("Menu",false,false,false,true);
	menu.setVisible(true);
	menu.setSize(200,230);	

	fVilles=new JInternalFrame("Generation des Villes",false,false,false,true);
	fVilles.setVisible(true);
	fVilles.setSize(200,120);

	fResult=new JInternalFrame("Resultats",false,false,false,true);
	fResult.setVisible(true);
	fResult.setSize(200,120);

	desktop.add(dessin);
	dessin.setLocation(230,10);
	desktop.add(menu);
	menu.setLocation(10,152);
	desktop.add(fVilles);
	fVilles.setLocation(10,10);

	desktop.add(fResult);
	fResult.setLocation(10,410);
	
	jSlider=new JSlider();
	
	initMenuBar();
	initFVilles();
	initFResult();
	initMenu();

    }

    /**
       Affiche la fenêtre "A propos"
     */
    public void afficheAPropos(){
	JOptionPane.showMessageDialog(this,
				      "    PVC - Le Problème du Voyageur de Commerce \n" +
				      "    Représentation graphique des algorithmes \n\n" +
				      "Bolalima Mohammed  [mbolalima@etudiant.univ-mlv.fr] \n" +
				      "Le Tétour Clément       [cletetou@etudiant.univ-mlv.fr] \n" +
				      "UMLV - Novembre 2002 \n",
				      "A propos",
				      JOptionPane.INFORMATION_MESSAGE, 
								       new ImageIcon("logoPVC.jpg"));
    
    }

    /**
       Affiche la fenêtre "manque de mémoire"
    */
    public void afficheWarning(){
	JOptionPane.showMessageDialog(this,
				      "    PVC - Le Problème du Voyageur de Commerce \n\n Mémoire insuffisante: changez de mode"
				      ,"Warning"
				      ,JOptionPane.INFORMATION_MESSAGE
				      );
    }
    /**
       Initialisation du MENU
    */
    public void initMenuBar(){

	final ImageIcon iconSelect = new ImageIcon("selected.gif",
                               "coché");
	final ImageIcon iconNotSelect = new ImageIcon("notSelected.gif",
                               "pas coché");
	ImageIcon iconInformation = new ImageIcon("information.gif",
						"Icon Information");
	
	menuBar=new JMenuBar();
	menuFichier=new JMenu("Fichier");
	menuFermer=new JMenuItem("Quitter");
	menuFermer.addActionListener(new ActionListener(){
		public void actionPerformed(ActionEvent e){
		    System.exit(0);
		}
	    });
	menuOptimisation=new JMenu("Type d'optimisation");
	menuVitesse=new JMenuItem("Priorité vitesse",iconSelect);
	menuVitesse.addActionListener(new ActionListener(){
		public void actionPerformed(ActionEvent e){
		  typeOptimisation=1;
		  try{
		    g=new Graphe(g,1);}catch (OutOfMemoryError oe){afficheWarning();}
		  menuVitesse.setIcon(iconSelect);
		  menuMemoire.setIcon(iconNotSelect);
		  g.tabDist= new double[g.nbPoint][g.nbPoint];
		  g.calcTabDist();
		}
	    });
	menuMemoire=new JMenuItem("Priorité mémoire",iconNotSelect);
	menuMemoire.addActionListener(new ActionListener(){
		public void actionPerformed(ActionEvent e){
		  typeOptimisation=2;
		  g=new Graphe(g,2);
		  menuVitesse.setIcon(iconNotSelect);
		  menuMemoire.setIcon(iconSelect);
		  g.tabDist=null;
		}
	    });
	menuHelp=new JMenu("?");
	menuAPropos=new JMenuItem("A propos",iconInformation);
	menuAPropos.addActionListener(new ActionListener(){
		public void actionPerformed(ActionEvent e){
		    afficheAPropos();
		}
	    });

	menuFichier.add(menuFermer);
	menuOptimisation.add(menuVitesse);
	menuOptimisation.add(menuMemoire);
	menuHelp.add(menuAPropos);
	menuBar.add(menuFichier);
	menuBar.add(menuOptimisation);
	menuBar.add(menuHelp);

	this.setJMenuBar(menuBar);
    }

    /**
       Méthode d'initialisation de la frame Villes
    */
    public void initFVilles(){

	label1 =new JLabel("Nb de villes: ");
	label5= new JLabel("(Max 2500 en priorité vitesse)");
	field1=new JTextField("20",4);
	field1.setHorizontalAlignment(JTextField.CENTER);
	buttonVilles=new JButton("GO");
	buttonVilles.addActionListener(new ActionListener(){
		public void actionPerformed(ActionEvent e){

		    StringTokenizer token=new StringTokenizer(field1.getText());
		    String tmp=token.nextToken();
		    int nbVilles=Integer.parseInt(tmp);
		    try{
			g=new Graphe(nbVilles,500,500,typeOptimisation);
		    }catch (OutOfMemoryError ome){afficheWarning();}
		    
		    dessin.remove(panelDessin);
		    panelDessin.graphe=g;
		    panelDessin.algo=null;
		    panelDessin.typeAlgo=100;
		    dessin.getContentPane().add(panelDessin);
		    desktop.validate();
		    dessin.repaint();
		}
	    });
	
	fVilles.getContentPane().setLayout(new FlowLayout());
	fVilles.getContentPane().add(label1);
	fVilles.getContentPane().add(label5);
	fVilles.getContentPane().add(field1);
	fVilles.getContentPane().add(buttonVilles);

    }
    /**
       Méthode d'initialisation de la frame de visualisation des Résultats
    */
    public void initFResult(){
	
	label3=new JLabel("Distance : ");
	field3=new JTextField("0",6);
	field3.setEnabled(false);
	field3.setHorizontalAlignment(JTextField.CENTER);
	label4=new JLabel("Temps Calcul (ms): ");
	field4=new JTextField("0",6);
	field4.setEnabled(false);
	field4.setHorizontalAlignment(JTextField.CENTER);
	
	fResult.getContentPane().setLayout(new FlowLayout());
	fResult.getContentPane().add(label3);
	fResult.getContentPane().add(field3);
	fResult.getContentPane().add(label4);
	fResult.getContentPane().add(field4);
    }
    
    /**
       Méthode affichant la distance total du circuit c
       @param c le tableau de résultat sur lequel on calcul la distance
    */
    public void afficheDistance(Arc[] c){
	double distance=0;
	for(int i=0;i<c.length;++i)
	    distance+=c[i].distance;
	field3.setText(Integer.toString((int)distance));
    }

    /**
       Méthode affichant la distance total de l'elastique
       @param tab le tableau contenant les points de l'elastique
    */
    public void afficheDistanceElastique(PointElastique[] tab){
	double distance=0;
	int k=0;
	int j=1;
	while(k<tab.length-1){
	    distance+=PointElastique.calcDist(tab[k],tab[j]);
	    k++;
	    j++;				
	}
	distance+=PointElastique.calcDist(tab[j-1],tab[0]);
	field3.setText(Integer.toString((int)distance));
    }

    /**
       Affiche le temps de cacul pour l'algo courant
       @param c le chrono
    */
    public void afficheChrono(Chrono c){
	field4.setText(Long.toString(c.getFinalTimeElapsed()));
    }
    /**
       Méthode d'initialisation du menu
    */
    public void initMenu(){
	panel1=new JPanel();
	panel2=new JPanel();
	panel2.setBorder(BorderFactory.createCompoundBorder
			 (
			  BorderFactory.createTitledBorder("Mode sans affichage"),
			  BorderFactory.createEmptyBorder(1,1,1,1)
			  )
			 );
	
	algoList = new JComboBox(InterfaceGraphique.nomAlgo);
	label2=new JLabel("Vitesse 1 à 10: ");
	field2=new JTextField("7",2);
	field2.setHorizontalAlignment(JTextField.CENTER);

	buttonStart=new JButton("GO");
        buttonStart.addActionListener(new ActionListener(){
		    public void actionPerformed(ActionEvent e){
			startAlgo(true);
			jSlider.setEnabled(true);
		    }
		});

	buttonStartQuick=new JButton("Affichage final");
        buttonStartQuick.addActionListener(new ActionListener(){
		public void actionPerformed(ActionEvent e){
		    startAlgo(false);
		    jSlider.setEnabled(false);
		}
	    });
	
	menu.getContentPane().add(panel1);
	panel1.add(algoList);
	panel1.add(panel2);
	panel2.add(buttonStartQuick);
	panel1.add(label2);
	panel1.add(field2);
	panel1.add(buttonStart);
	panel1.add(jSlider);	
	jSlider.setEnabled(false);
    }

    /**
       Action lors d'un clic sur le bouton Démarrer
       @param avecAffichage 1 si on veut l'affichage complet, 2 sinon
    */
    public void startAlgo(boolean avecAffichage){
	
	int vitesse=7;
	String tmp;
	Algo algo=new AlgoPpv(g,avecAffichage);
	StringTokenizer token;
	
	try{
	    token=new StringTokenizer(field2.getText());
	    tmp=token.nextToken();
	    vitesse=Integer.parseInt(tmp);
	}catch (NumberFormatException e) {
	    System.err.println("Erreur de format");
	}
	if(vitesse>10) {vitesse=10; field2.setText("10");} //10 est la vitesse max
	if(vitesse<0) {vitesse=0; field2.setText("0");} //0 est la vitesse min
	vitesse=(10-vitesse)*100;
	    
	int algoChoice=algoList.getSelectedIndex();
	if(panelDessin!=null)
	    dessin.remove(panelDessin);
	
	if(timer!=null)
	    timer.stop();
	startTimer(vitesse,algoChoice);
	
	switch(algoChoice){
	    case 0: //ppv
		algo=new AlgoPpv(g,avecAffichage);
		algo.run();
		
		if(avecAffichage)
		    panelDessin.etape=1;
		else
		    panelDessin.etape=algo.tabDessin.size();
		
		afficheDistance(algo.tabRes);

		break;
	    case 1:// Insertion Plus proche
		algo=new InsertionPlusProche(g,avecAffichage);
		algo.run();
			
		if(avecAffichage)
		    panelDessin.etape=1;
		else
		    panelDessin.etape=algo.tabDessin.size();
	
		afficheDistance(algo.tabRes);

		break;
	    case 2://2-échange
		algo=new Algo2opt(g,avecAffichage);
		algo.run();
		if(avecAffichage)
		    panelDessin.etape=g.nbPoint;
		else
		    panelDessin.etape=algo.tabDessin.size();
		
		afficheDistance(algo.tabRes);
		break;
	    case 3://Prim
		algo=new AlgoPrim(g,avecAffichage);
		algo.run();
		if(avecAffichage)
		    panelDessin.etape=1;
		else
		    panelDessin.etape=algo.tabDessin.size();

		afficheDistance(algo.tabRes);
		break;
	    case 4://L'élastique
	      algo=new AlgoElastique(g,avecAffichage);
	      algo.run();
	      panelDessin.algo=algo;

	      if(avecAffichage)
		  panelDessin.etape=1;
	      else
		  panelDessin.etape=algo.tabDessin.size();
	      
	      afficheDistanceElastique(((AlgoElastique)algo).elastique);
	      break;
	    case 5://Le récuit simulé
		algo=new AlgoRecuit(g,avecAffichage);
		algo.run();	
		if(avecAffichage)
		    panelDessin.etape=g.nbPoint;
		else
		    panelDessin.etape=algo.tabDessin.size();
		
		afficheDistance(algo.tabRes);
		break;
	    case 6://Séparation évaluation
		algo=new SepEval(g,avecAffichage);
		algo.run();

		if(avecAffichage)
		    panelDessin.etape=1;
		else
		    panelDessin.etape=algo.tabDessin.size();

		afficheDistance(algo.tabRes);
		break;
	    default:
		break;
	    }
	
	panelDessin.graphe=g;
	panelDessin.vitesse=vitesse;
	panelDessin.typeAlgo=algoChoice;
	panelDessin.algo=algo;
	dessin.getContentPane().add(panelDessin);
	dessin.validate();
	panelDessin.repaint();
	
	afficheChrono(algo.tCalcul); //Affichage du temps de calcul
	
	// Le slider de controle
	panel1.remove(jSlider);
	jSlider=new JSlider(0,algo.tabDessin.size(),0);
	
	jSlider.addChangeListener(new SliderListener());
	jSlider.setMajorTickSpacing(algo.tabDessin.size()/5);
	jSlider.setMinorTickSpacing(1);
	jSlider.setPaintTicks(true);
	jSlider.setPaintLabels(true);
	jSlider.setBorder(BorderFactory.createEmptyBorder(0,0,10,0));
	
	panel1.add(jSlider);
	menu.validate();
    }

    /**
       Classe Interne qui ecoute le JSlider
    */
    public class SliderListener implements ChangeListener {
	public void stateChanged(ChangeEvent e) {
	    JSlider source = (JSlider)e.getSource();
	    if (source.getValueIsAdjusting()) {
		int etat = (int)source.getValue();
		timer.stop();
		panelDessin.etape=etat;
		desktop.repaint();
		panelDessin.repaint();
	    }    
	}
    }
    
    
    /** 
	Timer pour la vitesse de visualisation
	@param vitesse la vitesse de repetition
	@param algo l'algorhitme
    */
    public void startTimer(int vitesse, final int algo){
	
	ActionListener taskPerformer;
   
	taskPerformer = new ActionListener() {
		public void actionPerformed(ActionEvent evt){
		   if(algo==2 || algo==5) // 2opt et récuit: 2 étapes a chaque temps
			panelDessin.etape++;
		    panelDessin.etape++;
		    desktop.repaint();
		}
	    };
	timer=new javax.swing.Timer(vitesse,taskPerformer);
	timer.start();
    }
    
    /**
       Classe Interne MonPanel Contenant le dessin du graphe
    */
    public class PanelDessin extends JPanel{
	
	protected Graphe graphe;
	protected int etape;
	protected int vitesse;
	protected int typeAlgo;
	protected Algo algo;
	protected int i;
 
	public PanelDessin(){}

	/**
	   Constructeur du panel de dessin
	   @param g le graphe
	   @param v la vitesse d'affichage
	   @param alg le numéro de l'algo selectionné
	   @param a l'algo
	*/
	public PanelDessin(Graphe g,int v,int alg,Algo a){
	    vitesse=v;
	    algo=a;
	    typeAlgo=alg; 
	    graphe=g;
	    i=0;
	    this.setBackground(Color.BLACK);  
	}
	
	/**
	   Méthode paintComponent fournissant le contexte graphique pour dessiner
	*/
	public void paintComponent(Graphics g){	
	    
	    super.paintComponent(g);
	    g.setColor(Color.blue);
	    
	    switch(typeAlgo){
	    case 0: case 1: case 2: case 3: case 5: case 6:
		i=0;
		while(i<algo.tabDessin.size() && i<etape)
		    {
			dessineArc(i,g);
			++i;
		    }
		break;
	    case 4://L'élastique
		if(etape<algo.tabDessin.size())
		    dessineElastique(etape,g);
		else dessineElastique(algo.tabDessin.size()-1,g);
		break;
	    default:
		break;
	    }
	    
	    //dessin des points
	    g.setColor(Color.red);
	    for (int i = 0; i < graphe.nbPoint; i++) {
		Point p = graphe.tabPoint[i];
		g.drawOval(p.getX() - 2, p.getY() - 2,2 * 2, 2 * 2);	
	    }
	    
	}

      /**
	 Dessine un arc ou l'enlève
	 @param i l'arc a dessiner
	 @param g le contexte graphique
      */
      public void dessineArc(int i,Graphics g){
	if(((ArcDessin)algo.tabDessin.get(i)).detruire==false){
	  g.setColor(Color.WHITE);
	  g.drawLine(graphe.tabPoint[((ArcDessin)algo.tabDessin.get(i)).p1].getX(),
		     graphe.tabPoint[((ArcDessin)algo.tabDessin.get(i)).p1].getY(),
		     graphe.tabPoint[((ArcDessin)algo.tabDessin.get(i)).p2].getX(),
		     graphe.tabPoint[((ArcDessin)algo.tabDessin.get(i)).p2].getY());
	}else{
	  g.setColor(Color.BLACK);
	  g.drawLine(graphe.tabPoint[((ArcDessin)algo.tabDessin.get(i)).p1].getX(),
		     graphe.tabPoint[((ArcDessin)algo.tabDessin.get(i)).p1].getY(),
		     graphe.tabPoint[((ArcDessin)algo.tabDessin.get(i)).p2].getX(),
		     graphe.tabPoint[((ArcDessin)algo.tabDessin.get(i)).p2].getY());
	}
	
      }

      /**
	 Dessine l'elastique à l'étape i
	 @param i l'etape à dessiner
	 @param g le contexte graphique
       */
      public void dessineElastique(int i,Graphics g){
	g.setColor(Color.white);
	Object[] tab=((LinkedList)algo.tabDessin.get(i)).toArray();

	int k=0;
	int j=1;
	while(k<tab.length-1){
		g.drawLine((int)(((PointElastique)tab[k]).getX()),
			(int)(((PointElastique)tab[k]).getY()),
			(int)(((PointElastique)tab[j]).getX()),
			(int)(((PointElastique)tab[j]).getY()));
		k++;
		j++;				
	}
	g.drawLine((int)(((PointElastique)tab[k]).getX()),
			(int)(((PointElastique)tab[k]).getY()),
			(int)(((PointElastique)tab[0]).getX()),
			(int)(((PointElastique)tab[0]).getY()));
	
	g.setColor(Color.GREEN);
	for(j=0;j<tab.length;++j){
	    PointElastique p = ((PointElastique)tab[j]);
	    g.fillOval(((int)p.getX()) - 2, ((int)p.getY()) - 2,2 * 2, 2 * 2); 
	}
      }
    }
}

