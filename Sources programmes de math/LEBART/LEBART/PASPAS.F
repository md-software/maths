      SUBROUTINE PASPAS                                                         
C***********************************************************************        
C     DIMENSION IMP(LIM)                                                        
C     COMMON/BL1/ NPG(2),X(NT,NV),XM(3,NV),T(NV,NV)                             
C     COMMON/BL2/ CLA(2,2),COEF(LIM),DIF(LIM),NVAR(NV)                          
C     COMMON/BL3/ UC(LIM-1),C(LIM,LIM),U(LIM-1,LIM-1)                           
C     COMMON/BL4/ NPGTE(2),CLATE(2,2),XTE(NTTE,NV),XNA(NA,NV)                   
C***********************************************************************        
      DIMENSION IMP(30)                                                         
      COMMON /BL1/NV,NT,NOS,LIM,NPG(2),X(500,20),XM(3,20),T(20,20)              
      COMMON /BL2/IENT,NPAS,NLIM,NV1,CONST,CLA(2,2),COEF(30),DIF(30),           
     1NVAR(20)                                                                  
      COMMON /BL3/US,UC(29),C(30,30),U(29,29)                                   
      COMMON /BL4/NTEST,NA,NPGTE(2),CLATE(2,2),XTE(50,20),XNA(40,20)            
      INTEGER CLA,CLATE                                                         
      DO 66 I=1,NV                                                              
   66 NVAR(I)=I                                                                 
      PC2=0.0                                                                   
      DO 53 NPAS=1,LIM                                                          
      PC1=PC2                                                                   
      IF(NPAS-NV) 300,400,300                                                   
  400 IENT=NVAR(1)                                                              
      GO TO 500                                                                 
  300 NLIM=NV-NPAS+1                                                            
      CALL RECHER                                                               
      IF(NPAS.EQ.1) GOTO 44                                                     
  500 J=NV                                                                      
      LS=NPAS-1                                                                 
      DO 57 I=1,LS                                                              
      K=NVAR(J)                                                                 
      UC(I)=T(K,IENT)                                                           
      J=J-1                                                                     
   57 CONTINUE                                                                  
      US=T(IENT,IENT)                                                           
      CALL INVESC(LS)                                                           
      GOTO 45                                                                   
   44 C(1,1)=1./T(IENT,IENT)                                                    
   45 I=1                                                                       
      NV1=NV-NPAS                                                               
   61 K=NVAR(I)                                                                 
      IF(K.EQ.IENT) GOTO 60                                                     
      I=I+1                                                                     
      GOTO 61                                                                   
   60 IF(I.GT.NV1) GOTO 62                                                      
      DO 63 J=I,NV1                                                             
   63 NVAR(J)=NVAR(J+1)                                                         
      NVAR(NV1+1)=IENT                                                          
   62 CONTINUE                                                                  
      DIF(NPAS)=XM(1,IENT)-XM(2,IENT)                                           
      CALL CLASSE                                                               
      POUR=0.0                                                                  
      DO 47 I=1,2                                                               
   47 POUR=POUR+CLA(I,I)                                                        
      T1=NT                                                                     
      PC2=(POUR*100.0)/T1                                                       
      IF(PC1.LE.PC2) GOTO 80                                                    
      WRITE(NOS,600)                                                            
  600 FORMAT(//63H LE POURCENTAGE DE L ECHANTILLON DE BASE DECROIT AU PA        
     1S SUIVANT//)                                                              
      NRET=NPAS-1                                                               
      CALL RETOUR(NRET)                                                         
   80 DO 59 I=1,NPAS                                                            
      DO 59 J=1,NPAS                                                            
   59 U(I,J)=C(I,J)                                                             
      IMP(NPAS)=IENT                                                            
      WRITE(NOS,20) NPAS                                                        
   20 FORMAT(1H0,120(1H*)//12H0PAS NUMERO ,I4//)                                
      WRITE(NOS,48)(IMP(I),I=1,NPAS)                                            
   48 FORMAT(24H0VARIABLES ENTREES :     ,10I6 ///(24X,10I6))                   
      WRITE(NOS,5)                                                              
    5 FORMAT(//20X,32H FONCTION LINEAIRE DISCRIMINANTE/21X,31(1H*))             
      IF(NPAS.GT.10) GOTO 13                                                    
      WRITE(NOS,12) (IMP(I),I=1,NPAS)                                           
   12 FORMAT(////25X,18HVARIABLE NUMERO : /10H0CONSTANTE,7X,10I10)              
      WRITE(NOS,6)                                                              
    6 FORMAT(/)                                                                 
      WRITE(NOS,7) CONST,(COEF(I),I=1,NPAS)                                     
    7 FORMAT(F8.3,10X,10F10.3)                                                  
      GOTO 14                                                                   
   13 WRITE(NOS,12) (IMP(I),I=1,10)                                             
      WRITE(NOS,6)                                                              
      WRITE(NOS,7) CONST,(COEF(I),I=1,10)                                       
      N2=10                                                                     
   17 N1=N2+1                                                                   
      N2=N2+10                                                                  
      IF(N2.GT.NPAS) N2=NPAS                                                    
      WRITE(NOS,15) (IMP(I),I=N1,N2)                                            
   15 FORMAT(////25X,18HVARIABLE NUMERO - //17X,10I10)                          
      WRITE(NOS,6)                                                              
      WRITE(NOS,16) (COEF(I),I=N1,N2)                                           
   16 FORMAT(18X,10F10.3)                                                       
      IF(N2.NE.NPAS) GOTO 17                                                    
   14 WRITE(NOS,6)                                                              
      IF(NPAS.NE.1) GOTO 9                                                      
      WRITE(NOS,8)                                                              
    8 FORMAT(/39H0A CHAQUE PAS UN INDIVIDU EST AFFECTE -/10X,89HAU GROUP        
     1E 1 SI SA VALEUR POUR LA FONCTION LINEAIRE DISCRIMINANTE EST STRIC        
     2TEMENT POSITIVE/10X,44HAU GROUPE 2 SI ELLE EST STRICTEMENT NEGATIV        
     3E/10X,35HPAS D AFFECTATION SI ELLE EST NULLE//)                           
    9 WRITE(NOS,49) (I,I=1,2)                                                   
   49 FORMAT(//20X,47H TABLEAU DE CLASSEMENT DE L ECHANTILLON DE BASE/21        
     1X,46(1H*)//25X,20HGROUPE D AFFECTATION//26X,2(I4,3X)/)                    
      WRITE(NOS,2)                                                              
    2 FORMAT(/15H GROUPE ORIGINE/)                                              
      DO 50 I=1,2                                                               
   50 WRITE(NOS,4) I,(CLA(I,J),J=1,2)                                           
    4 FORMAT(15X,I5,3X,2I7///)                                                  
      WRITE(NOS,10) PC2                                                         
   10 FORMAT(//30H0POURCENTAGE DE BIEN CLASSES :,F10.2///)                      
      IF(NTEST.EQ.0) GOTO 11                                                    
      WRITE(NOS,1) (I,I=1,2)                                                    
    1 FORMAT(//20X,44H TABLEAU DE CLASSEMENT DE L ECHANTILLON TEST/21X,4        
     13(1H*)///25X,20HGROUPE D AFFECTATION//26X,2(I4,3X)/)                      
      WRITE(NOS,2)                                                              
      DO 3 I=1,2                                                                
    3 WRITE(NOS,4) I,(CLATE(I,J),J=1,2)                                         
      PCTE=CLATE(1,1)+CLATE(2,2)                                                
      TTE=NPGTE(1)+NPGTE(2)                                                     
      PCTE=(PCTE*100.0)/TTE                                                     
      WRITE(NOS,10) PCTE                                                        
   11 IF(PC2.EQ.100.0) GOTO 200                                                 
   53 CONTINUE                                                                  
  200 CALL RETOUR(NPAS)                                                         
   64 RETURN                                                                    
      END                                                                       
