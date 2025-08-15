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
