C  ************************************************************
C  *                                                          * 
C  *  COMAJ:  CALCUL DE LA MATRICE DES VARIANCES-COVARIANCES  *
C  *                                                          *
C  ************************************************************ 	
      SUBROUTINE COMAJ(MODE,NDIM,KDIM,NVAR,W,XMOY,XI,PI,SOMP,KOMPT)
      DIMENSION W(KDIM,KDIM),XMOY(NDIM),XI(KDIM)                                
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
80    KOMPT=KOMPT+1                                                            
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
      W(J,L)=W(J,L)/SQRT(SJ*SL)                                                 
130   W(L,J)=W(J,L)                                                             
      DO 150 J=1,NVAR                                                           
      XI(J)=SQRT(W(J,J)/SOMP)                                                   
150   W(J,J)=UN                                                                 
      MODE=-3                                                                   
      GOTO 170                                                                  
160   MODE=-MODE                                                                
170   RETURN                                                                    
      END
