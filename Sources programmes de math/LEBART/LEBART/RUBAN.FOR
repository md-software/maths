C-----------------------------------------------------------------------
C             PROGRAMME DE LECTURE SUR FACIT 4030
C
C                Michel DOMINIQUE -- MARS 1984
C
C
C  UTILISE LES SYSTEM SERVICES $ASSIGN, $QIO, $WAITFR, $QIOW 
C                    ( CF DOC VMS VOL.5A)
C
C  VARIABLES UTILISEES:
C       - NCHAN: N0 DE CANAL DONNE PAR SYS$ASSIGN
C       - IOSB(4): BLOC DE FIN D'EXECUTION D'ENTREE/SORTIE
C                  (POSITIONNE APRES CHAQUE LECTURE DU RUBAN)
C       - FIN(2): TERMINATEUR DE LECTURE 
C                 (ICI:0,0 => PAS DE TERM.ON LIT PAR BLOCS DE 80 CAR.)
C       - BUFFER(80): MEMOIRE TAMPON DE LECTURE (80 CAR. A CHAQUE LECT.)
C
C  SOUS-PROGRAMME:
C       - TEST: TESTE LE STATUS DE FIN D'EXECUTION D'UN SYSTEM SERVICE
C
C-----------------------------------------------------------------------
      IMPLICIT INTEGER*4 (A-Z)
      INTEGER*2 NCHAN,IOSB(4),CANAL
      DIMENSION FIN(2)
      CHARACTER BUFFER*80,EFFACE*7,CHAINE*80,
     1          PROMPT*10 /'  CHOIX > '/
      DATA FIN/0,0/UN,DEUX/49,50/
      INCLUDE '($SSDEF)'
      INCLUDE '($IODEF)'
C---------------------------------------------------
C OUVERTURE FICHIER SORTIE TEMPORAIRE
C LE CONTENU DU RUBAN LU EST STOCKE DANS 'RUBAN.TMP'
C---------------------------------------------------
      OPEN (2,FILE='RUBAN.TMP',STATUS='NEW')
C---------------------------------------------------
C ATTACHEMENT DU LECTEUR FACIT ET DU TERMINAL
C---------------------------------------------------
      STATUS = SYS$ALLOC('FACIT',,,)
      CALL TEST (STATUS)
      STATUS = SYS$ASSIGN('FACIT',NCHAN,,)
      CALL TEST(STATUS)
      STATUS = SYS$ASSIGN('TT',CANAL,,)
      CALL TEST (STATUS)
C---------------------------------------------------
C POUR EFFACER L'ECRAN
C---------------------------------------------------
      EFFACE = CHAR(27)//CHAR(91)//CHAR(72)//
     1         CHAR(27)//CHAR(91)//CHAR(50)//CHAR(74)
C-----------------------------------------------------
C ENVOI D'UN ORDRE DE LECTURE AU FACIT
C-----------------------------------------------------
99    FONCTION = IO$_TTYREADALL
      STATUS = SYS$QIO(%VAL(1),%VAL(NCHAN),%VAL(FONCTION),IOSB,,,
     1           %REF(BUFFER),%VAL(80),,FIN,,)
      CALL TEST (STATUS)
C-----------------------------------------------------
C MISE EN ROUTE DU FACIT 4030
C-----------------------------------------------------
      TYPE *,EFFACE
      TYPE *,'LECTURE DES RUBANS DE MISE-A-JOUR'
      TYPE *,' '
      TYPE *,' '
      TYPE *,' '
      TYPE *,'            METTRE EN ROUTE LE LECTEUR FACIT 4030'
      TYPE *,' '
      TYPE *,'               (APPUYER SUR LE BOUTON "START")'
      TYPE *,' '
C-----------------------------------------------------
C LECTURE BUFFER - ATTENTE DU FLAG 1
C-----------------------------------------------------
      STATUS = SYS$WAITFR(%VAL(1))
      CALL TEST(STATUS)
