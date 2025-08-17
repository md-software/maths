1 REM Calcul des d‚cimales de PI
2 :
10 CLS :
   CLEAR :
   INPUT "Nombre de d‚cimales: "; ndec$:
   ndec = VAL(ndec$):
   IF ndec$ = "" THEN END
20 IF ndec = 0 THEN END
24 :
25 REM Calcul du nombre de boucles
26 :
30 LOCATE 4, 14
40 PRINT "Patience...":
   nmem = INT(ndec / 5):
   IF (INT(ndec / 5) <> ndec / 5) THEN nmem = nmem + 1
50 n = (ndec + 1) * LOG(10)
60 s = 0:
   nb = 1
70 nb = nb + 1:
   s = s + LOG(2 + 1 / nb):
   IF n >= s THEN GOTO 70
75 :
76 REM Initialisations
77 :
80 DIM dec(nmem):
   dec(1) = 100000:
   ni = dec(1):
   nj = ni * 10:
   ad = 2 * ni
89 :
90 REM Calcul des d‚cimales
91 :
100 FOR n = nb TO 1 STEP -1
110 REM LOCATE 10, 15:
111 REM PRINT nb - n + 1; "/"; nb:
115     m = 0:
        k = 2 * n + 1
120     FOR i = 1 TO nmem:
                z = dec(i) + m:
                dec(i) = INT(z / k):
                m = (z - dec(i) * k) * ni:
        NEXT i
170     m = 0
180     FOR i = nmem TO 2 STEP -1:
                dec(i) = dec(i) * n + m:
                m = INT(dec(i) / ni):
                dec(i) = dec(i) - m * ni:
        NEXT i
230     dec(1) = dec(1) * n + m:
        m = INT(dec(1) / nj):
        dec(1) = dec(1) - m * nj + ad
260 NEXT n
270 GOSUB 1000:
    GOTO 10
995 :
996 REM Affichage des d‚cimales
997 :
1000 CLS
1010 PRINT TAB(5); "*** PI avec "; ndec; " d‚cimales ***":
     PRINT
1020 c$ = STR$(dec(1)):
     c$ = RIGHT$(c$, 5):
     dec(1) = VAL(c$)
1030 PRINT "3, "; :
     n = 0:
     l = 0
1040 FOR i = 1 TO nmem - 1
1050    IF n = 6 THEN n = 0: PRINT : PRINT SPC(3);
1060    z$ = STR$(dec(i))
1070    FOR j = 1 TO 5 - LEN(z$) + 1:
                PRINT "0"; :
        NEXT j
1080    PRINT RIGHT$(z$, LEN(z$) - 1); " "; :
        n = n + 1
1090 NEXT i
1100 ll = ndec - 5 * (nmem - 1):
     IF ll = 0 THEN GOTO 1140
1110 z$ = STR$(dec(nmem))
1120 FOR j = 1 TO 5 - LEN(z$) + 1:
        z$ = "0" + RIGHT$(z$, LEN(z$) - 1):
     NEXT j
1130 PRINT MID$(z$, 2, ll)
1140 LOCATE 23, 3:
     INPUT " Pressez Entr‚e pour continuer "; key$
1150 RETURN





