FROM openjdk:8-jdk

#actualizar e instalar python3,pip y git
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y python3 python3-pip git

#spark
RUN wget https://archive.apache.org/dist/spark/spark-3.1.2/spark-3.1.2-bin-hadoop3.2.tgz
RUN tar -xvzf spark-3.1.2-bin-hadoop3.2.tgz
RUN mkdir /opt/spark && mv spark-3.1.2-bin-hadoop3.2/* /opt/spark
ENV SPARK_HOME=/opt/spark

#clonar repo de practica_big_data y setearlo
RUN git clone https://github.com/ging/practica_big_data_2019
WORKDIR /practica_big_data_2019
RUN resources/download_data.sh
RUN pip3 install -r ./requirements.txt

#instalar las librerias de python para apache airflow
WORKDIR /practica_big_data_2019/resources/airflow
RUN pip3 install -r requirements.txt -c constraints.txt

# Setear el environment de airflow
ENV AIRFLOW_HOME=/practica_big_data_2019/resources/airflow
RUN mkdir airflow
RUN mkdir $AIRFLOW_HOME/dags
RUN mkdir $AIRFLOW_HOME/logs
RUN mkdir $AIRFLOW_HOME/plugins

#copiar el setup.py en para que se pueda iniciar el dag e inicializar airflow
COPY resources/airflow/setup.py ./dags
RUN airflow db init
RUN airflow db upgrade

#copiar el script que crea el usuario y exponer los puertos
COPY dockers/airflow/airflow.sh airflow.sh
ENV PROJECT_HOME=/practica_big_data_2019
EXPOSE 9090 8793
RUN chmod +x airflow.sh
CMD ["./airflow.sh"]
