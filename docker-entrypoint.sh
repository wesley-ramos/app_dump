#!/bin/bash

count=`cat /app/config/database.txt | wc -l`
current=1

for database in `cat /app/config/database.txt` ; do 
    echo "${count}/${current} - ${database} - DUMP"; 
   
    mysqldump --host=${HOST} --user=${USERNAME} --password=${PASSWORD} $database &> "/app/dump/${database}.sql";

    if [ "$?" -eq 0 ]
    then
        echo "${count}/${current} - ${database} - OK";
        echo "${count}/${current} - ${database} - ZIP";
        zip "/app/dump/${database}.zip" "/app/dump/${database}.sql";
        echo "${count}/${current} - ${database} - OK";
        echo "${count}/${current} - ${database} - S3";

        aws s3 cp "/app/dump/${database}.zip" "${AWS_S3_BUCKET}/${database}.zip";

        if [ "$?" -eq 0 ]
        then
            echo "${count}/${current} - ${database} - OK";
            rm "/app/dump/${database}.sql";
            rm "/app/dump/${database}.zip";
        else
            echo "${count}/${current} - ${database} - FALHA"; 
        fi
    else
        echo "${count}/${current} - ${database} - FALHA"; 
        mv "/app/dump/${database}.sql" "/app/error/${database}.sql";
    fi
    
    current=$((current+1)); 
    echo "Dump concluido,  aguadando a execução do proximo ...";
    sleep 10; 
done
