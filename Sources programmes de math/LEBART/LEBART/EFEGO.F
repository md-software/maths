      SUBROUTINE EFEGO(ICARD,V,QT,NCLAS,X,KV)                                   
      DIMENSION V(ICARD),QT(NCLAS),X(ICARD),KV(ICARD)                           
      DO 10 I=1,ICARD                                                           
10    X(I)=V(I)                                                                 
      NB=NCLAS-1                                                                
      CALL QUANT (ICARD,X,QT,NB,KV)                                             
      CALL BOFIX(ICARD,V,QT,NB)                                                 
      RETURN                                                                    
      END        
