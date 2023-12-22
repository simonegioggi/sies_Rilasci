update template x  set x.nome_template = substr(x.nome_template,  1,  length(x.nome_template) - 3) || 'rtf' where x.id_template in
(select t.id_template  from template t  where substr(t.nome_template, length(t.nome_template) - 2, 3) = 'RTF');
DELETE FROM versione WHERE cod_versione='12.5.6.0';
INSERT INTO versione (COD_VERSIONE, DATA, DESCRIZIONE) VALUES ('12.5.6.0', to_date(to_char(SYSDATE, 'dd/MM/yyyy'), 'dd/MM/yyyy'), 'Patch per rilascio MAC di Novembre e Dicembre 2023');