      SUBROUTINE DISTK(IDIM,JDIM,MDIM,IDDIM,ICARD,JCARD,MCARD,T,PI,PJ,D)                        
      EXTERNAL MONO                                                             
      DIMENSION T(IDIM,JDIM),PI(MDIM),PJ(JDIM),D(IDDIM)
      DATA ZERO/1.0E-20/                                                        
      DO 10 I=1,ICARD                                                           
      PI(I)=0.0                                                                 
      DO 10 J=1,JCARD                                                           
10    PI(I)=PI(I)+T(I,J)                                                        
      PT=0.0                                                                    
      DO 20 I=1,ICARD                                                           
20    PT=PT+PI(I)                                                               
      DO 30 J=1,JCARD                                                           
      PJ(J)=0.0                                                                 
      DO 30 I=1,ICARD                                                           
30    PJ(J)=PJ(J)+T(I,J)                                                        
      DO 40 J=1,JCARD                                                           
40    PJ(J)=PJ(J)/PT                                                            
      DO 70 I1=2,ICARD                                                          
      I3=I1-1                                                                   
      DO 70 I2=1,I3                                                             
      I1I2=MONO(I1,I2)                                                          
      D(I1I2)=0.0                                                               
      DO 60 J=1,JCARD                                                           
      IF (PJ(J).LE.0.0) GOTO 60                                                 
      AJ=T(I1,J)/PI(I1)-T(I2,J)/PI(I2)                                          
      AJ=AJ*AJ                                                                  
      IF (AJ.GT.ZERO) GOTO 50                                                   
      AJ=0.0                                                                    
      GOTO 60                                                                   
50    AJ=AJ/PJ(J)                                                               
      D(I1I2)=D(I1I2)+AJ                                                        
60    CONTINUE                                                                  
70    CONTINUE                                                                  
      DO 80 I=1,ICARD                                                           
80    PI(I)=PI(I)/PT                                                            
      RETURN                                                                    
      END                                                                       
