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
