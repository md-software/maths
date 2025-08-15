      SUBROUTINE DONNK(MODE,IDIM,JDIM,ICARD,JCARD,T,IDI)                             
      DIMENSION T(IDIM,JDIM),IDI(IDIM),FMT(20)                                     
      COMMON /ENSOR/LEC,IMP                                                     
      IUNIT=8                                                                   
      READ(LEC,500) MODE                                                        
      READ(LEC,500) ICARD,JCARD                                                       
      READ(LEC,510) (FMT(LL),LL=1,20)           
      I=1
1     READ(IUNIT,FMT,END=99) IDI(I),(T(I,J),J=1,JCARD)                         
      DO 10 J=1,JCARD
      IF (T(I,J).NE.0.0) GOTO 11 
10    CONTINUE
      GOTO 1
11    I=I+1
      GOTO 1
99    CONTINUE
      ICARD=I-1
      RETURN                                                                    
500   FORMAT(2I4)                                                                
510   FORMAT(20A4)                                                              
      END                                                                       
