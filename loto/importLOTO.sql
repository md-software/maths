--
-- USAGE:
--  lancer mysql en ligne de commandes (base loto)
--  taper: source importLOTO.sql;
--

use loto;

DROP TABLE IF EXISTS HISTO_LOTO;
CREATE TABLE IF NOT EXISTS HISTO_LOTO (
annee_numero_de_tirage int,
jour_de_tirage int,
date_de_tirage varchar(16),
date_de_forclusion varchar(16),
boule_1 int,
boule_2	int,
boule_3	int,
boule_4	int,
boule_5	int,
numero_chance int,
combinaison_gagnante_en_ordre_croissant varchar(32),	
combinaison_triee varchar(32)	
);

TRUNCATE HISTO_LOTO;

LOAD DATA LOCAL INFILE 'historique_loto.csv' INTO TABLE HISTO_LOTO 
     FIELDS TERMINATED BY ';' 
     ENCLOSED BY '"' 
     ESCAPED BY '\\' 
     LINES TERMINATED BY '\r\n' 
     IGNORE 1 LINES
;
