      SUBROUTINE MOYEN                                                          
C***********************************************************************        
C     COMMON/BL1/ NPG(2),X(NT,NV),XM(3,NV),T(NV,NV)                             
C***********************************************************************        
      COMMON /BL1/NV,NT,NOS,LIM,NPG(2),X(500,20),XM(3,20),T(20,20)              
      ND=0                                                                      
      DO 11 I=1,3                                                               
      DO 11 J=1,NV                                                              
   11 XM(I,J)=0.0                                                               
      DO 10 I=1,2                                                               
      NP=ND+1                                                                   
      ND=NPG(I)+NP-1                                                            
      DO 10 J=NP,ND                                                             
      DO 10 K=1,NV                                                              
      XM(I,K)=XM(I,K)+X(J,K)                                                    
      XM(3,K)=XM(3,K)+X(J,K)                                                    
   10 CONTINUE                                                                  
      DO 100 I=1,2                                                              
      DO 100 J=1,NV                                                             
  100 XM(I,J)=XM(I,J)/NPG(I)                                                    
      DO 101 J=1,NV                                                             
  101 XM(3,J)=XM(3,J)/NT                                                        
      WRITE(NOS,24) (I,I=1,2)                                                   
   24 FORMAT(///20X,58H MOYENNE (LA DERNIERE COLONNE CONTIENT LA MOYENNE        
     1 GLOBALE)/21X,7(1H*)////16X,6HGROUPE//17X,3(I5,5X)/)                      
      WRITE(NOS,111)                                                            
  111 FORMAT(9H0VARIABLE/)                                                      
      DO 25 J=1,NV                                                              
   25 WRITE(NOS,26) J,(XM(I,J),I=1,3)                                           
   26 FORMAT(5X,I2,5X, 3F10.5)                                                  
      RETURN                                                                    
      END                                                                       
