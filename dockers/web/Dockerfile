FROM openjdk:8-jdk
#actualizar e instalar python3 y pip
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y python3 python3-pip 

WORKDIR /home
#instalar git, clonar repo de practica_big_data, instalar requirements y joblib
RUN apt-get install git -y
RUN git clone https://github.com/ging/practica_big_data_2019 
WORKDIR /home/practica_big_data_2019
RUN pip3 install -r ./requirements.txt
RUN pip install joblib

#Realizar las modificaciones pertinentes en el predict_plask.py para tener conexion a mongo y kafka y ejecutarlo
ENV PROJECT_HOME=/home/practica_big_data_2019
RUN sed -i 's+MongoClient()+MongoClient("mongodb://mongo:27017")+g' resources/web/predict_flask.py
RUN sed -i "s/'localhost:9092'/'kafka:9092'/g" resources/web/predict_flask.py
CMD ["python3", "resources/web/predict_flask.py"]
