C  *************************************************
C  *                                               *
C  *   AVAR2: PROGRAMME D'ANALYSE DE LA VARIANCE   *
C  *                                               *
C  *************************************************
      SUBROUTINE AVAR2(LDIM,NQDIM,KDIM,ICARD,NQDEB,NVAR,ITA2,ITA3,LTOT,         
     1        KCARD,KROIS,W,A,LCUM)                                             
      COMMON /ENSOR/LEC,IMP                                                     
      DIMENSION W(LDIM,LDIM),A(LDIM),LCUM(NQDIM),KROIS(3,KDIM),IND(4)           
      CARDI=ICARD                                                               
      LCARD=LTOT-1                                                              
      W(LTOT,LTOT)=CARDI*W(LTOT,LTOT)                                           
      DO 20 K=1,LCARD                                                           
      W(LTOT,LTOT)=W(LTOT,LTOT)-CARDI*W(K,LTOT)*A(K)                            
      W(K,LTOT)=A(K)                                                            
      W(LTOT,K)=A(K)                                                            
      DO 10 L=1,LCARD                                                           
10    W(K,L)=-W(K,L)/CARDI                                                      
20    CONTINUE                                                                  
      WRITE(IMP,1000)                                                           
      IND(1)=NQDEB                                                              
      IND(2)=NVAR                                                               
      IND(3)=ITA2                                                               
      IND(4)=ITA3                                                               
      NQ=NQDEB+NVAR+ITA2+ITA3                                                   
      SCE00=W(LTOT,LTOT)                                                        
      NDL00=ICARD-(LCARD+1)                                                     
      DL00=NDL00                                                                
      WRITE(IMP,1100) SCE00,NDL00                                               
      DO 60 II=1,4                                                              
      I=5-II                                                                    
      NQ=NQ-IND(I)                                                              
      KFIN=IND(I)                                                               
      IF (I.EQ.2.OR.KFIN.LE.0) GOTO 60                                          
      DO 50 K=1,KFIN                                                            
      KK=K                                                                      
      KX1=LCUM(NQ+KK)+1                                                         
      IF ((II.EQ.2).AND.(NVAR*ITA2.NE.0)) KK=KFIN                               
      KX2=LCUM(NQ+KK+1)                                                         
      KPT=0                                                                     
      KMOD=-1                                                                   
      DO 30 KX=KX1,KX2                                                          
      CALL DEWAW(LDIM,LTOT,W,KX,KMOD)                                           
      KPT=KPT+1                                                                 
30    CONTINUE                                                                  
      SCEK=W(LTOT,LTOT)                                                         
      SCE1=SCEK-SCE00                                                           
      NDL1=KPT                                                                  
      DL1=NDL1                                                                  
      FK=ABS((SCE1/DL1)/(SCE00/DL00))
      PK=1.0-RNKSF(4,FK,NDL1,NDL00)                                             
      IF (II.EQ.1) WRITE(IMP,1200) (KROIS(J,ITA2+K),J=1,3),                     
     1        SCE1,FK,NDL1,NDL00,PK                                             
      IF (II.EQ.2) WRITE(IMP,1300) (KROIS(J,K),J=1,2),                          
     1        SCE1,FK,NDL1,NDL00,PK                                             
      IF (II.EQ.4) WRITE(IMP,1400) K, SCE1,FK,NDL1,NDL00,PK                     
      KMOD=1                                                                    
      DO 40 KX=KX1,KX2                                                          
      CALL DEWAW (LDIM,LTOT,W,KX,KMOD)                                          
40    CONTINUE                                                                  
      IF ((II.EQ.2).AND.(NVAR*ITA2.NE.0)) GOTO 60                               
50    CONTINUE                                                                  
60    CONTINUE                                                                  
      WRITE(IMP,1500)                                                           
1000  FORMAT(1H0,86(1H-)/1H0,10X,22HANALYSE DE LA VARIANCE /1H0,                
     1 60HNB. AJUSTEMENT DES M-C SUR LE MODELE RENDU DE PLEIN RANG PAR,         
     2 25H LES CONTRAINTES = SOMMES/1H ,4X,24HNULLES DES COEFFICIENTS.,         
     3 55H LES SOMMES DE CARRES CORRESPONDENT A L-ANNULATION SUC-/1H ,          
     4 4X,56HCESSIVE DE GROUPES DE COEFF SUR CE MODELE DE PLEIN RANG./          
     5 1H0,86(1H-)/1H0,6HSOURCE,15X,16HSOMME DES CARRES,7X,6HFISHER,4X,         
     6 13HDEGRES DE LIB,5X,14HPROBA-CRITIQUE /)                                 
1100  FORMAT(1H0,16HECARTS RESIDUELS,5X,F15.3,22X,I6)                           
1200  FORMAT(1H0,11HINTERACTION,3I3,2F16.3,2(2X,I4),11X,F7.4)                   
1300  FORMAT(1H0,11HINTERACTION,2I3,3X,2F16.3,2(2X,I4),11X,F7.4)                
1400  FORMAT(1H0,3X,7HCRITERE,I4,6X,2F16.3,2(2X,I4),11X,F7.4)                   
1500  FORMAT(1H0,86(1H-)/)                                                      
      RETURN                                                                    
      END                                                                       
