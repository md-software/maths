C  **********************************************
C  *                                            *
C  *    PROGRAMME D'ANALYSE DE LA COVARIANCE    *
C  *                                            *  
C  ********************************************** 
      PARAMETER (NQDIM=25,KDIM=8,LDIM=100)
      COMMON /ENSOR/LEC,IMP 
      DIMENSION NMOD(NQDIM),LCUM(NQDIM),D(NQDIM),KROIS(3,KDIM),FMT(10)
      DIMENSION X(LDIM),W(LDIM,LDIM),XMOY(LDIM),A(LDIM),SA(LDIM)
      CHARACTER TEXTE*80,NATURE*4,FICH*40
      LEC=5                          
      IMP=6                          
	READ(LEC,1000) KODE
	READ(LEC,1001) FMT
1001	FORMAT(10A4)
	NVAR=0
	ITA2=0
	ITA3=0
      KCARD=ITA2+ITA3                                                           
	OPEN(1,FILE='[MICHEL.ALIM]TMP.DAT',STATUS='OLD')
1	READ(1,100,END=9) NATURE,ICARD,NQDEB,(NMOD(LQ),LQ=1,NQDEB)
	FICH = '[MICHEL.ALIM]' // NATURE // '.DAT'
	OPEN(8,FILE=FICH,STATUS='OLD')
	TEXTE = 'RATIONS HEBDOMADAIRES EN ' // NATURE //
     1                        ' (POUR TAHITI)'
      WRITE(IMP,1002) TEXTE
      CALL PREMC(NQDIM,KDIM,LDIM,NQDEB,KCARD,NVAR,ICARD,                        
     1      LCARD,LTOT,NMOD,KROIS,LCUM,D,X,XMOY,W,FMT,KODE)
	IF (ICARD .EQ. LTOT) GOTO 40
      CALL MLCOV(LDIM,LTOT,ICARD,W,XMOY,A,SA,SCE,S2,R2,IFLAG)
	IF (IFLAG.EQ.1) GOTO 40
      WRITE(IMP,2000)                                                           
      CALL EDITR(LDIM,LTOT,ICARD,W,XMOY,A,SA,SCE,S2,R2,LCUM,NQDIM,NQDEB)        
      IF (NQDEB.LE.0) GOTO 40                                                   
	IF (IFLAG.EQ.2) GOTO 40
      WRITE(IMP,2000)                                                           
      CALL AVAR2(LDIM,NQDIM,KDIM,ICARD,NQDEB,NVAR,ITA2,ITA3,LTOT,               
     1       KCARD,KROIS,W,A,LCUM)                                              
40    CONTINUE
	CLOSE(8)
	GOTO 1
9	CONTINUE
	CLOSE(1)
100	FORMAT(1X,A4,I3,4I1)
1000  FORMAT(20I4)
1002	FORMAT(1H1,30X,A80)
2000  FORMAT(1H1)                                                               
      STOP                                                                      
      END                                                                       
C  *********************************************************
C  *                                                       *
C  *   MLCOV : AJUSTEMENT DES M-C SUR LE MODELE LINEAIRE   *
C  *                                                       *
C  *********************************************************
      SUBROUTINE MLCOV(LDIM,LTOT,ICARD,W,XMOY,A,SA,SCE,S2,R2,IFLAG)
      DIMENSION W(LDIM,LDIM),XMOY(LDIM),A(LDIM),SA(LDIM)                        
      LCARD=LTOT-1                                                              
      YMOY=XMOY(LTOT)                                                           
      VY=W(LTOT,LTOT)
      CALL INVER (W,LCARD,LDIM,IFLAG)
      DO 20 L=1,LCARD                                                           
      A(L)=0.                                                                   
      DO 10 K=1,LCARD                                                           
      VYXK=W(LTOT,K)                                                            
10    A(L)=A(L)+W(L,K)*VYXK                                                     
	IF (A(L).EQ.0.0) IFLAG=2
20    CONTINUE                                                                  
      A(LTOT)=YMOY                                                              
      DO 30 L=1,LCARD                                                           
30    A(LTOT)=A(LTOT)-A(L)*XMOY(L)                                              
      R2=0.                                                                     
      DO 40 L=1,LCARD                                                           
      VYXK=W(LTOT,L)                                                            
