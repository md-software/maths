      SUBROUTINE RECHER                                                         
C***********************************************************************        
C     DIMENSION CAL(LIM)                                                        
C     COMMON/BL1/ NPG(2),X(NT,NV),XM(3,NV),T(NV,NV)                             
C     COMMON/BL2/ CLA(2,2),COEF(LIM),DIF(LIM),NVAR(NV)                          
C     COMMON/BL3 /UC(LIM-1),C(LIM,LIM),U(LIM-1,LIM-1)                           
C***********************************************************************        
      DIMENSION CAL(30)                                                         
      COMMON /BL1/NV,NT,NOS,LIM,NPG(2),X(500,20),XM(3,20),T(20,20)              
      COMMON /BL2/IENT,NPAS,NLIM,NV1,CONST,CLA(2,2),COEF(30),DIF(30),           
     1NVAR(20)                                                                  
      COMMON /BL3/US,UC(29),C(30,30),U(29,29)                                   
      DMAX=0.0                                                                  
      DO 55 M1=1,NLIM                                                           
      M=NVAR(M1)                                                                
      IF(NPAS.EQ.1) GOTO 42                                                     
      J=NV                                                                      
      LS=NPAS-1                                                                 
      DO 54 I=1,LS                                                              
      K=NVAR(J)                                                                 
      UC(I)=T(K,M)                                                              
      J=J-1                                                                     
   54 CONTINUE                                                                  
      US=T(M,M)                                                                 
      CALL INVESC(LS)                                                           
      GOTO 43                                                                   
   42 U(1,1)=T(M,M)                                                             
      C(1,1)=1./U(1,1)                                                          
   43 DIF(NPAS)=XM(1,M)-XM(2,M)                                                 
      DO 57 J=1,NPAS                                                            
      CAL(J)=0.0                                                                
      DO 57 K=1,NPAS                                                            
   57 CAL(J)=CAL(J)+DIF(K)*C(K,J)                                               
      DQ2=0.0                                                                   
      DO 60 J=1,NPAS                                                            
   60 DQ2=DQ2+CAL(J)*DIF(J)                                                     
      IF(DQ2.LT.DMAX) GOTO 55                                                   
      DMAX=DQ2                                                                  
      IENT=M                                                                    
   55 CONTINUE                                                                  
      RETURN                                                                    
      END                                                                       
