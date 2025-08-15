      SUBROUTINE CLASSE                                                         
C***********************************************************************        
C     DIMENSION YBAR(LIM)                                                       
C     COMMON/BL1/ NPG(2),X(NT,NV),XM(3,NV),T(NV,NV)                             
C     COMMON/BL2/ CLA(2,2),COEF(LIM),DIF(LIM),NVAR(NV)                          
C     COMMON/BL3/ UC(LIM-1),C(LIM,LIM),U(LIM-1,LIM-1)                           
C     COMMON/BL4/ NPGTE(2),CLATE(2,2),XTE(NTTE,NV),XNA(NA,NV)                   
C***********************************************************************        
      DIMENSION YBAR(30)                                                        
      COMMON /BL1/NV,NT,NOS,LIM,NPG(2),X(500,20),XM(3,20),T(20,20)              
      COMMON /BL2/IENT,NPAS,NLIM,NV1,CONST,CLA(2,2),COEF(30),DIF(30),           
     1NVAR(20)                                                                  
      COMMON /BL3/US,UC(29),C(30,30),U(29,29)                                   
      COMMON /BL4/NTEST,NA,NPGTE(2),CLATE(2,2),XTE(50,20),XNA(40,20)            
      INTEGER CLA,CLATE                                                         
      DO 18 I=1,2                                                               
      DO 18 J=1,2                                                               
   18 CLA(I,J)=0                                                                
      K=NV                                                                      
      DO 22 M=1,NPAS                                                            
      L1=NVAR(K)                                                                
      DIF(M)=XM(1,L1)-XM(2,L1)                                                  
      YBAR(M)=(NPG(1)*XM(1,L1)+NPG(2)*XM(2,L1))/(NPG(1)+NPG(2))                 
      K=K-1                                                                     
   22 CONTINUE                                                                  
      DO 23 L2=1,NPAS                                                           
      COEF(L2)=0.0                                                              
      DO 23 L3=1,NPAS                                                           
   23 COEF(L2)=COEF(L2)+DIF(L3)*C(L3,L2)                                        
      CONST=0.0                                                                 
      DO 24 L2=1,NPAS                                                           
   24 CONST=CONST+COEF(L2)*YBAR(L2)                                             
      CONST=-CONST                                                              
      ND=0                                                                      
      DO 19 I=1,2                                                               
      NP=ND+1                                                                   
      ND=NP+NPG(I)-1                                                            
      DO 19 J=NP,ND                                                             
      K=NV                                                                      
      FQ=0.0                                                                    
      DO 26 M=1,NPAS                                                            
      L1=NVAR(K)                                                                
      FQ=FQ+COEF(M)*X(J,L1)                                                     
      K=K-1                                                                     
   26 CONTINUE                                                                  
      FQ=FQ+CONST                                                               
      IF(FQ.GT.0.0) CLA(I,1)=CLA(I,1)+1                                         
      IF(FQ.LT.0.0) CLA(I,2)=CLA(I,2)+1                                         
   19 CONTINUE                                                                  
      IF(NTEST.EQ.0) GOTO 3                                                     
      DO 4 I=1,2                                                                
      DO 4 J=1,2                                                                
    4 CLATE(I,J)=0                                                              
      ND=0                                                                      
      DO 1 I=1,2                                                                
      NP=ND+1                                                                   
      ND=NP+NPGTE(I)-1                                                          
      DO 1 J=NP,ND                                                              
      K=NV                                                                      
      FQ=0.0                                                                    
      DO 2 M=1,NPAS                                                             
      L1=NVAR(K)                                                                
      FQ=FQ+COEF(M)*XTE(J,L1)                                                   
      K=K-1                                                                     
    2 CONTINUE                                                                  
      FQ=FQ+CONST                                                               
      IF(FQ.GT.0.0) CLATE(I,1)=CLATE(I,1)+1                                     
      IF(FQ.LT.0.0) CLATE(I,2)=CLATE(I,2)+1                                     
    1 CONTINUE                                                                  
    3 RETURN                                                                    
      END                                                                       
