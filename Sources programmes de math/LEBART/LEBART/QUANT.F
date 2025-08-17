      SUBROUTINE QUANT(ICARD,V,QT,NB,KV)                                        
      DIMENSION V(ICARD),KV(ICARD),QT(NB)                                       
      CALL SHELK(ICARD,V,KV)                                                    
      NCLAS=NB+1                                                                
      DO 10 K=1,NB                                                              
      I1=0.9999+FLOAT(K*ICARD)/NCLAS                                            
      I2=1.0000+FLOAT(K*ICARD)/NCLAS                                            
      QT(K)=(V(I1)+V(I2))/2.0                                                   
10    CONTINUE                                                                  
      RETURN                                                                    
      END
