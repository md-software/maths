C  **********************************
C  *                                * 
C  *   LOIS STATISTIQUES USUELLES   *
C  *                                *
C  ********************************** 
      FUNCTION RNKSF(MODE,X,N1,N2)                                              
      DIMENSION H(5)                                                            
      DATA H(1)/0.319382/H(2)/-0.356564/H(3)/1.781478/                          
     1 H(4)/-1.821256/H(5)/1.330274/                                            
      FN1=N1
      FN2=N2
      IF (ABS(X).LT.0.0000001) GOTO 100                                         
      GOTO (10,20,30,40) , MODE                                                 
10    Z=X                                                                       
      GOTO 80                                                                   
20    FISH=X/FN1                                                                
      FN2=1.0 E10                                                               
      GOTO 50                                                                   
30    FISH=X*X                                                                  
      FN2=FN1                                                                   
      FN1=1.0                                                                   
      GOTO 50                                                                   
40    FISH=X                                                                    
50    F=FISH                                                                    
      IF (FISH.GE.1.0) GOTO 60                                                  
      F=1.0/FISH                                                                
      PIV=FN1                                                                   
      FN1=FN2                                                                   
      FN2=PIV                                                                   
60    A1=2.0/(9.*FN1)                                                           
      A2=2.0/(9.*FN2)                                                           
      Z=(1.0-A2)*(F**0.33333333)-(1.0-A1)                                       
      Z=Z/SQRT(ABS(A1+A2*F**0.666667))
      IF (FN2.LE.3.) Z=Z*(1.+0.08*(Z**4)/FN2**3)                                
      IF (ABS(Z).LE.6.0) GOTO 80                                                
      IF (Z.GT.6.) GOTO 70                                                      
      RNKSF=0.                                                                  
      RETURN                                                                    
70    RNKSF=1.                                                                  
      RETURN                                                                    
80    Y=EXP(-Z*Z/2.)*0.39894228                                                 
      Q=1./(1.+0.2316419*ABS(Z))                                                
      SOM=0.0                                                                   
      DO 90 I=1,5                                                               
90    SOM=SOM+H(I)*Q**I                                                         
      RNKSF=0.5+SIGN(1.,Z)*(0.5-Y*SOM)                                          
      IF (MODE.EQ.1) RETURN                                                     
      IF (FISH.LT.1.) RNKSF=1.-RNKSF                                            
      IF (MODE.NE.3) RETURN                                                     
      RNKSF=RNKSF+0.5*(1.-RNKSF)                                                
      IF (X.LE.0.0) RNKSF=1.0-RNKSF                                             
      RETURN                                                                    
100   GOTO (110,120,110,120) , MODE                                             
110   RNKSF=0.5                                                                 
      RETURN                                                                    
120   RNKSF=0.0                                                                 
      RETURN                                                                    
      END
