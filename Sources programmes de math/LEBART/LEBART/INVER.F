C ********************************
C *                              *
C *    INVERSION DE MATRICES     *
C *                              *
C ********************************
	SUBROUTINE INVER (A,N,NDIM,IFLAG)
	DIMENSION A(NDIM,NDIM)
	COMMON /ENSOR/LEC,IMP
	IFLAG=0
	DO 200 K=1,N
	D=A(K,K)
	IF (D.EQ.0.0) GOTO 300
	A(K,K)=1
	DO 100 J=1,N
100	A(K,J)=A(K,J)/D
	DO 200 I=1,N
	IF (I.EQ.K) GOTO 200
	D=A(I,K)
	A(I,K)=0.0
	DO 200 J=1,N
	A(I,J)=A(I,J)-D*A(K,J)
200	CONTINUE
	RETURN
300	WRITE(IMP,1000)
1000	FORMAT(1H0,'**** PIVOT NUL ****')
	IFLAG=1
	RETURN
	END
