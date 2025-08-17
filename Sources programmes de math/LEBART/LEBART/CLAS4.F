      SUBROUTINE CLAS4(MODE,ICARD,MCARD,IFIN,D,PI,IDI,LA,LB,LP,VAL,NO,
     1                 IDIM,MDIM,IDDIM)          
      EXTERNAL MONO
      DIMENSION D(IDDIM),IDI(IDIM),PI(MDIM)                                    
      DIMENSION LA(IDIM),LB(IDIM),LP(MDIM),VAL(MDIM),NO(MDIM)
      COMMON /ENSOR/LEC,IMP                                                     
      WRITE(IMP,600) ICARD                                                      
      GOTO (10,20,30,40) ,MODE                                                  
10    WRITE(IMP,610)                                                            
      GOTO 50                                                                   
20    WRITE(IMP,620)                                                            
      GOTO 50                                                                   
30    WRITE(IMP,630)                                                            
      GOTO 50                                                                   
40    WRITE(IMP,640)                                                            
50    IF (MODE.EQ.4) GOTO 70                                                    
      DO 60 I1I2=1,MCARD                                                        
60    D(I1I2)=SQRT(D(I1I2))                                                     
70    IF (MODE.NE.3) GOTO 90                                                    
      DO 80 I1=2,ICARD                                                          
      I3=I1-1                                                                   
      DO 80 I2=1,I3                                                             
      I1I2=MONO(I1,I2)                                                          
80    D(I1I2)=D(I1I2)*PI(I1)*PI(I2)/(PI(I1)+PI(I2))                             
90    CONTINUE                                                                  
      WRITE(IMP ,650)                                                           
      DO 100 I=1,ICARD                                                          
      NO(I)=I                                                                   
      VAL(I)=0.0                                                                
100   LP(I)=1                                                                   
      IDEB=ICARD+1                                                              
      DO 190 I=IDEB,IFIN                                                        
      DINF=D(1)                                                                 
      II1=1                                                                     
      II2=2                                                                     
      II=2*ICARD-I+1                                                            
      DO 110 I1=2,II                                                            
      I3=I1-1                                                                   
      DO 110 I2=1,I3                                                            
      I1I2=MONO(I1,I2)                                                          
      IF (D(I1I2).GE.DINF) GOTO 110                                             
      DINF=D(I1I2)                                                              
      II1=I1                                                                    
      II2=I2                                                                    
110   CONTINUE                                                                  
      IR=I-IDEB+1                                                               
      LA(IR)=MIN0(NO(II1),NO(II2))                                              
      LB(IR)=MAX0(NO(II1),NO(II2))                                              
      VAL(I)=DINF                                                               
      LAI=LA(IR)                                                                
      LBI=LB(IR)                                                                
      LPA=LP(LAI)                                                               
      LPB=LP(LBI)                                                               
      LP(I)=LPA+LPB                                                             
      VA=VAL(LAI)                                                               
      VB=VAL(LBI)                                                               
      PIA=PI(LAI)                                                               
      PIB=PI(LBI)                                                               
      PI(I)=PIA+PIB                                                             
      NO(II1)=I                                                                 
      DO 160 III=1,II                                                           
      IF (III.EQ.II1.OR.III.EQ.II2) GOTO 160                                    
      M1=MONO(III,II1)                                                          
      M2=MONO(III,II2)                                                          
      GOTO (120,130,140,150),MODE                                               
120   D(M1)=AMIN1(D(M1),D(M2))                                                  
      GOTO 160                                                                  
130   D(M1)=(LPA*D(M1)+LPB*D(M2))/(LPA+LPB)                                     
      GOTO 160                                                                  
140   IS=NO(III)                                                                
      VIS=PI(IS)                                                                
      D(M1)=((VA+VIS)*D(M1)+(VB+VIS)*D(M2)-VIS*DINF)/(VA+VB+VIS)                
      GOTO 160                                                                  
150   D(M1)=((LPA*D(M1)+LPB*D(M2))/(LPA+LPB))                                   
     1    -(LPA*LPB*DINF/((LPA+LPB)**2))                                        
160   CONTINUE                                                                  
      IF (II2.EQ.II) GOTO 180                                                   
      NO(II2)=NO(II)                                                            
      IT=II-1                                                                   
      DO 170 III=1,IT                                                           
      IF (III.EQ.II2) GOTO 170                                                  
      M1=MONO(III,II2)                                                          
      M2=MONO(III,II)                                                           
      D(M1)=D(M2)                                                               
170   CONTINUE                                                                  
180   WRITE(IMP,660) I,VAL(I),LA(IR),LB(IR),LP(I)                               
190   CONTINUE                                                                  
      IF (MODE.EQ.1) GOTO 210                                                   
      DO 200 I=IDEB,IFIN                                                        
200   VAL(I)=I-IDEB+1                                                           
210   RETURN                                                                    
600   FORMAT(1H1,20X,41HCLASSIFICATION ASCENDANTE HIERARCHIQUE DE,I5,           
     1   11H  INDIVIDUS /1H ,20X,24HSUR MATRICE DE DISTANCES //)                
610   FORMAT(1H ,20X,46HULTRAMETRIQUE INFERIEURE MINIMALE  (ALGORITHME,         
     1 17H DU SAUT MINIMAL) //)                                                 
620   FORMAT(1H ,20X,30HCRITERE DE LA DISTANCE MOYENNE //)                      
630   FORMAT(1H ,20X,22HCRITERE DE LA VARIANCE //)                              
640   FORMAT(1H ,20X,21HCRITERE DU BARYCENTRE //)                               
650   FORMAT(//1H ,30X,40HNOEUD   INDICE   AINE  BENJAMIN EFFECTIF /)           
660   FORMAT(1H ,30X,I4,3X,F6.3,I7,I8,I8)                                       
      END                                                                       
