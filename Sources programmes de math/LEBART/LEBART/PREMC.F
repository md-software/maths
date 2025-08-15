C  ****************************************************
C  *                                                  *
C  *   PREMC: PREPARATION POUR L'AJUSTEMENT DES M-C   *
C  *                                                  *
C  ****************************************************	   
      SUBROUTINE PREMC(NQDIM,KDIM,LDIM,NQDEB,KCARD,NVAR,ICARD,                  
     1       LCARD,LTOT,NMOD,KROIS,LCUM,D,X,XMOY,W,FMT,KODE)  
      COMMON /ENSOR/LEC,IMP                                                     
      DIMENSION NMOD(NQDIM),LCUM(NQDIM),D(NQDIM),KROIS(3,KDIM)                  
      DIMENSION X(LDIM),W(LDIM,LDIM),XMOY(LDIM),FMT(20)
      CALL PREDE(NQDIM,KDIM,NQDEB,NVAR,KCARD,NMOD,KROIS,NQFIN,LCUM)             
      IF (KODE.NE.0) WRITE(IMP,100)                                             
      PI=1.0                                                                    
      MODE=0                                                                    
      NQTOT=NQDEB+NVAR+1                                                        
      DO 10 I=1,ICARD                                                           
      CALL DONNI(NQDIM,NQTOT,D,FMT)                                                 
      IF (KODE.NE.0) WRITE(IMP,1000) (D(L),L=1,NQTOT)                           
      CALL DPLOI(NQDIM,LDIM,KDIM,NQDEB,NVAR,KCARD,LCARD,LTOT,                   
     1          KROIS,LCUM,D,X)                                                 
      CALL COMAJ(MODE,LDIM,LTOT,W,XMOY,X,PI,SOMP,KOMPT)                         
10    CONTINUE                                                                  
      DO 30 L=1,LTOT                                                            
      DO 20 K=1,LTOT                                                            
20    W(K,L)=W(K,L)/SOMP                                                        
30    CONTINUE                                                                  
100   FORMAT(///1H ,19HTABLEAU DES DONNEES ,///)                                
1000  FORMAT(1H ,12(F9.2,1X))                                                  
      RETURN                                                                    
      END                                                                       
