C ******************************************
C   CLASH
C   CLASSIFICATION ASCENDANTE HIERARCHIQUE
C ******************************************
      PARAMETER (IDIM=500,JDIM=50,MDIM=999,IDDIM=124750)
      DIMENSION T(IDIM,JDIM),IDI(IDIM),PI(MDIM),PJ(JDIM),D(IDDIM)
     1            ,IDJ(JDIM)
      DIMENSION NUM(IDIM),V(IDIM),IW(IDIM),NC(IDIM),W(IDIM)
     1           ,ID(IDIM)                  
      DIMENSION LA(IDIM),LB(IDIM),LP(MDIM),VAL(MDIM),NO(MDIM)
      COMMON /ENSOR/LEC,IMP                      
      character*1 BLC(4)
      integer*4 IBLC
	equivalence(iblc,blc)
      DATA BLC/' ',' ',' ',' '/
      LEC=5                                                                    
      IMP=6                                                                     
      READ(LEC,100) KODE
100   FORMAT(I1)
      CALL DONNK(MODE,IDIM,JDIM,ICARD,JCARD,T,IDI)
      DO 10 J=1,JCARD
10    IDJ(J)=IBLC
      MKLI=2    
      IF (KODE.EQ.1) CALL KLICO(MKLI,IDIM,JDIM,ICARD,JCARD,T,IDI,IDJ)
      MCARD=ICARD*(ICARD-1)/2                                        
      CALL DISTK(IDIM,JDIM,MDIM,IDDIM,ICARD,JCARD,MCARD,T,PI,PJ,D)  
      CALL DTRIG (ICARD,MCARD,D,IDI,PI)
      IFIN=2*ICARD-1                                                
      CALL CLAS4(MODE,ICARD,MCARD,IFIN,D,PI,IDI,LA,LB,LP,VAL,NO,
     1           IDIM,MDIM,IDDIM)                
      CALL EDCHA(ICARD,IFIN,IDI,LA,LB,LP,VAL,NUM,V,NO,NC,IW,W,ID,
     1           IDIM,MDIM,IDDIM)               
      STOP                                                                      
      END                                                                       
