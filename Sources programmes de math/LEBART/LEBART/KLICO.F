      SUBROUTINE KLICO (MODE,NDIM,KDIM,N,K,T,IDN,IDK)                                
      DIMENSION T(NDIM,KDIM),IDN(NDIM),IDK(KDIM)                                         
      COMMON /ENSOR/LEC,IMP                                                     
      KOL=5*(MODE+1)                                                            
      DO 120 L=1,K,KOL                                                          
      KFIN=L+(KOL-1)                                                            
      IF (KFIN.GT.K) KFIN=K                                                     
      WRITE(IMP,810)                                                            
      GOTO (10,20,30) , MODE                                                    
10    WRITE(IMP,610) (IDK(J),J=L,KFIN)                                          
      GOTO 40                                                                   
20    WRITE(IMP,620) (IDK(J),J=L,KFIN)                                          
      GOTO 40                                                                   
30    WRITE(IMP,630) (IDK(J),J=L,KFIN)                                          
40    WRITE(IMP,800)                                                            
      DO 80 I=1,N                                                               
      GOTO (50,60,70) ,MODE                                                     
50    WRITE(IMP,710) IDN(I),(T(I,J),J=L,KFIN)                                   
      GOTO 80                                                                   
60    WRITE(IMP,720) IDN(I),(T(I,J),J=L,KFIN)                                   
      GOTO 80                                                                   
70    WRITE(IMP,730) IDN(I),(T(I,J),J=L,KFIN)                                   
80    CONTINUE                                                                  
      WRITE(IMP,800)                                                            
      GOTO (90,100,110) ,MODE                                                   
90    WRITE(IMP,610) (IDK(J),J=L,KFIN)                                          
      GOTO 120                                                                  
100   WRITE(IMP,620) (IDK(J),J=L,KFIN)                                          
      GOTO 120                                                                  
110   WRITE(IMP,630) (IDK(J),J=L,KFIN)                                          
120   CONTINUE                                                                  
      RETURN                                                                    
610   FORMAT(1H0,9X,10(4X,A4,4X))                                               
620   FORMAT(1H0,9X,15(2X,A4,2X))                                               
630   FORMAT(1H0,9X,20(1X,A4,1X))                                               
710   FORMAT(1H ,A6,2X,10F12.3)                                                 
720   FORMAT(1H ,A6,2X,15F8.2)                                                  
730   FORMAT(1H ,A6,2X,20F6.0)                                                  
800   FORMAT(1H0,130(1H-))                                                      
810   FORMAT(1H ,///)                                                           
      END