40    R2=R2+A(L)*VYXK                                                           
      R2=ABS(R2/VY)
      SCE=ICARD*VY*(1.-R2)
      S2=VY*(1.-R2)/FLOAT(ICARD-LTOT)
      S2=ABS(S2)
      DO 50 L=1,LCARD                                                           
      SA(L)=SQRT(ABS(S2*W(L,L)))
50    CONTINUE
      SLK=0.                                                                    
      DO 70 L=1,LCARD                                                           
      SK=0.                                                                     
      DO 60 K=1,LCARD                                                           
60    SK=SK+XMOY(K)*W(K,L)                                                      
      SLK=SLK+SK*XMOY(L)                                                        
70    CONTINUE                                                                  
      SA(LTOT)=SQRT(ABS(S2*(1.+SLK)))
      S2=ICARD*S2                                                               
      RETURN                                                                    
      END                                                                       
C  **********************************************
C  *                                            *
C  *   DONNI : LECTURE D'UNE LIGNE DE DONNEES   *
C  *                                            *
C  **********************************************
      SUBROUTINE DONNI(NQDIM,NQTOT,D,FMT)                                           
      DIMENSION D(NQDIM),FMT(10)
      IUNIT=8                                                                   
      READ(IUNIT,FMT) D(NQTOT),(D(L),L=1,NQTOT-1)                                           
      RETURN                                                                    
      END                                                                       
C  ****************************************************
C  *                                                  *
C  *   PREMC: PREPARATION POUR L'AJUSTEMENT DES M-C   *
C  *                                                  *
C  ****************************************************	   
      SUBROUTINE PREMC(NQDIM,KDIM,LDIM,NQDEB,KCARD,NVAR,ICARD,                  
     1       LCARD,LTOT,NMOD,KROIS,LCUM,D,X,XMOY,W,FMT,KODE)  
      COMMON /ENSOR/LEC,IMP                                                     
      DIMENSION NMOD(NQDIM),LCUM(NQDIM),D(NQDIM),KROIS(3,KDIM)                  
      DIMENSION X(LDIM),W(LDIM,LDIM),XMOY(LDIM),FMT(10)                         
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
C   **************************************
C   *                                    *
C   *   DPLOI: DEPLOIEMENT DES DONNEES   *
C   *                                    *
C   **************************************
      SUBROUTINE DPLOI(NQDIM,LDIM,KDIM,NQDEB,NVAR,KCARD,LCARD,LTOT,             
     1        KROIS,LCUM,D,X)                                                   
      DIMENSION KROIS(3,KDIM),LCUM(NQDIM),D(NQDIM),X(LDIM)                      
      NJ=LCUM(NQDEB+1)                                                          
      LCARD=LCUM(NQDEB+NVAR+KCARD+1)                                            
      IF (NQDEB.LE.0) GOTO 50                                                   
      DO 10 J=1,LCARD                                                           
10    X(J)=0.0                                                                  
      DO 40 J=1,NQDEB                                                           
      KAT=D(J)+0.001                                                            
      LIBJ=LCUM(J+1)-LCUM(J)                                                    
      JJ=LCUM(J)                                                                
      IF (KAT.NE.(LIBJ+1)) GOTO 30                                              
      DO 20 L=1,LIBJ                                                            
      JL=JJ+L                                                                   
20    X(JL)=-1.0                                                                
      GOTO 40                                                                   
30    JX=JJ+KAT                                                                 
      X(JX)=1.0                                                                 
40    CONTINUE                                                                  
50    CONTINUE                                                                  
      IF (NVAR.LE.0) GOTO 70                                                    
      DO 60 JJ=1,NVAR                                                           
      J=NJ+JJ                                                                   
      JQ=NQDEB+JJ                                                               
60    X(J)=D(JQ)                                                                
      NJ=NJ+NVAR                                                                
70    CONTINUE                                                                  
      IF (KCARD.LE.0) GOTO 140                                                  
      DO 130 K=1,KCARD                                                          
      K1=KROIS(1,K)                                                             
      JD1=LCUM(K1)+1                                                            
      JF1=LCUM(K1+1)                                                            
      K2=KROIS(2,K)                                                             
      JD2=LCUM(K2)+1                                                            
      JF2=LCUM(K2+1)                                                            
      K3=KROIS(3,K)                                                             
      JD3=LDIM                                                                  
      JF3=LDIM                                                                  
      X(LDIM)=1.0                                                               
      IF (K3.LE.0) GOTO 80                                                      
      JD3=LCUM(K3)+1                                                            
      JF3=LCUM(K3+1)                                                            
