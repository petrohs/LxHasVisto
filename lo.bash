#!/bin/bash

#id=8651
#id=8600
id=7990
#id=3

wget 'http://www.pgr.gob.mx/SPDA/search/opera_lista.asp?item_persona='$id -O buscando.html -o buscando.log

grep '<tr><td class="titulo_seccion" align="center">&iexcl;PERSONAS UBICADAS!</td>' buscando.html >/dev/null

if [ $? -eq 0 ]
  then
    echo "persona encontrada"
    echo "$id" >>encontrados.id
    exit
  fi

foto=`grep '<TD><img src="../images/' buscando.html  | cut -d\" -f2`;
if [ -z "$foto" ]
  then
    echo "sin foto";
    exit
  fi
#wget 'http://www.pgr.gob.mx/SPDA/search/'$foto -O foto -o buscando.log

mensj="#LxHasVisto? http://www.pgr.gob.mx/SPDA/search/$foto ayudanos a encontrarlx http://www.pgr.gob.mx/SPDA/search/opera_lista.asp?item_persona=$id"


~/tmp/ttytter.pl -ssl -status="$mensj" -autosplit -linelength=200
