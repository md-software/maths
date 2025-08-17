Récupérer l'historique des tirages ici: https://www.fdj.fr/jeux-de-tirage/loto/resultats
(depuis novembre 2019)

Fusionner le loto_201911.csv à la main avec historique_loto.csv
Colonne Ligne 2 Colonne L: =GAUCHE(K2;TROUVE("+";K2)-1)

Démarrer le service wampmysqld64 
Ouvrir invite de commandes (pas powershell), utiliser l'appli Terminal
Importer dans MySQL (pas de password pour root)
    mysql -uroot -p
        SET GLOBAL local_infile=1;
        exit
	cd C:\Users\Michel\Documents\Maths\loto
    mysql -uroot -p --local-infile=1 < importLOTO.SQL 

Aller dans MySQLWorkBench
Base loto
Pour voir si les combinaisons sont déjà sorties, exécuter requête dans select_mes_tirages.sql 


Jeux joués:
Michel:
    7-10-13-22-46 4 
    8-10-12-22-44 7
Grand Loto Noël 2021
    2-12-21-28-43-6
    4-17-29-35-44
    12-21-33-36-43
    