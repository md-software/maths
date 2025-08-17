      SUBROUTINE PERMX(IDIM,KDIM,ICARD,JCARD,X,ID,JD)
      DIMENSION X(IDIM,KDIM),ID(IDIM),JD(KDIM)
      DO 20 I=1,ICARD
      IA=ID(I)
10    IF (IA.LE.I) GOTO 20
      IB=ID(IA)
      ID(IA)=-IB
      IA=IB
      GOTO 10
20    ID(I)=-ID(I)
      IF (JD(1).LT.0) GOTO 50
      DO 40 J=1,JCARD    
      JA=JD(J)
30    IF (JA.LE.J) GOTO 40
      JB=JD(JA)
      JD(JA)=-JB
      JA=JB
      GOTO 30
40    JD(J)=-JD(J)
50    CONTINUE
      DO 110 I=1,ICARD
      IA=-ID(I)
      IF (IA.LT.0) GOTO 110
      M=0
60    IA=ID(IA)
      M=M+1
      IF (IA.GT.0) GOTO 60
      IA=I
      DO 100 J=1,JCARD
      IF (JD(J).GT.0) GOTO 100
      JB=J
      K=M
70    JA=JB
      XA=X(IA,JA)
80    IA=IABS(ID(IA))
      JA=IABS(JD(JA))
      XB=X(IA,JA)
      X(IA,JA)=XA
      XA=XB
      IF (JA.NE.JB) GOTO 80
      K=K-1
      IF (IA.NE.I) GOTO 80
      JB=IABS(JD(JB))
90    IF (K.NE.0) GOTO 70
100   CONTINUE
110   CONTINUE
      DO 120 I=1,ICARD
120   ID(I)=IABS(ID(I))
      IF (JD(1).GT.0) RETURN
      DO 130 J=1,JCARD
130   JD(J)=IABS(JD(J))
      RETURN
      END
