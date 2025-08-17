      SUBROUTINE BOFIX(ICARD,V,B,NB)                                            
      DIMENSION V(ICARD),B(NB)                                                  
      NCLAS=NB+1                                                                
      DO 10 L=1,ICARD                                                           
      VL=V(L)                                                                   
      V(L)=NCLAS                                                                
      DO 10 I=1,NB                                                              
      J=NB-I+1                                                                  
      IF (VL.LE.B(J))V(L)=J                                                     
10    CONTINUE                                                                  
      RETURN                                                                    
      END
