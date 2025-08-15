      SUBROUTINE DTRIG(ICARD,MCARD,D,IDI,PI)                                    
      DIMENSION D(MCARD),IDI(ICARD),PI(ICARD)                                   
      COMMON /ENSOR/LEC,IMP                                                     
      DATA KOL/20/                                                              
      LMAX=(ICARD-1)/KOL+1                                                      
      WRITE(IMP,600)                                                            
      DO 20 L=1,LMAX                                                            
      IDEB=(L-1)*KOL+1                                                          
      IFIN=IDEB+KOL-1                                                           
      IF (L.EQ.LMAX) IFIN=ICARD                                                 
      WRITE(IMP,610) (IDI(II),II=IDEB,IFIN)                                     
      DO 10 I=1,ICARD                                                           
      II=(I-1)*(I-2)/2                                                          
      I1=I-1                                                                    
      IMIN=MIN0(IFIN,I1)                                                        
      IF (IMIN.LT.IDEB) GOTO 10                                                 
      KDEB=II+IDEB                                                              
      KFIN=II+IMIN                                                              
      WRITE(IMP,620) PI(I),IDI(I),(D(K),K=KDEB,KFIN)                            
10    CONTINUE                                                                  
      WRITE(IMP,610) (IDI(II),II=IDEB,IFIN)                                     
20    CONTINUE                                                                  
600   FORMAT(1H1,15X,                                                           
     1   34HTABLEAU TRIANGULAIRE DES DISTANCES / 1H ,64(2H- )/)                 
610   FORMAT(1H0,5HPOIDS,6X,20(1X,A4,1X)/)                                      
620   FORMAT(1H ,F5.3,1X,A4,20(F6.2))                                           
      RETURN                                                                    
      END
