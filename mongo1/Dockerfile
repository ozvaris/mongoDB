# Use the official MongoDB Docker image as base
FROM mongo:latest

# MongoDB'nin çalışacağı port
EXPOSE 27017

# İmajı güncelleyin ve Vim paketini kurun
RUN apt-get update && \
    apt-get install -y vim && \
    rm -rf /var/lib/apt/lists/*

# Başlangıç scriptini konteynera kopyalayın
# COPY init-mongo.js /docker-entrypoint-initdb.d/

COPY ./crt/primary.pem /etc/ssl
COPY ./crt/rootCA.pem /etc/ssl
COPY ./crt/cluster.pem /etc/ssl

# Yapılandırma dosyasını konteynıra kopyala
COPY mongod.conf /etc/mongod.conf


# Gerekli yetkilendirmeleri verin
# RUN chmod 755 /docker-entrypoint-initdb.d/init-mongo.js

RUN echo "********************************************************"

# MongoDB'yi özel yapılandırma ile başlat
CMD ["mongod", "--config", "/etc/mongod.conf"]
