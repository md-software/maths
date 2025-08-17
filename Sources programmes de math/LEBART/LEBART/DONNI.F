C  **********************************************
C  *                                            *
C  *   DONNI : LECTURE D'UNE LIGNE DE DONNEES   *
C  *                                            *
C  **********************************************
      SUBROUTINE DONNI(NQDIM,NQTOT,D,FMT)                                           
      DIMENSION D(NQDIM),FMT(20)
      IUNIT=8                                                                   
      READ(IUNIT,FMT) (D(L),L=1,NQTOT)
      RETURN                                                                    
      END                                                                       
