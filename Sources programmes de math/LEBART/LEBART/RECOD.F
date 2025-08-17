      SUBROUTINE RECOD(IDIM,ICARD,NV,X,MODEX,NCLAS,BX,NV3,V1,V2,KV)             
      DIMENSION X(IDIM,NV),MODEX(NV),NCLAS(NV),BX(50,NV3)                       
      DIMENSION V1(ICARD),V2(ICARD),KV(ICARD),QT(51)                            
      I3=0                                                                      
      DO 80 J=1,NV                                                              
      MD=MODEX(J)                                                               
      IF (MD.EQ.0) GOTO 80                                                      
      DO 10 I=1,ICARD                                                           
10    V1(I)=X(I,J)                                                              
      NC=NCLAS(J)                                                               
      NB=NC-1                                                                   
      IF (MD.EQ.1) GOTO 20                                                      
      IF (MD.EQ.2) GOTO 30                                                      
      IF (MD.EQ.3) GOTO 40                                                      
20    CALL EFEGO(ICARD,V1,QT,NC,V2,KV)                                          
      GOTO 60                                                                   
30    CALL AMPEG(ICARD,V1,NC)                                                   
      GOTO 60                                                                   
40    I3=I3+1                                                                   
      DO 50 I=1,NB                                                              
50    QT(I)=BX(I,I3)                                                            
      CALL BOFIX(ICARD,V1,QT,NB)                                                
60    DO 70 I=1,ICARD                                                           
70    X(I,J)=V1(I)                                                              
80    CONTINUE                                                                  
      RETURN                                                                    
      END
