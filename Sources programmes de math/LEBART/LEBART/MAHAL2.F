C     PROGRAMME  MAHAL 2                                                        
C     ANALYSE DISCRIMINANTE PAS A PAS ENTRE 2 GROUPES                           
C     VERSION IBM 370 DU 18/07/82.                                              
C     ORIGINE : METHODES ET PROGRAMMES D'ANALYESE DISCRIMINANTE                 
C     J-M ROMEDER.                                                              
C***********************************************************************        
C                                                                               
C     CI DESSOUS SONT INDIQUEES LES DIMENSIONS FORMELLES DES TABLEAUX           
C     UTILISES                                                                  
C                                                                               
C     DIMENSION NOM1(20),NOM2(20)                                               
C     COMMON/BL1/ NPG(2),X(NT,NV),XM(3,NV),T(NV,NV)                             
C     COMMON/BL4/ NPGTE(2),CLATE(2,2),XTE(NTTE,NV),XNA(NA,NV)                   
C                                                                               
C     NV = NOMBRE DE VARIABLES                                                  
C     NT = NOMBRE TOTAL D INDIVIDUS  (ECHANTILLON DE BASE)                      
C     LIM = NOMBRE MAXIMUM DE PAS DEMANDE                                       
C     NTTE = NOMBRE TOTAL D INDIVIDUS  (ECHANTILLON TEST)                       
C     NA = NOMBRE D INDIVIDUS ANONYMES                                          
C                                                                               
C     ATTENTION DANS LES COMMONS DU PROGRAMME IL Y A DES VARIABLES NON          
C     DIMENSIONNES QUE NOUS N AVONS PAS INDIQUEES CI DESSUS                     
C                                                                               
C***********************************************************************        
      SUBROUTINE MAHAL2 (TABD,FIND1,FIND2)                                       
      CHARACTER*1 FV(60),NOM1(20),NOM2(20)                                        
      DIMENSION TABD(20,500)                                                    
      COMMON /BL1/NV,NT,NOS,LIM,NPG(2),X(500,20),XM(3,20),T(20,20)              
      COMMON /BL4/NTEST,NA,NPGTE(2),CLATE(2,2),XTE(50,20),XNA(40,20)            
      character*4 ipr1,ipr2
      DATA NOM2   /'TYPE','2 AV','EC C','OMPL','ICAT','IONS',14*'    '/         
      DATA IPR1 /'DIAB'/                                                        
      DATA IPR2 /'ETE '/                                                        
      NOE=5                                                                     
      NOS=6                                                                     
      NV=10                                                                     
      LIM=5                                                                     
      NTEST=0                                                                   
      NA=0                                                                      
      NPG(1)=IFIX(FIND2)                                                        
      NPG(2)=IFIX(FIND1-FIND2)                                                  
      NT=0                                                                      
      DO 7 I=1,2                                                                
    7 NT=NT+NPG(I)                                                              
      DO 1 I=1,20                                                               
      DO 2 J=1,500                                                              
      X(J,I)=TABD(I,J)                                                          
   2  CONTINUE                                                                  
   1  CONTINUE                                                                  
      IF(NTEST.EQ.0) GOTO 18                                                    
      READ(NOE,4)(NPGTE(I),I=1,2)                                               
    4 FORMAT( 2I5)                                                              
      NTTE=NPGTE(1)+NPGTE(2)                                                    
      DO 19 I=1,NTTE                                                            
   19 READ(NOE,FV) (XTE(I,J),J=1,NV)                                            
   18 IF(NA.EQ.0) GOTO 14                                                       
      DO 15 I=1,NA                                                              
   15 READ(NOE,FV) (XNA(I,J),J=1,NV)                                            
   14 WRITE(NOS,9) IPR1,IPR2,NV                                                 
    9 FORMAT(20H1-PROGRAMME MAHAL 2-/                                           
     148H0ANALYSE DISCRIMINANTE PAS A PAS ENTRE 2 GROUPES//                     
     221H0NOM DU PROBLEME     2A4/                                              
     322H0NOMBRE DE VARIABLES  I5)                                              
      WRITE (NOS,13) (NOM1(J),J=1,20)                                           
      WRITE (NOS,24) (NOM2(J),J=1,20)                                           
   13 FORMAT (9H0GROUPE 1,3H : ,20A4)                                           
   24 FORMAT (9H0GROUPE 2,3H : ,20A4)                                           
      WRITE(NOS,20)                                                             
   20 FORMAT(20H0ECHANTILLON DE BASE)                                           
      DO 10 I=1,2                                                               
   10 WRITE(NOS,5) I,NPG(I)                                                     
    5 FORMAT(1H0,10X,28HNOMBRE D INDIVIDUS DU GROUPE I3,3H : ,I3)               
      IF(NTEST.EQ.0) GOTO 23                                                    
      WRITE(NOS,22)                                                             
   22 FORMAT(17H0ECHANTILLON TEST)                                              
      DO 21 I=1,2                                                               
   21 WRITE(NOS,5) I,NPGTE(I)                                                   
   23 IF(NA.EQ.0) GOTO 16                                                       
      WRITE(NOS,17) NA                                                          
   17 FORMAT(31H0NOMBRE D INDIVIDUS ANONYMES : I3)                              
   16 CALL MOYEN                                                                
      CALL ECTYP(NSTOP)                                                         
      IF(NSTOP.EQ.1) GOTO 64                                                    
      CALL COVTOT                                                               
      CALL PASPAS                                                               
   64 WRITE(NOS,3)                                                              
    3 FORMAT(//46H0CARTE-PROBLEME FINI-RENCONTRE,TRAVAIL TERMINE)               
   65 RETURN                                                                    
      END                                                                       
