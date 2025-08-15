      INTEGER COMPT,COMPT1,GROUPE,ECHAN,DICHOE,DECOU,DECGRO                     
      INTEGER ARRET,OR,ORIGIN,PRT                                               
      INTEGER CL(10),VECTRA(100)                                                
      LOGICAL TEST(100)                                                         
      COMMON /POP/ECHAN(1500,10),NFACT                                          
      COMMON /DICHO/N1,MEILD1,IETOIL,PHI2,DICHOE(10)                            
      COMMON /ARRETD/ARRET(100),ORIGIN(100,10),OR(100),IS(100)                  
      COMMON /DECOUP/DECGRO(100),NM(10,100),NMAX(10,100)                         
      COMMON /DECDEC/DECOU(100)                                                 
      COMMON /LILI/LIAIS(10,15)                                                 
      COMMON /CARAC/NCAR(10)                                                     
      COMMON /ENSOR/LEC,PRT                                                     
      DATA NPOP,COMPT/0,2/                                                      
      DATA CMG/0./CL/10*0/                                                      
      DATA TEST/100*.FALSE./                                                    
      LEC=5
      PRT=6
      READ(LEC,100) IUNIT,MINPOP,NFACT,IOP                                      
      READ(LEC,101) (NCAR(I),I=1,NFACT)                                         
      MAX=NCAR(1)                                                               
      DO 1 I=2,NFACT                                                            
      IF(NCAR(I).GT.MAX) MAX=NCAR(I)                                            
1     CONTINUE                                                                  
98    NPOP=NPOP+1                                                               
      READ(IUNIT,101,END=99) (ECHAN(NPOP,I),I=1,NFACT)                          
      GOTO 98                                                                   
99    MAXIY=NCAR(NFACT)                                                         
      NPOP=NPOP-1                                                               
      CALL INIT (MINPOP,NPOP,IOP)                                               
      DO 9 I=1,NPOP                                                             
9     CMG=CMG+ECHAN(I,NFACT)                                                    
      CMG=CMG/NPOP                                                              
      CALL ENTETE(NPOP,1,1,CMG)                                                 
      VECTRA(1)=0                                                               
      DECOU(1)=0                                                                
      DECOU(2)=NPOP                                                             
      NM(1,1)=1                                                                 
      NMAX(1,1)=NPOP                                                            
      DECGRO(1)=1                                                               
      NF=NFACT-1                                                                
      NIVEAU=2                                                                  
50    COMPT1=COMPT-1                                                            
      GROUPE=0                                                                  
      ICOMPT=1                                                                  
      IZ=2**(NIVEAU-2)-1                                                        
      DO 10 I=1,COMPT1                                                          
      IG=IZ+I                                                                   
      GROUPE=GROUPE+1                                                           
      IF(TEST(I+1)) GOTO 5                                                      
      CALL DICHOP(MINPOP,ARRET(I+1),MAXIY,CL,I,KODE)                            
      IF (KODE.EQ.1) GOTO 15                                                    
      ICOMPT=ICOMPT+2                                                           
      VECTRA(ICOMPT-1)=N1                                                       
      VECTRA(ICOMPT)=DECOU(I+1)                                                 
      NM(NIVEAU,GROUPE)=DECOU(I)+1                                              
      NMAX(NIVEAU,GROUPE)=N1                                                    
      NM(NIVEAU,GROUPE+1)=N1+1                                                  
      NMAX(NIVEAU,GROUPE+1)=DECOU(I+1)                                          
      DECGRO(NIVEAU)=GROUPE+1                                                   
      IF(NIVEAU.GT.5) GOTO 25                                                   
      DO 52 JK=1,NF                                                             
52    LIAIS(JK,IG)=CL(JK)                                                       
25    CONTINUE                                                                  
      CALL IMP(NIVEAU,GROUPE,I)                                                 
      GOTO 10                                                                   
15    TEST(I+1)=.TRUE.                                                          
      DO 40 J=1,MEILD1                                                          
      ORIGIN (I+1,J)=DICHOE (J)                                                 