C-----------------------------------------------------
C PROCHAINES LECTURES AVEC FONCTION MODIFICATRICE
C             DE TIME-OUT
C-----------------------------------------------------
      FONCTION = IO$_TTYREADALL .OR. IO$M_TIMED
      NSEC = 5 ! DELAI DE TIME-OUT A MODIFIER EVENTUELLEMENT
50    IF (IOSB(1).EQ.SS$_TIMEOUT) GOTO 5000
      IF (IOSB(1).NE.SS$_NORMAL) CALL TEST(IOSB(1))
C-----------------------------------------------------
C ON A REMPLI LE BUFFER
C ON L'ECRIT DANS 'RUBAN.TMP'
C-----------------------------------------------------
      WRITE(2,1000) BUFFER
1000  FORMAT(A)
C-----------------------------------------------------
C RELANCE UNE LECTURE DANS LE BUFFER LIBERE
C ATTEND LA FIN DE LA LECTURE OU UN TIME-OUT
C-----------------------------------------------------
      STATUS = SYS$QIOW (,%VAL(NCHAN),%VAL(FONCTION),IOSB,,,
     1           %REF(BUFFER),%VAL(80),%VAL(NSEC),FIN,,)
      CALL TEST (STATUS)
      GOTO 50
C-----------------------------------------------------
C FIN DE RUBAN DETECTE PAR TIME-OUT
C LE CONTENU DU RUBAN EST STOCKE DANS 'RUBAN.TMP'
C LA CONVERSION EN FORMAT PROPRE EST FAITE 
C PAR LE PROGRAMME 'CONVRUB.FOR'
C-----------------------------------------------------
5000  TYPE *,EFFACE
      TYPE *,'1 --> AUTRE RUBAN'
      TYPE *,'2 --> FIN'
      TYPE *,' '
      FONCTION = IO$_READPROMPT
      STATUS = SYS$QIOW(,%VAL(CANAL),%VAL(FONCTION),,,,
     1           %REF(CHAINE),%VAL(80),,,%REF(PROMPT),%VAL(10))
      CALL TEST (STATUS)
      CHIFFRE = ICHAR(CHAINE)
      IF (CHIFFRE .EQ. UN) GOTO 99
      IF (CHIFFRE .NE. DEUX) GOTO 5000
      CLOSE (2,STATUS='KEEP')
C-----------------------------------------------------
C DEASSIGNATION DU CANAL D'ENTREE/SORTIE
C-----------------------------------------------------
      STATUS = SYS$DASSGN (%VAL(NCHAN))
      CALL TEST (STATUS)
      STATUS = SYS$DASSGN (%VAL(CANAL))
      CALL TEST (STATUS)
      CALL SYS$DALLOC('FACIT',)
      CALL TEST (STATUS)
      STOP
      END

C--------------------------------------------------------
C TEST LE STATUS DE FIN D'EXECUTION D'UN SYSTEM SERVICE
C SI LE STATUS EST IMPAIR --> PAS D'ERREUR
C--------------------------------------------------------
      SUBROUTINE TEST (STATUS)
      IMPLICIT INTEGER*4 (S)
      CHARACTER MESSAGE*256,EFFACE*7
      IF (STATUS) GOTO 100
C-------------------------------------------------------
C ERREUR A L'EXECUTION D'UN SYSTEM SERVICE
C AFFICHAGE DU MESSAGE D'ERREUR PAR $GETMSG
C-------------------------------------------------------
      EFFACE = CHAR(27)//CHAR(91)//CHAR(72)//
     1         CHAR(27)//CHAR(91)//CHAR(50)//CHAR(74)
      TYPE *,EFFACE
      IERR = SYS$GETMSG (%VAL(STATUS),LONGUEUR,
     1                   MESSAGE,%VAL(15),)
      IF (.NOT.IERR) STOP 'Erreur sur $GETMSG'
      TYPE 10 
10    FORMAT(//,' ****** ERREUR ******'//)
      TYPE 20,MESSAGE(1:LONGUEUR)
20    FORMAT(1X,A,/)
      TYPE 30,STATUS
30    FORMAT(//' Le code d''erreur est : ',Z8,//,
     1  '        *** PROGRAMME ABORTE ***'//)
      CALL SYS$EXIT ()
100   RETURN
      END
