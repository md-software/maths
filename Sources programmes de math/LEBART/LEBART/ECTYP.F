      SUBROUTINE ECTYP(NSTOP)                                                   
C***********************************************************************        
C     DIMENSION ET(2,NV)                                                        
C     COMMON/BL1/ NPG(2),X(NT,NV),XM(3,NV),T(NV,NV)                             
C***********************************************************************        
      DIMENSION ET(2,100)                                                       
      COMMON /BL1/NV,NT,NOS,LIM,NPG(2),X(500,20),XM(3,20),T(20,20)              
      ND=0                                                                      
      DO 12 I=1,2                                                               
      NP=ND+1                                                                   
      ND=NP+NPG(I)-1                                                            
      DO 12 K=1,NV                                                              
      S=0.0                                                                     
      DO 13 J=NP,ND                                                             
      S2=(X(J,K)-XM(I,K))**2                                                    
      S=S+S2                                                                    
   13 CONTINUE                                                                  
      ET(I,K)=S/NPG(I)                                                          
      ET(I,K)=SQRT(ET(I,K))                                                     
   12 CONTINUE                                                                  
      WRITE(NOS,27) (I,I=1,2)                                                   
   27 FORMAT(///20X,11H ECART TYPE/21X,10(1H*)////16X,6HGROUPE//17X,2(I5        
     1,5X)/)                                                                    
      WRITE(NOS,111)                                                            
  111 FORMAT(9H0VARIABLE/)                                                      
      DO 28 J=1,NV                                                              
   28 WRITE(NOS,29) J,(ET(I,J),I=1,2)                                           
   29 FORMAT(5X,I2,5X, 2F10.5)                                                  
      NSTOP=0                                                                   
      DO 1 I=1,NV                                                               
      IF(ET(1,I).NE.0.0) GOTO 1                                                 
      IF(ET(2,I).NE.0.0) GOTO 1                                                 
      NSTOP=1                                                                   
      GOTO 5                                                                    
    1 CONTINUE                                                                  
      GOTO 7                                                                    
    5 WRITE(NOS,6)                                                              
    6 FORMAT(//91H0IL Y A MOINS UNE VARIABLE QUI A UN ECART TYPE NUL            
     1POUR LA TOTALITE DES INDIVIDUS - STOP)                                    
    7 RETURN                                                                    
      END                                                                       
