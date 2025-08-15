      SUBROUTINE SHELK(N,X,KX)                                                  
      DIMENSION X(N),KX(N)                                                      
      DO 10 J=1,N                                                               
      KX(J)=J                                                                   
10    CONTINUE                                                                  
      I=1                                                                       
20    I=I+1                                                                     
      IF (I.LE.N) GOTO 20                                                       
      M=I-1                                                                     
30    M=M/2                                                                     
      IF (M.EQ.0) GOTO 70                                                       
      K=N-M                                                                     
      DO 60 J=1,K                                                               
      JM=J+M                                                                    
40    JM=JM-M                                                                   
      IF (JM.LE.0) GOTO 60                                                      
50    L=JM+M                                                                    
      IF (X(L).GE.X(JM)) GOTO 60                                                
      PIV=X(JM)                                                                 
      X(JM)=X(L)                                                                
      X(L)=PIV                                                                  
      KPIV=KX(JM)                                                               
      KX(JM)=KX(L)                                                              
      KX(L)=KPIV                                                                
      GOTO 40                                                                   
60    CONTINUE                                                                  
      GOTO 30                                                                   
70    RETURN                                                                    
      END                                                                       
