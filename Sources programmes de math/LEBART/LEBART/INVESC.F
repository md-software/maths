      SUBROUTINE INVESC(M)                                                      
C***********************************************************************        
C     DIMENSION XX(LIM),B(LIM,LIM)                                              
C     COMMON/BL3/ UC(LIM-1),C(LIM,LIM),U(LIM-1,LIM-1)                           
C***********************************************************************        
      DIMENSION XX(30),B(30,30)                                                 
      COMMON /BL3/US,UC(29),C(30,30),U(29,29)                                   
      N=M+1                                                                     
      Z=0.                                                                      
      DO 10 J=1,M                                                               
      XX(J)=0.                                                                  
      DO 11 K=1,M                                                               
   11 XX(J)=XX(J)+U(J,K)*UC(K)                                                  
      Z=Z+UC(J)*XX(J)                                                           
      DO 10 I=1,M                                                               
      C(I,J)=0.                                                                 
   10 B(I,J)=UC(I)*XX(J)                                                        
      Z=US-Z                                                                    
      DO 20 J=1,M                                                               
      C(J,N)=-XX(J)/Z                                                           
      C(N,J)=C(J,N)                                                             
      DO 20 K=1,M                                                               
      B(K,J)=B(K,J)/Z                                                           
      IF(K.EQ.J) B(K,J)=B(K,J)+1.                                               
      DO 20 I=1,M                                                               
   20 C(I,J)=C(I,J)+U(I,K)*B(K,J)                                               
      C(N,N)=1./Z                                                               
      RETURN                                                                    
      END                                                                       