80    CONTINUE                                                                  
      DO 120 J1=JD1,JF1                                                         
      DO 110 J2=JD2,JF2                                                         
      DO 110 J3=JD3,JF3                                                         
      NJ=NJ+1                                                                   
      X(NJ)=X(J1)*X(J2)*X(J3)                                                   
110   CONTINUE                                                                  
120   CONTINUE                                                                  
130   CONTINUE                                                                  
140   CONTINUE                                                                  
      LCARD=NJ                                                                  
      LTOT=LCARD+1                                                              
      X(LTOT)=D(NQDEB+NVAR+1)                                                   
      RETURN                                                                    
      END                                                     
C  ************************************************************
C  *                                                          *
C  *   EDITR: EDITION DES RESULTATS DE L'AJUSTEMENT DES M-C   *
C  *                                                          *
C  ************************************************************	                   
      SUBROUTINE EDITR (LDIM,LTOT,ICARD,W,XMOY,A,SA,SCE,S2,R2,
     *                            LCUM,NQDIM,NQDEB)
      COMMON /ENSOR/LEC,IMP                                                     
      DIMENSION LCUM(NQDIM)                                                     
      DIMENSION W(LDIM,LDIM),XMOY(LDIM),A(LDIM),SA(LDIM)                        
      NQFIN=LCUM(NQDEB+1)                                                       
      WRITE(IMP,1000) ICARD,LTOT                                                
      NDL=ICARD-LTOT                                                            
      LCARD=LTOT-1                                                              
      WRITE(IMP,1100) NDL                                                       
      N=2                                                                       
      DO 10 L=1,LCARD                                                           
	IF (SA(L) .EQ. 0.0) SA(L)=0.00001
      TL=ABS(A(L)/SA(L))                                                        
      PL=2.*(1.-RNKSF(3,TL,NDL,NDL))                                            
      WRITE(IMP,1200) L,A(L),SA(L),TL,PL                                        
      IF (L.GT.NQFIN) GOTO 10                                                   
      IF (L.NE.LCUM(N)) GOTO 10                                                 
      SOM=0.                                                                    
      LL1=LCUM(N-1)+1                                                           
      LL2=LCUM(N)                                                               
      DO 19 LL=LL1,LL2                                                          
19    SOM=SOM+A(LL)                                                             
      SOM=-SOM                                                                  
      VAR=0.                                                                    
      DO 30 LX=LL1,LL2                                                          
      DO 30 LY=LL1,LL2                                                          
30    VAR=VAR+W(LX,LY)                                                          
      VAR=SQRT(ABS(S2*VAR/ICARD))
      TL=ABS(SOM/VAR)                                                           
      PL=2.*(1.-RNKSF(3,TL,NDL,NDL))                                            
      WRITE(IMP,1250) SOM,VAR,TL,PL                                             
      N=N+1                                                                     
10    CONTINUE                                                                  
      T0=ABS(A(LTOT)/SA(LTOT))                                                  
      P0=2.*(1.-RNKSF(3,T0,NDL,NDL))                                            
      WRITE(IMP,1300) A(LTOT),SA(LTOT),T0,P0                                    
      R=SQRT(ABS(R2))
      S=SQRT((S2))
      WRITE(IMP,1400) SCE,R,R2,S2,S                                             
      SM=0.                                                                     
      DO 20 L=1,LCARD                                                           
      SM=SM+A(L)*W(L,LTOT)                                                      
20    CONTINUE                                                                  
      F=ABS((SM/FLOAT(LCARD))/(S2/FLOAT(ICARD)))
      PF=1.-RNKSF(4,F,LCARD,NDL)                                                
      WRITE(IMP,1500) LCARD,F,LCARD,NDL,PF                                      
1000  FORMAT(1H0,74(1H-)/1H0,30HAJUSTEMENT DES MOINDRES-CARRES,                 
     1 22H (AVEC TERME CONSTANT)/1H0,15X,I5,11H  INDIVIDUS,6X,                  
     2  I3,2X,30HVARIABLES (CONSTANTE EN QUEUE) /1H ,74(1H-) /)                 
1100  FORMAT(1H0,42HVARIABLE           COEFFICIENT  ECART-TYPE ,                
     1   2X,7HSTUDENT,I4,3X,13HPROB-CRITIQUE )                                  
