      SUBROUTINE EDCHA (ICARD,IFIN,IDI,LA,LB,LP,VAL,NUM,V,NO,NC,IW,W,ID,
     1                  IDIM,MDIM,IDDIM)        
      COMMON /ENSOR/LEC,IMP                                                     
      DIMENSION IDI(IDIM),LA(IDIM),LB(IDIM),LP(MDIM),VAL(MDIM),              
     1 V(IDIM),NO(MDIM),NC(IDIM),IW(IDIM),W(IDIM),                          
     2      ID(IDIM),NUM(IDIM)
      DIMENSION LIGN(110)                                                       
	character*1 blan,star
	integer istar,iblan
	equivalence (istar,star)
	equivalence (iblan,blan)
      DATA LIG/110/BLAN/1H /STAR/1H./                                       
      DO 1 I=1,IDIM
1     NC(I)=0
      IDEB=ICARD+1                                                              
      DO 10 I=IDEB,IFIN                                                         
      IR=I-IDEB+1                                                               
      IA=LA(IR)                                                                 
      IB=LB(IR)                                                                 
      NO(IA)=I                                                                  
10    NO(IB)=I                                                                  
      NO(IFIN)=IFIN                                                             
      WRITE(IMP,600)                                                            
      DO 50 I=IDEB,IFIN                                                         
      NC(1)=I                                                                   
      KPT=0                                                                     
      JI=1                                                                      
20    IF (NC(JI).GT.ICARD) GOTO 30                                              
      K=NC(JI)                                                                  
      KPT=KPT+1                                                                 
      ID(KPT)=IDI(K)                                                            
      IW(KPT)=K                                                                 
      NUM(ICARD-KPT+1)=IDI(K)                                                   
      JI=JI-1                                                                   
      GOTO 40                                                                   
30    IJ=JI+1                                                                   
      NI=NC(JI)-IDEB+1                                                          
      NC(IJ)=LA(NI)                                                             
      NC(JI)=LB(NI)                                                             
      JI=JI+1                                                                   
40    IF (JI.NE.0) GOTO 20                                                      
      IR=I-IDEB+1
      WRITE(IMP,610) I,VAL(I),LA(IR),LB(IR),LP(I),(ID(KK),KK=1,KPT)             
      I1=IW(1)                                                                  
      I2=IW(KPT)                                                                
      W(I1)=NO(I)+0.0001                                                        
      W(I2)=NO(I2)+0.0001                                                       
50    CONTINUE                                                                  
      DO 60 I=1,ICARD                                                           
      K=W(I)                                                                    
60    W(I)=VAL(K)                                                               
      DO 70 I=1,ICARD                                                           
      IWI=IW(I)                                                                 
70    V(ICARD-I+1)=W(IWI)                                                       
      VMIN=VAL(IDEB)                                                            
      VMAX=VAL(IFIN)                                                            
      WRITE(IMP,620) VMIN,VMAX                                                  
      DO 80 L=1,LIG                                                             
80    LIGN(L)=IBLAN                                                             
      PAS=FLOAT(LIG)/(VMAX-VMIN)                                                
      I1=ICARD-1                                                                
      DO 120 I=1,I1                                                             
      LX=(V(I)-VMIN)*PAS+1.0                                                    
      IF (LX.LE.1) LX=1                                                         
      IF (LX.GT.LIG) LX=LIG                                                     
      DO 90 LL=1,LX                                                             
90    LIGN(LL)=ISTAR                                                            
      WRITE(IMP,630) V(I),NUM(I),(LIGN(L),L=1,LIG)                              
      IF (LX.EQ.1) GOTO 110                                                     
      LX=LX-1                                                                   
      DO 100 LL=1,LX                                                            
100   LIGN(LL)=IBLAN                                                            
110   WRITE(IMP,640) (LIGN(L),L=1,LIG)                                          
120   CONTINUE                                                                  
      DO 130 L=1,LIG                                                            
130   LIGN(L)=ISTAR                                                             
      WRITE(IMP,650) NUM(ICARD),(LIGN(L),L=1,LIG)                               
600   FORMAT(1H1,32HNOEUD  INDICE  AINE  BENJ  POIDS  ,5X,                      
     1  40HDESCRIPTION DES CLASSES DE LA HIERARCHIE /1H ,64(2H. )/)             
610   FORMAT(1H0,I4,F9.3,I5,I6,I7,5X,18(1X,A4),/(1H ,36X,18(1X,A4)))
620   FORMAT(1H1,38X,32HTRACE DU DENDROGRAMME  ECHELLE =,2F8.3//)               
630   FORMAT(1H ,F10.4,3X,A4,2X,2H..,110A1)                                     
640   FORMAT(1H ,21X,110A1)                                                     
650   FORMAT(1H ,10(1H-),3X,A4,2X,2H..,110A1)                                   
      RETURN                                                                    
      END                                                                       
