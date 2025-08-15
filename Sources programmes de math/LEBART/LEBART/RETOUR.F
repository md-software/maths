      SUBROUTINE RETOUR(NRET)                                                   
C***********************************************************************        
C     DIMENSION YBAR(LIM),COF(LIM)                                              
C     COMMON/BL1/ NPG(2),X(NT,NV),XM(3,NV),T(NV,NV)                             
C     COMMON/BL2/ CLA(2,2),COEF(LIM),DIF(LIM),NVAR(NV)                          
C     COMMON/BL3/ UC(LIM-1),C(LIM,LIM),U(LIM-1,LIM-1)                           
C     COMMON/BL4/ NPGTE(2),CLATE(2,2),XTE(NTTE,NV),XNA(NA,NV)                   
C***********************************************************************        
      DIMENSION YBAR(30),COF(30)                                                
      COMMON /BL1/NV,NT,NOS,LIM,NPG(2),X(500,20),XM(3,20),T(20,20)              
      COMMON /BL2/IENT,NPAS,NLIM,NV1,CONST,CLA(2,2),COEF(30),DIF(30),           
     1NVAR(20)                                                                  
      COMMON /BL3/US,UC(29),C(30,30),U(29,29)                                   
      COMMON /BL4/NTEST,NA,NPGTE(2),CLATE(2,2),XTE(50,20),XNA(40,20)            
      INTEGER BL/'    '/                                                        
      INTEGER JL(2)/'1','2'/                                                    
      WRITE(NOS,1)                                                              
    1 FORMAT(//20X,59HAFFECTATION ET VALEUR DE LA FONCTION LINEAIRE DISC        
     1RIMINANTE/28X,43HPOUR LES INDIVIDUS DE L ECHANTILLON DE BASE//)           
      K=NV                                                                      
      DO 22 M=1,NRET                                                            
      L1=NVAR(K)                                                                
      YBAR(M)=(NPG(1)*XM(1,L1)+NPG(2)*XM(2,L1))/(NPG(1)+NPG(2))                 
      K=K-1                                                                     
   22 CONTINUE                                                                  
      DO 23 L2=1,NRET                                                           
      COF(L2)=0.0                                                               
      DO 23 L3=1,NRET                                                           
   23 COF(L2)=COF(L2)+DIF(L3)*U(L3,L2)                                          
      CONS=0.0                                                                  
      DO 24 L2=1,NRET                                                           
   24 CONS=CONS+COF(L2)*YBAR(L2)                                                
      CONS=-CONS                                                                
      IB=JL(1)                                                                  
      ND=0                                                                      
      DO 19 I=1,2                                                               
      WRITE(NOS,2) I                                                            
    2 FORMAT(//3X,6HGROUPE,I2,4X,11HAFFECTATION,5X,8HFONCTION//)                
      NIN=1                                                                     
      NP=ND+1                                                                   
      ND=NP+NPG(I)-1                                                            
      DO 20 J=NP,ND                                                             
      K=NV                                                                      
      FQ=0.0                                                                    
      DO 8 M=1,NRET                                                             
      L1=NVAR(K)                                                                
      FQ=FQ+COF(M)*X(J,L1)                                                      
      K=K-1                                                                     
    8 CONTINUE                                                                  
      FQ=FQ+CONS                                                                
      IA=BL                                                                     
      IF(FQ.GT.0.0) IA=JL(1)                                                    
      IF(FQ.LT.0.0) IA=JL(2)                                                    
      IF(IA.EQ.IB) GOTO 3                                                       
      WRITE(NOS,4) NIN,IA,FQ                                                    
    4 FORMAT(4X,I3,14X,A1,9X,F7.3)                                              
      GOTO 9                                                                    
    3 WRITE(NOS,5) NIN,IA,FQ                                                    
    5 FORMAT(4X,I3,13X,A1,10X,F7.3)                                             
    9 NIN=NIN+1                                                                 
   20 CONTINUE                                                                  
      IB=JL(2)                                                                  
   19 CONTINUE                                                                  
      WRITE(NOS,10)                                                             
   10 FORMAT(//20X,44HVALEUR DE LA FONCTION LINEAIRE DISCRIMINANTE/27X,2        
     19HPOUR LES MOYENNES DES GROUPES//)                                        
      DO 7 I=1,2                                                                
      K=NV                                                                      
      FQ=0.0                                                                    
      DO 6 M=1,NRET                                                             
      L1=NVAR(K)                                                                
      FQ=FQ+COF(M)*XM(I,L1)                                                     
      K=K-1                                                                     
    6 CONTINUE                                                                  
      FQ=FQ+CONS                                                                
      WRITE(NOS,100) I,FQ                                                       
  100 FORMAT( 2X,6HGROUPE,I2,3H - F7.3)                                         
    7 CONTINUE                                                                  
      IF(NTEST.EQ.0) GOTO 11                                                    
      WRITE(NOS,17)                                                             
   17 FORMAT(//60(1H*)//)                                                       
      WRITE(NOS,18)                                                             
   18 FORMAT(//20X,59HAFFECTATION ET VALEUR DE LA FONCTION LINEAIRE DISC        
     1RIMINANTE/29X,40HPOUR LES INDIVIDUS DE L ECHANTILLON TEST//)              
      IB=JL(1)                                                                  
      ND=0                                                                      
      DO 21 I=1,2                                                               
      WRITE(NOS,28) I                                                           
   28 FORMAT(//3X,6HGROUPE,I2,4X,11HAFFECTATION,5X,8HFONCTION//)                
      NIN=1                                                                     
      NP=ND+1                                                                   
      ND=NP+NPGTE(I)-1                                                          
      DO 25 J=NP,ND                                                             
      K=NV                                                                      
      FQ=0.0                                                                    
      DO 26 M=1,NRET                                                            
      L1=NVAR(K)                                                                
      FQ=FQ+COF(M)*XTE(J,L1)                                                    
      K=K-1                                                                     
   26 CONTINUE                                                                  
      FQ=FQ+CONS                                                                
      IA=BL                                                                     
      IF(FQ.GT.0.0) IA=JL(1)                                                    
      IF(FQ.LT.0.0) IA=JL(2)                                                    
      IF(IA.EQ.IB) GOTO 30                                                      
      WRITE(NOS,4) NIN,IA,FQ                                                    
      GOTO 27                                                                   
   30 WRITE(NOS,5) NIN,IA,FQ                                                    
   27 NIN=NIN+1                                                                 
   25 CONTINUE                                                                  
      IB=JL(2)                                                                  
   21 CONTINUE                                                                  
   11 IF(NA.EQ.0) GOTO 12                                                       
      WRITE(NOS,13)                                                             
   13 FORMAT(//60(1H*)//20X,59HAFFECTATION ET VALEUR DE LA FONCTION LINE        
     1AIRE DISCRIMINANTE/36X,27HPOUR LES INDIVIDUS ANONYMES///4X,6HNUMER        
     20,5X,11HAFFECTATION,5X,8HFONCTION//)                                      
      DO 14 I=1,NA                                                              
      K=NV                                                                      
      FQ=0.0                                                                    
      DO 15 M=1,NRET                                                            
      L1=NVAR(K)                                                                
      FQ=FQ+COF(M)*XNA(I,L1)                                                    
      K=K-1                                                                     
   15 CONTINUE                                                                  
      FQ=FQ+CONS                                                                
      IA=BL                                                                     
      IF(FQ.GT.0.0) IA=JL(1)                                                    
      IF(FQ.LT.0.0) IA=JL(2)                                                    
      IF(IA.EQ.IB) GOTO 16                                                      
      WRITE(NOS,4) I,IA,FQ                                                      
      GOTO 14                                                                   
   16 WRITE(NOS,5) I,IA,FQ                                                      
   14 CONTINUE                                                                  
   12 RETURN                                                                    
      END                                                                       
