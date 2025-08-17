C  **********************************************
C  *                                            *
C  *    PROGRAMME D'ANALYSE DE LA COVARIANCE    *
C  *                                            *  
C  *    REGMC: AJUST. DES MOINDRES CARRES       *
C  *                                            *    	
C  ********************************************** 
      PARAMETER (NQDIM=25,KDIM=8,LDIM=100)
      COMMON /ENSOR/LEC,IMP 
      DIMENSION NMOD(NQDIM),LCUM(NQDIM),D(NQDIM),KROIS(3,KDIM),FMT(20)
      DIMENSION X(LDIM),W(LDIM,LDIM),XMOY(LDIM),A(LDIM),SA(LDIM)
      DIMENSION TEXTE(10)                                                       
      LEC=5                                                                     
      IMP=6                                                                     
      READ(LEC,107) KODE                                                      
      READ(LEC,108) TEXTE                                                       
      WRITE(IMP,1002) TEXTE                                                     
      READ(LEC,1000) ICARD,NQDEB,NVAR,ITA2,ITA3                                 
      WRITE(IMP,1100) ICARD,NQDEB,NVAR,ITA2,ITA3                                
      KCARD=ITA2+ITA3                                                           
      IF (NQDEB.LE.0) GOTO 10                                                   
      READ(LEC,1000) (NMOD(LQ),LQ=1,NQDEB)                                      
      WRITE(IMP,1200)(NMOD(LQ),LQ=1,NQDEB)                                      
10    IF (KCARD.LE.0) GOTO 30                                                   
      DO 20 K=1,KCARD                                                           
      READ(LEC,1000)  (KROIS(II,K),II=1,3)                                      
      WRITE(IMP,1300) (KROIS(II,K),II=1,3)                                      
20    CONTINUE                                                                  
30    CONTINUE                                                                  
      READ(LEC,1400)  (FMT(J),J=1,20)                                           
      WRITE(IMP,1500) (FMT(J),J=1,20)                                           
      CALL PREMC(NQDIM,KDIM,LDIM,NQDEB,KCARD,NVAR,ICARD,                        
     1      LCARD,LTOT,NMOD,KROIS,LCUM,D,X,XMOY,W,FMT,N,KODE)
      CALL MLCOV(LDIM,LTOT,ICARD,W,XMOY,A,SA,SCE,S2,R2,IFLAG)
      WRITE(IMP,2000)                                                           
      CALL EDITR(LDIM,LTOT,ICARD,W,XMOY,A,SA,SCE,S2,R2,LCUM,NQDIM,NQDEB)        
      IF (NQDEB.LE.0) GOTO 40                                                   
      WRITE(IMP,2000)                                                           
      CALL AVAR2(LDIM,NQDIM,KDIM,ICARD,NQDEB,NVAR,ITA2,ITA3,LTOT,               
     1       KCARD,KROIS,W,A,LCUM)                                              
40    CONTINUE
      WRITE(IMP,2000)
107   FORMAT(I2)                                                               
108   FORMAT(20A4)
1000  FORMAT(20I4)                                                              
1002  FORMAT(1H1/1H0,130(1H-)/1H ,40X,20A4/1H ,130(1H-)/1H0)
1100  FORMAT(1H0,7HICARD= ,I6,10X,7HNQDEB= ,I6,10X,7HNVAR=  ,I6,                
     1      10X,7HITA2=  ,I6,10X,7HITA3=  ,I6/)                                 
1200  FORMAT(1H0,9HNMOD(*)= ,20I5)                                              
1300  FORMAT(1H0,12HKROIS(*,*)=    ,3I5)                                        
1400  FORMAT(20A4)                                                              
1500  FORMAT(1H0,5HFMT= ,20A4/)                                                 
2000  FORMAT(1H1)                                                               
      STOP                                                                      
      END                                                                       
