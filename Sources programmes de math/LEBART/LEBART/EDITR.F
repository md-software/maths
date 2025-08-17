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
