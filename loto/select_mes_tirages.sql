use loto;
select date_de_tirage, combinaison_triee, numero_chance 
from loto.histo_loto 
where (combinaison_triee in ('7-10-13-22-46') and numero_chance in (4)) or 
	  (combinaison_triee in ('8-10-12-22-44') and numero_chance in (7)) or
	  (combinaison_triee in ('4-12-20-31-41') and numero_chance in (2))
;