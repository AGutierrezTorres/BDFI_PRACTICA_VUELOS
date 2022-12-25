FROM alpine

#actualizar y añador el openjdk8
RUN apk update && apk upgrade
RUN apk add openjdk8 wget bash

#kafka
RUN wget https://archive.apache.org/dist/kafka/3.0.0/kafka_2.12-3.0.0.tgz
RUN tar -xzvf kafka_2.12-3.0.0.tgz

#exponer puerto del servicio
EXPOSE 2181

#copiar y ejecutar script de inicializacion de zookeeper
COPY dockers/zookeeper/zookeeper.sh /kafka_2.12-3.0.0/zookeeper.sh
WORKDIR /kafka_2.12-3.0.0
RUN chmod +x zookeeper.sh
CMD ["./zookeeper.sh"]
