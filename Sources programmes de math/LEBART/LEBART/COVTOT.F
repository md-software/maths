      SUBROUTINE COVTOT                                                         
C***********************************************************************        
C     COMMON/BL1/ NPG(2),X(NT,NV),XM(3,NV),T(MV,NV)                             
C***********************************************************************        
      COMMON /BL1/NV,NT,NOS,LIM,NPG(2),X(500,20),XM(3,20),T(20,20)              
      DO 14 I=1,NV                                                              
      DO 14 J=1,NV                                                              
      T(I,J)=0.0                                                                
      DO 14 K=1,NT                                                              
      T(I,J)=T(I,J)+(X(K,I)-XM(3,I))*(X(K,J)-XM(3,J))                           
   14 CONTINUE                                                                  
      DO 15 I=1,NV                                                              
      DO 15 J=1,NV                                                              
   15 T(I,J)=T(I,J)/NT                                                          
      RETURN                                                                    
      END                                                                       
