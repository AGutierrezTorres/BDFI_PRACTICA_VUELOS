# BDFI_PRACTICA_VUELOS
Repositorio con la solucion implementada a la practica de vuelos de la asinatura de BDFI 2022

## Introducción

El objetivo de este proyecto de la asignatura de BDFI en el curso 2022-2023 es el de implementar un sistema que permite realizar predicciones de retraso de vuelos. Dicho sistema de predicción esta formado por una serie de módulos los cuales permiten realizar predicciones análiticas y en tiempo real a partir de una serie de trazas y asi poder mostrar el retraso del correspondiente vuelo.
A continuación se muestra la arquitecura del sistema desarrollado:

[<img src="images/video_course_cover.png">](http://datasyndrome.com/video)

## "Arquitectura Back End"
## "Arquitectura Front End"
## "Proceso de Funcionamiento"

En este apartado se detalla en más en profundad el foncionamiento del sistema al completo:
1. Se descarga el dataset de los datos relacionados con los vuelos. Dicho dataset posee la información suficiente como para poder entrenar el modelo y predecir los retrasos. 
2. Se entrena el modelo de Machine Learning a partir del dataset.
3. Se despliega el job de prediccion de retrasos de los vuelos Spark,el cual realiza las predicciones mediante el modelo creado
4. Introducción de los datos del vuelo a predecir en el frontal web y su posterior envio al servidor web de Flask por medio de la cola de mensajería Kafka especificando el tópico.
5. Se entrena el modelo predictivo empleando el algoritmo RandomForest con los datos obtenidos.
6. El job de Spark en el servidor realiza la predicción de los retrasos de los vuelos por medio de los datos del tópico al que se encuentra suscrito de Kafka.
7. La ejecución del job se realiza por medio del fichero jar para Scala generado por medio de spark-submit.
8. Se guardan las diversas predicciones en la base de datos de Mongo.
9. Se realiza la consulta de los resultados de la prediccion a través del uso de polling que flask realiza sobre Mongo y se se muestran en el servidor web.
## "Componentes y herramientas utilizadas"

Es neceraria la instalación de cada componente incluido en los apartados de aquitectura:
- [Intellij](https://www.jetbrains.com/help/idea/installation-guide.html) (jdk_1.8)
- [Pyhton3](https://realpython.com/installing-python/) (versión 3.8)
- [PIP](https://pip.pypa.io/en/stable/installing/)
- [SBT](https://www.scala-sbt.org/release/docs/Setup.html) 
- [MongoDB](https://docs.mongodb.com/manual/installation/) (versión 4.4)
- [Spark](https://spark.apache.org/docs/latest/) (versión 3.1.2)
- [Scala](https://www.scala-lang.org) (versión 2.12)
- [Zookeeper](https://zookeeper.apache.org/releases.html) (versión 3.7.1)
- [Kafka](https://kafka.apache.org/quickstart) (versión 2.12-3.0.0)
- [Flask](https://flask.palletsprojects.com/en/2.2.x/)
- [Docker](https://www.docker.com/)
- A parte se puede desplegar la version dockerizada en plataformas como: [Google-Cloud](https://cloud.google.com/)
- El modelo también se puede entrenar con: [AirFlow](https://airflow.apache.org/docs/apache-airflow/stable/start.html)
## Hitos realizados

De los hitos propuestos en la presentación de la [Practica_big_data](https://github.com/ging/practica_big_data_2019) se han realizado los siguientes:
* *(4 puntos)* Lograr el funcionamiento de la práctica sin realizar modificaciones
*	*(1 punto)* Ejecución del job de predicción con Spark Submit en vez de IntelliJ
*	*(1 punto)* Dockerizar cada uno de los servicios que componen la arquitectura completa
*	*(1 punto)* Desplegar el escenario completo usando docker-compose
*	*(1 punto)* Desplegar el escenario completo en Google Cloud
*	*(2 puntos)* Entrenar el modelo con Apache Airflow
## Instrucciones de despliegue
### Despliegue manual en local

Para el desplieque manual se ha realizado una serie de scripts que facilitan el despliegue. Simplemente hay que mirar el conenido del fichero [instrucciones_manual](https://github.com/AGutierrezTorres/BDFI_PRACTICA_VUELOS/blob/main/instrucciones_manual) y ejecutar en orden los siguientes scripts:
1. [ModulosBasicos.sh](https://github.com/AGutierrezTorres/BDFI_PRACTICA_VUELOS/blob/main/ModulosBasicos.sh)
2. [ModulosPV.sh](https://github.com/AGutierrezTorres/BDFI_PRACTICA_VUELOS/blob/main/ModulosPV.sh)
3. [EntrenaYCompila.sh](https://github.com/AGutierrezTorres/BDFI_PRACTICA_VUELOS/blob/main/EntrenaYCompila.sh)
4. [ejecutarPV.sh](https://github.com/AGutierrezTorres/BDFI_PRACTICA_VUELOS/blob/main/ejecutarPV.sh)
### Despliegue utilizando Docker/Docker-compose

Para el despliegue de la aplicación utilizando docker-compose se deben seguir las indicaciones del fichero [instrucciones_docker+dockerCompose](https://github.com/AGutierrezTorres/BDFI_PRACTICA_VUELOS/blob/main/instrucciones_docker%2BdockerCompose) para instalar docker y docker-compose. 

De manera opcional se puede modificar con el campo replicas del [docker-compose.yml](https://github.com/AGutierrezTorres/BDFI_PRACTICA_VUELOS/blob/main/docker-compose.yml)  el número de workers que se van a desplegar tal y como se muestra en la siguiente imagen:

![docker-composeReplicas](images/replicas_cap.png)

Finalmente, desde la carpeta `BDFI_PRACTICA_VUELOS`:
```
docker-compose up
```
Esto levantará la aplicación web en http://localhost:5000/flights/delays/predict_kafka y spark en http://localhost:8080.
### Despliegue en Google Cloud

```
git clone https://github.com/AGutierrezTorres/BDFI_PRACTICA_VUELOS
cd BDFI_PRACTICA_VUELOS
docker-compose up
```
## Apache airflow

Airflow es una plataforma que le permite crear y ejecutar flujos de trabajo. Un flujo de trabajo se representa como un DAG (un gráfico acíclico dirigido) y contiene piezas de trabajo individuales denominadas tareas, organizadas teniendo en cuenta las dependencias y los flujos de datos.

Un DAG especifica las dependencias entre tareas, el orden en el que se ejecutan y la cantidad de reintentos posibles; las Tareas mismas describen qué hacer, ya sea obtener datos, ejecutar análisis, activar otros sistemas o más.
### Arquitectura

 Consultando la documentación de [Apache airflow](https://airflow.apache.org/docs/apache-airflow/stable/concepts/overview.html) una instalación consiste principalmente de los siguientes componentes:
 ![Airflow-Architecture](images/airflow-arquitecture.jpeg)
- Un **orquestador(scheduler)**, el cual maneja tanto la activación de flujos de trabajo programados como el envío de tareas al ejecutor para ejecutarlas.
- Un **ejecutor**, que maneja las tareas en ejecución. En la instalación predeterminada de Airflow, esto ejecuta todo dentro del programador, pero la mayoría de los ejecutores aptos para producción en realidad envían la ejecución de tareas a los trabajadores.
- Un **servidor web**, que presenta una interfaz de usuario para inspeccionar, activar y depurar el comportamiento de los DAG y las tareas.
- Una **carpeta de archivos DAG**, leída por el orquestador y el ejecutor (y cualquier trabajador que tenga el ejecutor).
- Una **base de metadatos**, utilizada por el orquestador, el ejecutor y el servidor web para almacenar el estado.
### Entrenar el modelo con Apache Airflow (manual)

- Instalar las depencias de Apache Airflow:

```
cd resources/airflow
pip install -r requirements.txt -c constraints.txt
```
- Establecer la variable de entorno `PROJECT_HOME` :
```
export PROJECT_HOME=/home/user/Desktop/practica_big_data_2019
```
- Configurar el entorno de Airflow:

```
export AIRFLOW_HOME=~/airflow
mkdir $AIRFLOW_HOME/dags
mkdir $AIRFLOW_HOME/logs
mkdir $AIRFLOW_HOME/plugins
```
- Copiar el DAG definido en `resources/airflow/setup.py` en la carpeta dags creada en el paso anterior:

```
cp setup.py $AIRFLOW_HOME/dags
```

- Iniciar la bbdd de Airflow: 
```
airflow db init

airflow users create \
    --username admin \
    --firstname Jack \
    --lastname  Sparrow\
    --role Admin \
    --email example@mail.org
    --pass pass
```
- Iniciar el scheduler y el webserver:

```
airflow webserver --port 9090
airflow sheduler
```
- Se puede visitar http://localhost:9090/home para la ver la versión web de Apache Airflow. A continuación se muestra como ejemplo de ejecución de un DAG a través de linea de comandos el DAG creado con anterioridad:

```
airflow dags unpause agile_data_science_batch_prediction_model_training
airflow dags trigger agile_data_science_batch_prediction_model_training
```
![Apache Airflow DAG success](images/airflow.jpeg)
### Entrenar el modelo con Apache Airflow (dockerizado)
Consultar ficheros [Dockerfile](https://github.com/AGutierrezTorres/BDFI_PRACTICA_VUELOS/blob/main/dockers/airflow/Dockerfile) y [airflow.sh](https://github.com/AGutierrezTorres/BDFI_PRACTICA_VUELOS/blob/main/dockers/airflow/airflow.sh) alojados en `dockers/airflow`.
### Análisis del setup.py
En este apartado se realiza un análisis del [setup.py](https://github.com/AGutierrezTorres/BDFI_PRACTICA_VUELOS/blob/main/resources/airflow/setup.py) alojado en `resources/airflow/setup.py`:
```
import sys, os, re

from airflow import DAG
from airflow.operators.bash import BashOperator

from datetime import datetime, timedelta
import iso8601

PROJECT_HOME = os.getenv("PROJECT_HOME")

# En estas propiedades iniciales se define el numero de intentos que debe 
# realizar el DAG antes de que no se ejecute y muera con la propiedad retries
#(3 en este caso).
# Se indica desde la fecha por la que debe comenzar("2016-12-01").
# Y,finalmente,con retry_delay se define cada cuanto tiempo se realizan los 
#reintentos(5min en este caso).
default_args = {
  'owner': 'airflow',
  'depends_on_past': False,
  'start_date': iso8601.parse_date("2016-12-01"),
  'retries': 3,
  'retry_delay': timedelta(minutes=5),
}

# En esta parte se configura el DAG con las propiedades definidas anteriormente
# y sele da un nombre. También se le asigna un schedule_interval para definir 
# cada cuanto tiempo se debe realizar este DAG. Otros posibles valores del schedule_interval
#son: @once @hourly @daily
training_dag = DAG(
  'agile_data_science_batch_prediction_model_training',
  default_args=default_args,
  schedule_interval=None
)

# We use the same two commands for all our PySpark tasks
pyspark_bash_command = """
/opt/spark/bin/spark-submit --master {{ params.master }} \
  {{ params.base_path }}/{{ params.filename }} \
  {{ params.base_path }}
"""
pyspark_date_bash_command = """
/opt/spark/bin/spark-submit --master {{ params.master }} \
  {{ params.base_path }}/{{ params.filename }} \
  {{ ts }} {{ params.base_path }}
"""


# Gather the training data for our classifier
"""
extract_features_operator = BashOperator(
  task_id = "pyspark_extract_features",
  bash_command = pyspark_bash_command,
  params = {
    "master": "local[8]",
    "filename": "resources/extract_features.py",
    "base_path": "{}/".format(PROJECT_HOME)
  },
  dag=training_dag
)
"""
# Aqui se define el BashOperator con el que se determina que tarea se va a ejecutar 
# en el DAG. Dentro se definen la dirección del master de Spark("local[8]"), 
#el archivo de entrenamiento ("resources/train_spark_mllib_model.py")
# y la direccioón del proyecto("{}/".format(PROJECT_HOME))

# Train and persist the classifier model
train_classifier_model_operator = BashOperator(
  task_id = "pyspark_train_classifier_model",
  bash_command = pyspark_bash_command,
  params = {
  #Para asignar el master a un spark node que sea master se ha cambiado el campo "master": "local[8]" por:
    "master": "spark://master:7077",
    "filename": "resources/train_spark_mllib_model.py",
    "base_path": "{}".format(PROJECT_HOME)
  },
  dag=training_dag
)

# The model training depends on the feature extraction
#train_classifier_model_operator.set_upstream(extract_features_operator)
```
En concreto este DAG no tiene Schedule_interval y no se realiza de forma periódica. Si falla la tarea, hay definidas una serie de propiedades que acotan el numero de intentos a realizar antes de que el DAG se ejecute. En este caso particular, observando los campos retries y retry_delay, se pueden realizar hasta 3 reintentos con un delay de 5 minutos cada uno.
