#!/bin/bash

#id=8651
#id=8600
#id=1
#id=3
ann=2012
id=`echo $(($RANDOM%(8651-2)+2))`;

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
    echo "$id" >>sinfoto.id
    exit
  fi
#wget 'http://www.pgr.gob.mx/SPDA/search/'$foto -O foto -o buscando.log

anno=`grep -A 1 'EXPEDIENTE:' buscando.html | tail -1 | cut -d/ -f3 | cut -d\< -f1`
if [ "$anno" != "$ann" ]
  then
     echo "no es del año";
     exit;
  fi

mensj="#LxHasVisto? http://www.pgr.gob.mx/SPDA/search/$foto ayudanos a encontrarlx http://www.pgr.gob.mx/SPDA/search/opera_lista.asp?item_persona=$id"
echo "$mensj";

~/tmp/ttytter.pl -ssl -status="$mensj" -linelength=200

