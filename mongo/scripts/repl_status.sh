#!/bin/bash
set -e

if [ -f repl_status.txt ]; then
    > repl_status_log.txt
    > repl_status_log1.txt
    > repl_status_log2.txt
else
    touch repl_status_log.txt
    touch repl_status_log1.txt
    touch repl_status_log2.txt
fi

COUNTER=0

while true; do

    # Mevcut tarih ve saati al
    current_datetime=$(date +"%Y-%m-%d %H:%M:%S")

    # Tarih ve saati geçici dosyaya yaz
    echo "$current_datetime" > last_repl_status.txt

    optime_query='var config = rs.conf(); rs.status().members.forEach(member => { var memberConfig = config.members.find(m => m._id === member._id); print(member.name + ": stateStr: " + JSON.stringify(member.stateStr)+ ", priority: " + memberConfig.priority + ", optime: " + JSON.stringify(member.optime) + ", optimeDate: " + member.optimeDate); });'

    # Mongosh çıktısını geçici bir dosyaya yönlendir
    mongosh --host secondary\
        --tls --tlsCertificateKeyFile /etc/ssl/primary.pem \
        --tlsCAFile /etc/ssl/rootCA.pem \
        --authenticationDatabase '$external' \
        --authenticationMechanism MONGODB-X509 \
        --eval "$optime_query" | tail -n +14 >> last_repl_status.txt
    
    # Ekstra bir satır boşluk ekleyin
    echo "" >> last_repl_status.txt

    # Geçici dosya ile orijinal dosyayı birleştir
    cat last_repl_status.txt repl_status_log.txt > combined.txt

    # Orijinal dosyanın adını yeni dosyaya ver
    mv combined.txt repl_status_log.txt

    # Döngü sayacını artır
    COUNTER=$((COUNTER+1))

    # Her 100 döngüde dosyanın içeriğini sıfırla
    if [ "$COUNTER" -eq 100 ]; then
        mv repl_status_log1.txt repl_status_log2.txt
        mv repl_status_log.txt repl_status_log1.txt
        > repl_status_log.txt
        COUNTER=0
    fi

    # Geçici dosyayı sil
    # rm last_repl_status.txt

    # 5 saniye bekle
    sleep 3

done