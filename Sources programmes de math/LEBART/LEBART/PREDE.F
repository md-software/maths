C   *******************************************************************
C   *                                                                 *
C   *  PREDE: PREDEPLOIEMENT=CALCUL DU VECTEUR LCUM DES DDL CUMULES   *
C   *                                                                 *
C   *******************************************************************
      SUBROUTINE PREDE(NQDIM,KDIM,NQDEB,NVAR,KCARD,NMOD,KROIS,                  
     1        NQFIN,LCUM)                                                       
      COMMON /ENSOR/LEC,IMP                                                     
      DIMENSION NMOD(NQDIM),KROIS(3,KDIM),LCUM(NQDIM)                           
      NQFIN=1                                                                   
      LCUM(NQFIN)=0                                                             
      IF (NQDEB.LE.0) GOTO 20                                                   
      DO 10 J=1,NQDEB                                                           
      LCUM(NQFIN+1)=LCUM(NQFIN)+NMOD(NQFIN)-1                                   
      I1=LCUM(NQFIN)+1                                                          
      I2=LCUM(NQFIN+1)                                                          
      WRITE(IMP,100) J,(I,I=I1,I2)                                              
10    NQFIN=NQFIN+1                                                             
20    CONTINUE                                                                  
      IF (NVAR.LE.0) GOTO 40                                                    
      DO 30 J=1,NVAR                                                            
      LCUM(NQFIN+1)=LCUM(NQFIN)+1                                               
      I1=LCUM(NQFIN)+1                                                          
      I2=LCUM(NQFIN+1)                                                          
      WRITE(IMP,200) J,(I,I=I1,I2)                                              
30    NQFIN=NQFIN+1                                                             
40    CONTINUE                                                                  
      IF (KCARD.LE.0) GOTO 70                                                   
      DO 60 K=1,KCARD                                                           
      K1=KROIS(1,K)                                                             
      K2=KROIS(2,K)                                                             
      K3=KROIS(3,K)                                                             
      L1=LCUM(K1+1)-LCUM(K1)                                                    
      L2=LCUM(K2+1)-LCUM(K2)                                                    
      L3=1                                                                      
      IF (K3.LE.0) GOTO 50                                                      
      L3=LCUM(K3+1)-LCUM(K3)                                                    
50    LCUM(NQFIN+1)=LCUM(NQFIN)+L1*L2*L3                                        
      I1=LCUM(NQFIN)+1                                                          
      I2=LCUM(NQFIN+1)                                                          
      WRITE(IMP,300) K,(I,I=I1,I2)                                              
60    NQFIN=NQFIN+1                                                             
100   FORMAT(1H0,11HCRITERE    ,I4,5X,20HCOEFFICIENTS NUMEROS,20I4)             
200   FORMAT(1H0,11HVARIABLE   ,I4,5X,20HCOEFFICIENTS NUMEROS,20I4)             
300   FORMAT(1H0,11HINTERACTION,I4,5X,20HCOEFFICIENTS NUMEROS,20I4)             
70    RETURN                                                                    
      END                                                                       
