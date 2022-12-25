FROM openjdk:8-jdk

#actualizar e instalar python3 pip y git
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y python3 python3-pip git

#spark
RUN wget https://archive.apache.org/dist/spark/spark-3.1.2/spark-3.1.2-bin-hadoop3.2.tgz
RUN tar -xvzf spark-3.1.2-bin-hadoop3.2.tgz
RUN mkdir /opt/spark && mv spark-3.1.2-bin-hadoop3.2/* /opt/spark
ENV SPARK_HOME=/opt/spark

#copiar el repo de la practica_big_data, descargar los datos e instalar los requirements
RUN git clone https://github.com/ging/practica_big_data_2019
WORKDIR /practica_big_data_2019
RUN resources/download_data.sh
RUN pip3 install -r ./requirements.txt

#copiar los modelos de prediccion y el jar de prediccion
COPY ./models/ models
COPY flight_prediction/target/scala-2.12/flight_prediction_2.12-0.1.jar flight_prediction/target/scala-2.12/flight_prediction_2.12-0.1.jar
RUN chmod +x flight_prediction/target/scala-2.12/flight_prediction_2.12-0.1.jar

#copiar y ejecutar el script de ejecucion de spark-submt
COPY dockers/spark/spark.sh spark.sh
RUN chmod +x spark.sh
CMD ["./spark.sh"]
