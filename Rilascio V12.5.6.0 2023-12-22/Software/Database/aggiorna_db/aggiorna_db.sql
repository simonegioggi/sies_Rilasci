-------------------------------------------------------------------------------
-- Scopo ..: Creazione degli oggetti del database del sistema informativo
-- Note ...: eseguire da SQLPLUS /NOLOG
--
-- VERSIONE_SIES_12_5_6_0
-------------------------------------------------------------------------------

WHENEVER SQLERROR CONTINUE
WHENEVER OSERROR CONTINUE

PROMPT Procedura di installazione versione VERSIONE_SIES_12_5_6_0 di SIES
PROMPT
PROMPT Se non si intende procedere chiudere SQL*Plus premendo adesso CTRL+C
PAUSE oppure premere INVIO...

ACCEPT dbsid PROMPT 'Inserire il SID dell''istanza Oracle  ... : ';
ACCEPT siesuser PROMPT 'Inserire il nome dello schema SIES ... : ';
ACCEPT pwd_sies PROMPT 'Inserire la password dello schema SIES ... : ';

PROMPT
PROMPT Per generare il file di log ed il percorso dei datafile in modo opportuno
PROMPT occorre indicare un nome mnemonico per questa installazione.
PROMPT Valore di default: &dbsid
PROMPT
ACCEPT nomeinstallazione PROMPT 'Inserire il nome di questa installazione : ' DEFAULT &dbsid

DEFINE logpath=log
HOST mkdir -p &logpath

PROMPT
PROMPT Inserimento dati completato
PAUSE Premere INVIO per continuare...
PROMPT
SPOOL &logpath/creazione_&nomeinstallazione..log

PROMPT
PROMPT ==============================================================================
PROMPT Riassunto dei dati immessi per questa installazione
PROMPT Nome ....................: &nomeinstallazione
PROMPT ==============================================================================
PROMPT SID Oracle ..............: &dbsid
PROMPT Utente_SIES..............: &siesuser
PROMPT Password_SIES............: &pwd_sies
PROMPT ==============================================================================
!echo '=============================================================================='
!echo '***** DATA INIZIO PROCEDURA:' `date +%d/%m/%Y_%r`
!echo '=============================================================================='
PROMPT
PROMPT Se non si intende procedere chiudere adesso SQL*Plus premendo CTRL+C
PAUSE altrimenti premere INVIO per continuare...

!cd $ORACLE_HOME/bin

CONNECT &siesuser/&pwd_sies@&dbsid

SET TERMOUT ON;
PROMPT
PROMPT ===================================================
PROMPT  LANCIO AGGIORNAMENTO DATI...
PROMPT ===================================================
PROMPT
SET TERMOUT OFF;
@V_12_5_6_0/20230914017.sql
--@V_12_5_6_0/20230914017_PB.sql
@V_12_5_6_0/20231018015.sql
@V_12_5_6_0/202312140112.sql

SET TERMOUT ON;
COMMIT;

PROMPT 
PROMPT ===================================================
PROMPT  LANCIO AGGIORNAMENTO VERSIONE...
PROMPT ===================================================
PROMPT
SET TERMOUT OFF;
@aggiorna_versione.sql

SET TERMOUT ON;
COMMIT;

PROMPT
PROMPT ==============================================================================
PROMPT *******          ******** | Operazioni completate | *******           ********
PROMPT ==============================================================================
PROMPT Le operazioni sono state registrate sul file
PROMPT &logpath/creazione_&nomeinstallazione..log
PROMPT ==============================================================================
!echo '=============================================================================='
!echo '***** DATA FINE PROCEDURA:' `date +%d/%m/%Y_%r`
!echo '=============================================================================='
PROMPT

DISCONNECT

SPOOL off

PAUSE Premere INVIO per concludere...
EXIT