1200  FORMAT(1H0,3X,I2,12X,4F12.4)                                              
1250  FORMAT(1H0,17X,4F12.4)                                                    
1300  FORMAT(1H0,9HCONSTANTE,8X,4F12.4)                                         
1400  FORMAT(/1H0,27HSOMME DES CARRES DES ECARTS,9X,5HSCE =,F15.4//             
     1   1H ,41HCOEFFICIENT DE CORRELATION MULTIPLE   R = ,F6.4,                
     2    10X,4HR2 =,F6.4//1H ,28HVARIANCE ESTIMEE DES RESIDUS ,9X,             
     3     4HS2 =,F12.4,4X,3HS =,F12.4/)                                        
1500  FORMAT(1H0,48HTEST DE NULLITE SIMULTANEE DES COEFFICIENTS DES  ,          
     1  I3,11H  VARIABLES/1H0,8HFISHER =,F10.3,4X,15HDEGRES DE LIB =,           
     2   I3,I5,3X,16HPROBA-CRITIQUE =,F8.4//1H ,74(1H-)//)                      
      RETURN                                                                    
      END                                                                       
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
C  *******************************
C  *                             *
C  *  DEWAW : UTILISE PAR AVAR2  *
C  *                             *
C  *******************************  
      SUBROUTINE DEWAW(NDIM,NTOT,W,KX,KMOD)                                     
      DIMENSION W(NDIM,NDIM)                                                    
      DO 10 J=1,NTOT                                                            
      DO 10 L=J,NTOT                                                            
      IF (J.EQ.KX.OR.L.EQ.KX) GOTO 10                                           
      W(J,L)=W(J,L)-W(J,KX)*W(KX,L)/W(KX,KX)                                    
      W(L,J)=W(J,L)                                                             
10    CONTINUE                                                                  
      DO 20 J=1,NTOT                                                            
      IF (J.EQ.KX) GOTO 20                                                      
      W(J,KX)=KMOD*W(J,KX)/W(KX,KX)                                             
      W(KX,J)=W(J,KX)                                                           
20    CONTINUE                                                                  
      W(KX,KX)=-1./W(KX,KX)                                                     
      RETURN                                                                    
      END                                                                       
C  ************************************************************
C  *                                                          * 
C  *  COMAJ:  CALCUL DE LA MATRICE DES VARIANCES-COVARIANCES  *
C  *                                                          *
C  ************************************************************ 	
      SUBROUTINE COMAJ(MODE,NDIM,NVAR,W,XMOY,XI,PI,SOMP,KOMPT)                  
      DIMENSION W(NDIM,NDIM),XMOY(NDIM),XI(NDIM)                                
      DATA ZERO/0.0/UN/1.0/                                                     
      IF (MODE.LT.0) GOTO 170                                                   
      IF (MODE-1) 10,60,120                                                     
10    SOMP=PI                                                                   
20    CONTINUE                                                                  
      DO 50 J=1,NVAR                                                            
      IF (PI.LT.ZERO) GOTO 30                                                   
      XMOY(J)=XI(J)                                                             
      GOTO 40                                                                   
30    XMOY(J)=XMOY(J)+PNORM*(XI(J)-XMOY(J))                                     
40    XI(J)=ZERO                                                                
      DO 50 L=1,J                                                               
      W(J,L)=ZERO                                                               
50    W(L,J)=ZERO                                                               
      KOMPT=1                                                                   
      MODE=1                                                                    
      GOTO 170                                                                  
60    CONTINUE                                                                  
      IF (PI) 70,170,80                                                         
70    KOMPT=KOMPT-1                                                             
      GOTO 90                                                                   
80     KOMPT=KOMPT+1                                                            
90    SOMP=SOMP+PI                                                              
      IF (SOMP.LE.0.0) GOTO 160                                                 
      PNORM=PI/SOMP                                                             
      IF (KOMPT-1) 160,20,100                                                   
100   COEF=PI-PNORM*PI                                                          
      DO 110J=1,NVAR                                                            
      XI(J)=XI(J)-XMOY(J)                                                       
      XMOY(J)=XMOY(J)+PNORM*XI(J)                                               
      DO 110 L=1,J                                                              
      W(J,L)=W(J,L)+COEF*XI(J)*XI(L)                                            
110   W(L,J)=W(J,L)                                                             
      GOTO 170                                                                  
120   CONTINUE                                                                  
      DO 130 J=2,NVAR                                                           
      SJ=W(J,J)                                                                 
      IF (SJ.LE.ZERO) GOTO 160                                                  
      J1=J-1                                                                    
      DO 130 L=1,J1                                                             
      SL=W(L,L)                                                                 
      IF (SL.LE.ZERO) GOTO 160                                                  
      W(J,L)=W(J,L)/SQRT(ABS(SJ*SL))
130   W(L,J)=W(J,L)                                                             
      DO 150 J=1,NVAR                                                           
      XI(J)=SQRT(ABS(W(J,J)/SOMP))
150   W(J,J)=UN                                                                 
      MODE=-3                                                                   
      GOTO 170                                                                  
160   MODE=-MODE                                                                
170   RETURN                                                                    
      END                                                                       
C  **********************************
C  *                                * 
C  *   LOIS STATISTIQUES USUELLES   *
C  *                                *
C  ********************************** 
      FUNCTION RNKSF(MODE,X,N1,N2)                                              
      DIMENSION H(5)                                                            
      DATA H(1)/0.319382/H(2)/-0.356564/H(3)/1.781478/                          
     1 H(4)/-1.821256/H(5)/1.330274/                                            
      FN1=N1
      FN2=N2
      IF (ABS(X).LT.0.0000001) GOTO 100                                         
      GOTO (10,20,30,40) , MODE                                                 
10    Z=X                                                                       
      GOTO 80                                                                   
20    FISH=X/FN1                                                                
      FN2=1.0 E10                                                               
      GOTO 50                                                                   
30    FISH=X*X                                                                  
      FN2=FN1                                                                   
      FN1=1.0                                                                   
      GOTO 50                                                                   
40    FISH=X                                                                    
50    F=FISH                                                                    
      IF (FISH.GE.1.0) GOTO 60                                                  
      F=1.0/FISH                                                                
      PIV=FN1                                                                   
      FN1=FN2                                                                   
      FN2=PIV                                                                   
60    A1=2.0/(9.*FN1)                                                           
      A2=2.0/(9.*FN2)                                                           
      Z=(1.0-A2)*(F**0.33333333)-(1.0-A1)                                       
      Z=Z/SQRT(ABS(A1+A2*F**0.666667))
      IF (FN2.LE.3.) Z=Z*(1.+0.08*(Z**4)/FN2**3)                                
      IF (ABS(Z).LE.6.0) GOTO 80                                                
      IF (Z.GT.6.) GOTO 70                                                      
      RNKSF=0.                                                                  
      RETURN                                                                    
70    RNKSF=1.                                                                  
      RETURN                                                                    
80    Y=EXP(-Z*Z/2.)*0.39894228                                                 
      Q=1./(1.+0.2316419*ABS(Z))                                                
      SOM=0.0                                                                   
      DO 90 I=1,5                                                               
90    SOM=SOM+H(I)*Q**I                                                         
      RNKSF=0.5+SIGN(1.,Z)*(0.5-Y*SOM)                                          
      IF (MODE.EQ.1) RETURN                                                     
      IF (FISH.LT.1.) RNKSF=1.-RNKSF                                            
      IF (MODE.NE.3) RETURN                                                     
      RNKSF=RNKSF+0.5*(1.-RNKSF)                                                
      IF (X.LE.0.0) RNKSF=1.0-RNKSF                                             
      RETURN                                                                    
100   GOTO (110,120,110,120) , MODE                                             
110   RNKSF=0.5                                                                 
      RETURN                                                                    
120   RNKSF=0.0                                                                 
      RETURN                                                                    
      END
C ********************************
C *                              *
C *    INVERSION DE MATRICES     *
C *                              *
C ********************************
	SUBROUTINE INVER (A,N,NDIM,IFLAG)
	DIMENSION A(NDIM,NDIM)
	COMMON /ENSOR/LEC,IMP
	IFLAG=0
	DO 200 K=1,N
	D=A(K,K)
	IF (D.EQ.0.0) GOTO 300
	A(K,K)=1
	DO 100 J=1,N
100	A(K,J)=A(K,J)/D
	DO 200 I=1,N
	IF (I.EQ.K) GOTO 200
	D=A(I,K)
	A(I,K)=0.0
	DO 200 J=1,N
	A(I,J)=A(I,J)-D*A(K,J)
200	CONTINUE
	RETURN
300	WRITE(IMP,1000)
1000	FORMAT(1H0,'**** PIVOT NUL ****')
	IFLAG=1
	RETURN
	END