40    CONTINUE                                                                  
      OR(I+1)=MEILD1                                                            
      IS (I+1)=IETOIL                                                           
5     II=I+1                                                                    
      ICOMPT=ICOMPT+1                                                           
      VECTRA(ICOMPT)=DECOU(II)                                                  
      CALL IMPARR (NIVEAU,GROUPE,II)                                            
10    CONTINUE                                                                  
      IF(ICOMPT.EQ.COMPT) GOTO 30                                               
      COMPT=ICOMPT                                                              
      WRITE(PRT,3000)                                                           
      WRITE(PRT,1000)                                                           
      WRITE(PRT,3000)                                                           
      NIVEAU=NIVEAU+1                                                           
      DO 20 I=1,COMPT                                                           
20    DECOU(I)=VECTRA(I)                                                        
      GOTO 50                                                                   
30    WRITE(PRT,3000)                                                           
      WRITE(PRT,1000)                                                           
      CALL DECPOP(NPOP,COMPT)                                                   
      IF (IOP.NE.2.AND.IOP.NE.3) GOTO 70                                        
      CALL IMPPOP(COMPT)                                                        
70    CONTINUE                                                                  
      CALL REPART(NIVEAU,MAX)                                                   
      CALL IMPLIA (NF)                                                          
      STOP                                                                      
100   FORMAT(40I2)                                                              
101   FORMAT(10I1)                                                              
1000  FORMAT(1H ,3X,127(1H*))                                                   
3000  FORMAT(1H ,3X,2('*',8X),'*',19X,'*',12X,'*',44X,'*',2(14X,'*'))           
      END                                                                       

      SUBROUTINE INIT(MP,N,IOP)                                                 
      INTEGER EC                                                                
      CHARACTER*1 STAR(132),BLANC(132),ENTIER(9)                                  
      CHARACTER*1 BL,YGREC
      COMMON /POP/EC(1500,10),NF                                                
      COMMON/CARAC/NCAR(10)                                                     
      COMMON /ENSOR/LEC,IMP                                                     
      DATA STAR/132*'*'/YGREC/'Y'/ENTIER/'1','2','3','4','5','6','7','8'        
     *,'9'/                                                                     
      DATA BLANC/132*' '/                                                       
      DATA BL/' '/                                                              
      WRITE(IMP,100)                                                            
      NNF=NF-1                                                                  
      WRITE(IMP,200) NNF                                                        
      WRITE(IMP,300)                                                            
      NSTAR=13*NNF+1                                                            
      WRITE(IMP,400) (STAR(I),I=1,NSTAR)                                        
      NA=NNF-1                                                                  
      WRITE(IMP,500) (ENTIER(I),I=1,NA)                                         
      BLANC(NNF)=ENTIER(NNF)                                                    
      WRITE(IMP,901) (BLANC(I),I=1,NNF)                                         
      WRITE(IMP,400) (STAR(I),I=1,NSTAR)                                        
      WRITE(IMP,600) (NCAR(I),I=1,NNF)                                          
      WRITE(IMP,400) (STAR(I),I=1,NSTAR)                                        
      IF (IOP.NE.1.AND.IOP.NE.3) GOTO 10                                        
      WRITE(IMP,700)                                                            
      NSTAR=NSTAR+13                                                            
      WRITE(IMP,400) (STAR(I),I=1,NSTAR)                                        
      WRITE(IMP,500) (ENTIER(I),I=1,NNF)                                        
      BLANC(NF)=YGREC                                                           
      WRITE(IMP,901) (BLANC(I),I=1,NF)                                          
      WRITE(IMP,400) (STAR(I),I=1,NSTAR)                                        
      BLANC(NNF)=BL                                                             
      BLANC(NF)=BL                                                              
      DO 1 I=1,N                                                                
      WRITE(IMP,900) (BLANC(J),J=1,NF)                                          
      WRITE(IMP,600) (EC(I,J),J=1,NF)                                           
