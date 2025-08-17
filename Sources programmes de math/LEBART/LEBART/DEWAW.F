C  *******************************
C  *                             *
C  *  DEWAW : UTILISE PAR AVAR2  *
C  *                             *
C  *******************************  
      SUBROUTINE DEWAW(NDIM,NTOT,W,KX,KMOD)                                     
      DIMENSION W(NDIM,NDIM)                                                    
      DO 10 J=1,NTOT                                                            
      DO 10 L=J,NTOT                                                            
      IF (J.EQ.KX.OR.L.EQ.KX) GOTO 10                                           
      W(J,L)=W(J,L)-W(J,KX)*W(KX,L)/W(KX,KX)                                    
      W(L,J)=W(J,L)                                                             
10    CONTINUE                                                                  
      DO 20 J=1,NTOT                                                            
      IF (J.EQ.KX) GOTO 20                                                      
      W(J,KX)=KMOD*W(J,KX)/W(KX,KX)                                             
      W(KX,J)=W(J,KX)                                                           
20    CONTINUE                                                                  
      W(KX,KX)=-1./W(KX,KX)                                                     
      RETURN                                                                    
      END                                                                       
