#!/bin/bash

count=`cat /app/database/list.txt | wc -l`
current=1

for database in `cat /app/database/list.txt` ; do 
    echo "${count}/${current} - ${database} - EXECUTANDO"; 
   
    mysqldump --host=${HOST} --user=${USERNAME} --password=${PASSWORD} $database &> "/app/dump/${database}.sql";

    if [ "$?" -eq 0 ]
    then
        echo "${count}/${current} - ${database} - SUCESSO";
    else
        echo "${count}/${current} - ${database} - FALHA"; 
        mv "/app/dump/${database}.sql" "/app/error/${database}.sql"
    fi
    
    current=$((current+1)); 
    echo "Aguardando ..."
    sleep 10; 
done