1     CONTINUE                                                                  
      WRITE(IMP,900) (BLANC(I),I=1,NF)                                          
      WRITE(IMP,400) (STAR(I),I=1,NSTAR)                                        
10    CONTINUE                                                                  
      WRITE(IMP,750) N                                                          
      WRITE(IMP,800) MP                                                         
      WRITE(IMP,1000)                                                           
      WRITE(IMP,4000)                                                           
      WRITE(IMP,5000)                                                           
      RETURN                                                                    
100   FORMAT(1H1,50X,33(1H*)/1H ,50X,'I',31X,'I'/1H ,50X,'I SEGMENTATION        
     * D''UNE POPULATION I'/1H ,50X,'I',31X,'I'/1H ,50X,33(1H*)////)            
200   FORMAT(1H0,'NOMBRE DE FACTEURS= ',I2//)                                   
300   FORMAT(1H0,50X,'CARACTERISTIQUES DES FACTEURS'/1H ,50X,29(1H-)//)         
400   FORMAT(1H ,132A1)                                                         
500   FORMAT(1H ,'I',10(' FACTEUR  ',A1,' I'))                                  
600   FORMAT(1H ,'I',10(5X,I2,5X,'I'))                                          
700   FORMAT(////1H ,56X,'POPULATION DE DEPART'/1H ,56X,20(1H-)//)              
750   FORMAT(1H0/1H ,'POPULATION TOTALE=',I4)                                   
800   FORMAT(1H0,'POPULATION MINIMALE= ',I2)                                    
900   FORMAT(1H ,'I',10(10X,A1,' I'))                                           
901   FORMAT(1H+,1X,10(10X,A1,' I'))                                            
1000  FORMAT(1H0,'FACTEUR Y=CRITERE A ETUDIER')                                 
4000  FORMAT(1H0/1H0,50X,'CRITERES D''ARRET'/1H ,50X,16(1H-)/1H0/1H ,'AR        
     *RET NUMERO 1 ---> POPULATION INFERIEURE A LA POPULATION MINIMALE'/        
     *1H ,'ARRET NUMERO 2 ---> PHI2 NUL')                                       
5000  FORMAT(1H ,'ARRET NUMERO 3 ---> MAXPHI ATTEINT PLUSIEURS FOIS')           
      END                                                                       

      SUBROUTINE ENTETE(NPOP,NIV,GRO,C)                                         
      INTEGER GRO                                                               
      COMMON /ENSOR/LEC,IMP                                                     
      WRITE(IMP,1000)                                                           
      WRITE(IMP,1)                                                              
      WRITE(IMP,2)                                                              
      WRITE(IMP,3)                                                              
      WRITE(IMP,2)                                                              
      WRITE(IMP,1)                                                              
      WRITE(IMP,2)                                                              
      WRITE(IMP,10) NIV,GRO,NPOP,C                                              
      WRITE(IMP,2)                                                              
      WRITE(IMP,1)                                                              
      WRITE(IMP,2)                                                              
      RETURN                                                                    
1     FORMAT(1H ,3X,127(1H*))                                                   
2     FORMAT(1H ,3X,2('*',8X),'*',19X,'*',12X,'*',44X,'*',2(14X,'*'))           
3     FORMAT(1H ,3X,'* NIVEAU * GROUPE *',5X,'POPULATION',4X,'*',3X,'FAC        
     *TEUR',2X,'*',17X,'DICHOTOMIE',17X,'*',5X,'PHI2',5X,'*',3X,'CRIT MO        
     *Y',3X,'*')                                                                
10    FORMAT(1H ,3X,2('*   ',I2,3X),'*',7X,I4,8X,'*',12X,'*',44X,'*',14X        
     *,'*',2X,F10.6,2X,'*')                                                     
1000  FORMAT(1H1)                                                               
      END                                                                       

      SUBROUTINE DICHOP (MINPOP,ARRET,MAXIY,CL,IJK,KODE)                        
      LOGICAL STOP                                                              
      REAL MAXPHI                                                               
      INTEGER ECHAN,ARRET,DICHOE,DECOU,RANG(10),BIT(10),S(10),CL(10)            
      DIMENSION PH(10),MEILD(10),M(10)                                          
      COMMON /POP/ECHAN(1500,10),NFACT                                          
      COMMON /TRAV/MATTRA(1500,10),NI1,NIP                                      
      COMMON /DICHO/NU,MEILN1,IETOIL,PHI2,DICHOE(10)                            
      COMMON /DECDEC/DECOU(100)                                                 
      COMMON/CARAC/NCAR(10)                                                     
      KODE=0                                                                    
      NI=DECOU(IJK)                                                             
      NIP=DECOU(IJK+1)                                                          
      STOP=.FALSE.                                                              
      PHI2=0.                                                                   
      NI1=NI+1                                                                  
      DO 1 I=1,MAXIY                                                            
1     M(I)=0                                                                    
      DO 2 I=NI1,NIP                                                            
      IVY=ECHAN(I,NFACT)                                                        
2     M(IVY)=M(IVY)+1                                                           
      NF=NFACT-1                                                                
      DO 10 I=1,NF                                                              
      NNCAR=NCAR(I)-1                                                           
      NDICHO=2**NNCAR-1                                                         
      MAXPHI=0                                                                  
      DO 15 J=1,NNCAR                                                           
15    BIT(J)=0                                                                  
      DO 11 NN=1,NDICHO                                                         
      DO 12 IY=1,MAXIY                                                          
12    S(IY)=0                                                                   
      N=0                                                                       
      NOMBRE=0                                                                  
      L=0                                                                       
3     L=L+1                                                                     
      BIT(L)=BIT(L)+1                                                           
      IF(BIT(L).EQ.1) GOTO 4                                                    
      BIT(L)=0                                                                  
      GOTO 3                                                                    
4     CONTINUE                                                                  
      DO 13 L=1,NNCAR                                                           
      IF(BIT(L).NE.1) GOTO 13                                                   
      NOMBRE=NOMBRE+1                                                           
      RANG(NOMBRE)=L                                                            
13    CONTINUE                                                                  
      DO 20 K=1,NOMBRE                                                          
      DO 21 J=NI1,NIP                                                           
      IF (ECHAN(J,I).NE.RANG(K)) GOTO 21                                        
      IY=ECHAN(J,NFACT)                                                         
      S(IY)=S(IY)+1                                                             
      N=N+1                                                                     
21    CONTINUE                                                                  
20    CONTINUE                                                                  
      NP=NIP-NI                                                                 
      IF(N.EQ.0.OR.NP.EQ.N) GOTO 11                                             
      PHID=0.                                                                   
      DO 30 J=1,MAXIY                                                           
      IF(M(J).EQ.0) GOTO 30                                                     
      PHID=PHID+(NP*S(J)-N*M(J))**2/FLOAT(M(J))                                 
30    CONTINUE                                                                  
      PHID=PHID/(NP*N*(NP-N))                                                   
      IF (PHID.LT.MAXPHI) GOTO 11                                               
      MAXPHI=PHID                                                               
      NN1=N                                                                     
      DO 16 L=1,NOMBRE                                                          
16    MEILD(L)=RANG(L)                                                          
      MEIL1=NOMBRE                                                              
11    CONTINUE                                                                  
      PH(I)=MAXPHI                                                              
      IF(MAXPHI.LT.PHI2) GOTO 10                                                
      IETOIL=I                                                                  
      NU=NN1                                                                    
      MEILN1=MEIL1                                                              
      DO 17 L=1,MEILN1                                                          
17    DICHOE(L)=MEILD(L)                                                        
      PHI2=MAXPHI                                                               
10    CONTINUE                                                                  
      IF(PHI2.NE.0.) GOTO 98                                                    
      ARRET=2                                                                   
      GOTO 99                                                                   
98    IF(NU.GE.MINPOP.AND.(NP-NU).GE.MINPOP) GOTO 97                            
      ARRET=1                                                                   
      GOTO 99                                                                   
97    CALL TESTPH (PH,STOP,NF,ARRET)                                            
      IF(STOP) GOTO 99                                                          
      DO 18 I=NI1,NIP                                                           
      DO 19 J=1,NFACT                                                           
19    MATTRA(I,J)=ECHAN(I,J)                                                    
18    CONTINUE                                                                  
      CALL ORD (MEILN1,DICHOE,IETOIL)                                           
      CALL TRI(PH,CL,NF)                                                        
      NU=NU+NI                                                                  
      RETURN                                                                    
99    CONTINUE                                                                  
      NU=NIP                                                                    
      KODE=1                                                                    
      RETURN                                                                    
      END                                                                       

      SUBROUTINE IMPARR (N,G,II)                                                
      INTEGER G,A                                                               
      INTEGER ARRET,OR,ORIGIN                                                   
      COMMON /ARRETD/ARRET(100),ORIGIN(100,10),OR(100),IS(100)                  
      COMMON /ENSOR/LEC,IMP                                                     
      A=ARRET(II)                                                               
      M=OR(II)                                                                  
      IE=IS(II)                                                                 
      WRITE(IMP,1) N,G,IE,A,(ORIGIN(II,I),I=1,M)                                
      WRITE(IMP,2)                                                              
      G=G+1                                                                     
      WRITE(IMP,1) N,G,IE,A,(ORIGIN(II,I),I=1,M)                                
      WRITE(IMP,2)                                                              
      RETURN                                                                    
1     FORMAT(1H ,3X,2('*   ',I2,3X),'*',19X,'*',5X,I2,5X,'*',2X,'ARRET '        
     *,I1,' D''ORIGINE ',10(I1,'-'))                                            
2     FORMAT(1H+,99X,'*',2(14X,'*'))                                            
      END                                                                       

      SUBROUTINE IMPLIA(NF)                                                     
      COMMON /LILI/LIAIS(10,15)                                                 
      COMMON /ENSOR/LEC,IMP                                                     
      WRITE(IMP,100)                                                            
      WRITE(IMP,200) (N,N=1,4)                                                  
      WRITE(IMP,300) (N,N=1,2),(N,N=1,4),(N,N=1,8)                              
      DO 1 I=1,NF                                                               
      WRITE(IMP,4000) I,(LIAIS(I,J),J=1,15)                                     
      IF(I.EQ.NF) GOTO 1                                                        
      WRITE(IMP,400)                                                            
1     CONTINUE                                                                  
      WRITE(IMP,500)                                                            
      RETURN                                                                    
100   FORMAT(1H1,25X,'ORDRE DES LIAISONS DES FACTEURS AVEC LE CRITERE Y         
     *AU NIVEAU DES DIFFERENTS GROUPES'/1H ,25X,82(1H=)/1H ,52X,'(POUR L        
     *ES 4 PREMIERS NIVEAUX)')                                                  
200   FORMAT(////1H ,132(1H*)/1H ,3X,'NIVEAU',2X,'I',3X,I2,3X,'I',6X,I2,        
     *7X,'I',14X,I2,15X,'I',30X,I2/1H ,132(1H*))                                
300   FORMAT(1H ,3X,'GROUPE',2X,'I',4X,'1',3X,'I',3X,I1,7X,I1,3X,'I',3X,        
     *I1,3(7X,I1),3X,'I',3X,I1,7(7X,I1)/1H ,132(1H*))                           
400   FORMAT(1H ,11(1H*),'I',8(1H*),'I',15(1H*),'I',31(1H*),'I',63(1H*))        
500   FORMAT(1H ,132(1H*))                                                      
4000  FORMAT(1H ,'FACTEUR ',I2,' I',3X,I2,3X,'I',2X,I2,6X,I2,3X,'I',2X,I        
     *2,3(6X,I2),3X,'I',2X,I2,7(6X,I2))                                         
      END                                                                       

      SUBROUTINE DECPOP(N,C)                                                    
      INTEGER C,C0,DECOU                                                        
      COMMON /DECDEC/DECOU(100)                                                 
      COMMON /ENSOR/LEC,IMP                                                     
      WRITE(IMP,100)                                                            
      WRITE(IMP,1000)                                                           
      WRITE(IMP,1001)                                                           
      WRITE(IMP,2000)                                                           
      WRITE(IMP,1001)                                                           
      WRITE(IMP,1000)                                                           
      C0=C-1                                                                    
      DO 1 K=1,C0                                                               
      N0=DECOU(K+1)-DECOU(K)                                                    
      POURC=FLOAT(N0)/FLOAT(N)                                                  
      WRITE(IMP,1001)                                                           
      WRITE(IMP,3000) K,N0,POURC                                                
1     CONTINUE                                                                  
      WRITE(IMP,1001)                                                           
      WRITE(IMP,1000)                                                           
      WRITE(IMP,4000) N                                                         
      RETURN                                                                    
100   FORMAT(1H1,37X,'REPARTITION DE LA POPULATION DANS LES DIFFERENTS G        
     *ROUPES'/1H ,37X,56(1H=)///)                                               
1000  FORMAT(1H ,48X,35(1H*))                                                   
1001  FORMAT(1H ,48X,'I',8X,'I',10X,'I',13X,'I')                                
2000  FORMAT(1H ,48X,'I GROUPE I EFFECTIF I POURCENTAGE I')                     
3000  FORMAT(1H ,48X,'I',3X,I2,3X,'I',3X,I4,3X,'I',2X,F10.6,' I')               
4000  FORMAT(1H0/1H ,'POPULATION TOTALE=',I4)                                   
      END                                                                       

      SUBROUTINE TESTPH (PH,STOP,NF,ARRET)                                      
      LOGICAL STOP                                                              
      INTEGER ARRET                                                             
      REAL MPH                                                                  
      DIMENSION PH(10)                                                          
      MPH=PH(1)                                                                 
      K=1                                                                       
      DO 1 I=2,NF                                                               
      IF(PH(I).LE.MPH) GOTO 1                                                   
      MPH=PH(I)                                                                 
      K=I                                                                       
1     CONTINUE                                                                  
      DO 2 I=1,NF                                                               
      IF(I.EQ.K.OR.PH(I).NE.MPH) GOTO 2                                         
      STOP=.TRUE.                                                               
      ARRET=3                                                                   
      RETURN                                                                    
2     CONTINUE                                                                  
      RETURN                                                                    
      END                                                                       

      SUBROUTINE TRI(A,M,N)                                                     
      DIMENSION A(10),M(10)                                                     
      DO 2 J=1,N                                                                
2     M(J)=0                                                                    
      J=0                                                                       
      DO 5 K=1,N                                                                
      IF (A(K).NE.0.) GOTO 5                                                    
      M(K)=999                                                                  
      A(K)=-1.                                                                  
      J=J+1                                                                     
5     CONTINUE                                                                  
      IF(J.EQ.N) RETURN                                                         
      NN=N-J                                                                    
      K=0                                                                       
10    K=K+1                                                                     
      RMAX=A(1)                                                                 
      MSUP=1                                                                    
      DO 1 I=2,N                                                                
      IF(A(I).LE.RMAX) GOTO 1                                                   
      RMAX=A(I)                                                                 
      MSUP=I                                                                    
1     CONTINUE                                                                  
      M(MSUP)=K                                                                 
      A(MSUP)=-1.                                                               
      IF(K.LT.NN) GOTO 10                                                       
      RETURN                                                                    
      END                                                                       

      SUBROUTINE ORD(L,RANG,IETOIL)                                             
      LOGICAL Z                                                                 
      INTEGER ECHAN                                                             
      INTEGER RANG(10)                                                          
      COMMON /POP/ECHAN(1500,10),K                                              
      COMMON /TRAV/MATTRA(1500,10),NI1,NIP                                      
      J0=NI1                                                                    
      J1=NIP                                                                    
      DO 30 I=NI1,NIP                                                           
          Z=.FALSE.                                                             
          DO40J=1,L                                                             
40    Z=Z.OR.(MATTRA(I,IETOIL).EQ.RANG(J))                                      
      IF(.NOT.Z)GOTO50                                                          
          DO 60 J=1,K                                                           
60    ECHAN(J0,J)=MATTRA(I,J)                                                   
          J0=J0+1                                                               
          GOTO30                                                                
50        DO 70 J=1,K                                                           
70    ECHAN(J1,J)=MATTRA(I,J)                                                   
          J1=J1-1                                                               
30        CONTINUE                                                              
      RETURN                                                                    
      END                                                                       

      SUBROUTINE IMP(N,G,JIK)                                                   
      INTEGER A,D,DECOU,G,PRT
      INTEGER STOCK(10)      
      COMMON /POP/A(1500,10),NF
      COMMON/DICHO/N1,M,IF,P,D(10)                                              
      COMMON /DECDEC/DECOU(100)                                                 
      COMMON/CARAC/NCAR(10)                                                     
      COMMON /ENSOR/LEC,PRT                                                  
      N0=DECOU(JIK)                                                             
      N2=DECOU(JIK+1)                                                           
      M1=N1-N0                                                                  
      M2=N2-N1                                                                  
      CMG1=0.                                                                   
      N01=N0+1                                                                  
      DO 1 I=N01,N1                                                             
1     CMG1=CMG1+A(I,NF)                                                         
      CMG1=CMG1/M1                                                              
      CMG2=0.                                                                   
      N10=N1+1                                                                  
      DO 2 I=N10,N2                                                             
2     CMG2=CMG2+A(I,NF)                                                         
      CMG2=CMG2/M2                                                              
      WRITE(PRT,1000) N,G,M1,IF,P,CMG1                                          
      WRITE(PRT,2000) (D(J),J=1,M)                                              
      G=G+1                                                                     
      WRITE(PRT,1000) N,G,M2,IF,P,CMG2                                          
      L=0                                                                       
      NN=NCAR(IF)                                                               
      DO 10 J=1,NN                                                              
      I=0                                                                       
      DO 11 JJ=1,M                                                              
      IF(D(JJ).EQ.J) GOTO 10                                                    
      I=I+1                                                                     
11    CONTINUE                                                                  
      IF(I.NE.M) GOTO 10                                                        
      L=L+1                                                                     
      STOCK(L)=J                                                                
10    CONTINUE                                                                  
      WRITE(PRT,2000) (STOCK(J),J=1,L)                                          
      RETURN                                                                    
1000  FORMAT(1H ,3X,2('*   ',I2,3X),'*',7X,I4,8X,'*',5X,I2,5X,'*',44X,'*        
     *',2(2X,F10.6,2X,'*'))                                                     
2000  FORMAT(1H+,57X,10(I1,' - '))                                              
      END                                                                       

      SUBROUTINE REPART(NIV,MAX)                                                
      INTEGER A,D                                                               
      INTEGER S(10)                                                             
      COMMON /POP/A(1500,10),NF                                                 
      COMMON/DECOUP/D(100),NM(10,100),NMAX(10,100)                              
      COMMON/CARAC/NCAR(10)                                                     
      COMMON /ENSOR/LEC,IMP                                                     
      WRITE(IMP,100)                                                            
      NIV=NIV-1                                                                 
      DO 1 I=1,NIV                                                              
      WRITE(IMP,1000) I                                                         
      MAXG=D(I)                                                                 
      DO 2 J=1,MAXG                                                             
      IF(NM(I,J).EQ.0) GOTO 2                                                   
      WRITE(IMP,2000) J                                                         
      WRITE(IMP,4001)                                                           
      WRITE(IMP,2001) (K,K=1,MAX)                                               
      WRITE(IMP,4000)                                                           
      NU1=NM(I,J)                                                               
      NU2=NMAX(I,J)                                                             
      DO 3 K=1,NF                                                               
      DO 10 II=1,MAX                                                            
10    S(II)=0                                                                   
      DO 4 L=NU1,NU2                                                            
      IND=A(L,K)                                                                
      S(IND)=S(IND)+1                                                           
4     CONTINUE                                                                  
      NN=NCAR(K)                                                                
      IF(K.NE.NF) GOTO 11                                                       
      WRITE(IMP,2999) (S(L),L=1,NN)                                             
      WRITE(IMP,4000)                                                           
      GOTO 3                                                                    
11    WRITE(IMP,3000) K,(S(L),L=1,NN)                                           
      WRITE(IMP,5000)                                                           
3     CONTINUE                                                                  
2     CONTINUE                                                                  
1     CONTINUE                                                                  
      RETURN                                                                    
100   FORMAT(1H1,31X,'REPARTITION DE LA POPULATION SUIVANT Y ET LES FACT        
     *EURS A CHAQUE NIVEAU'/1H ,31X,70(1H=))                                    
1000  FORMAT(////1H ,60X,'NIVEAU ',I2/1H ,60X,9(1H=))                           
2000  FORMAT(//1H ,10X,'GROUPE ',I2/1H ,10X,9(1H-))                             
2001  FORMAT(1H ,11X,'MODALITES',11X,'I',10(3X,I2,4X,'I'))                      
2999  FORMAT(1H ,11X,'CRITERE Y',11X,'I',10(3X,I2,4X,'I'))                      
3000  FORMAT(1H ,11X,'FACTEUR ',I1,11X,'I',10(3X,I2,4X,'I'))                    
4000  FORMAT(1H ,132(1H*))                                                      
4001  FORMAT(1H0,132(1H*))                                                      
5000  FORMAT(1H ,31(1H-),'I',10(9(1H-),'I'))                                    
      END                                                                       

      SUBROUTINE IMPPOP(C)                                                      
      INTEGER E,C,DECOU                                                         
      CHARACTER*1 STAR(132),BLANC(132),ENTIER(9)                                  
      CHARACTER*1 BL,YGREC
      COMMON/POP/E(1500,10),NF                                                  
      COMMON /DECDEC/DECOU(100)                                                 
      COMMON /ENSOR/LEC,IMP                                                     
      DATA STAR,BLANC/132*'*',132*' '/                                          
      DATA ENTIER/'1','2','3','4','5','6','7','8','9'/                          
      DATA BL/' '/YGREC/'Y'/                                                    
      WRITE(IMP,100)                                                            
      NNF=NF-1                                                                  
      NSTAR=13*NF+1                                                             
      WRITE(IMP,400) (STAR(I),I=1,NSTAR)                                        
      WRITE(IMP,500) (ENTIER(I),I=1,NNF)                                        
      BLANC(NF)=YGREC                                                           
      WRITE(IMP,901) (BLANC(I),I=1,NF)                                          
      WRITE(IMP,400) (STAR(I),I=1,NSTAR)                                        
      BLANC(NF)=BL                                                              
      C=C-1                                                                     
      DO 1 K=1,C                                                                
      NP0=DECOU(K)+1                                                            
      NP1=DECOU(K+1)                                                            
      DO 2 I=NP0,NP1                                                            
      WRITE(IMP,900) (BLANC(J),J=1,NF)                                          
      WRITE(IMP,600) (E(I,J),J=1,NF)                                            
2     CONTINUE                                                                  
      WRITE(IMP,900) (BLANC(I),I=1,NF)                                          
      WRITE(IMP,400) (STAR(I),I=1,NSTAR)                                        
1     CONTINUE                                                                  
      RETURN                                                                    
100   FORMAT(1H1,55X,'POPULATION REORDONNEE'/1H ,55X,21(1H=)/1H0)               
400   FORMAT(1H ,132A1)                                                         
500   FORMAT(1H ,'I',10(' FACTEUR  ',A1,' I'))                                  
600   FORMAT(1H ,'I',10(5X,I2,5X,'I'))                                          
900   FORMAT(1H ,'I',10(10X,A1,' I'))                                           
901   FORMAT(1H+,1X,10(10X,A1,' I'))                                            
      END                                                                       
