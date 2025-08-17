      SUBROUTINE AMPEG(ICARD,V,NCLAS)                                           
      DIMENSION V(ICARD)                                                        
      VMAX=V(1)                                                                 
      VMIN=V(1)                                                                 
      DO 10 I=1,ICARD                                                           
      IF (V(I).LT.VMIN) VMIN=V(I)                                               
      IF (V(I).GT.VMAX) VMAX=V(I)                                               
10    CONTINUE                                                                  
      PAS=(VMAX-VMIN)/FLOAT(NCLAS)                                              
      DO 20 I=1,ICARD                                                           
      VI=(V(I)-VMIN)/PAS                                                        
      K=VI+0.999999                                                             
      IF (K.EQ.0) K=1                                                           
20    V(I)=K                                                                    
      RETURN                                                                    
      END
