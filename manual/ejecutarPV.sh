# mongo
echo '0. Estado de Mongo'
echo '+--- sudo service mongod status'

# Nueva terminal y correr zookeeper
echo ''
echo '1. Correr zookeeper en nueva terminal'
echo '+--- cd ~/kafka/kafka_2.12-3.0.0/;bin/zookeeper-server-start.sh config/zookeeper.properties'

# Nueva terminal y correr kafka
echo ''
echo '2. Correr kafka en nueva terminal'
echo '+--- cd ~/kafka/kafka_2.12-3.0.0/;bin/kafka-server-start.sh config/server.properties'


# Creamos topico
echo ''
echo '\3. Crear un nuevo topico'
echo '+--- cd ~/kafka/kafka_2.12-3.0.0/; bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic flight_delay_classification_request'
echo '+--- Si escribimos "bin/kafka-topics.sh --list --zookeeper localhost:2181" veremos la lista de topicos'

# Visor de mensajes de kafka
echo ''
echo '4. Visor de los mensajes de kafka en nueva terminal'
echo '+--- ~/kafka/kafka_2.12-3.0.0/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic flight_delay_classification_request --from-beginning'

# Aplicacion web
echo ''
echo '5. Lanzar el servidor web'
echo 'Lanzamos la web en nueva terminal'
echo '+--- cd ~/practica_big_data_2019/resources/web; . ~/bdfi_venv/bin/activate; python3 predict_flask.py'

echo ''
echo '6. Lanzar el spark-submit'
echo '+--- cd ~/practica_big_data_2019/flight_prediction/target/scala-2.12; $SPARK_HOME/bin/spark-submit --class es.upm.dit.ging.predictor.MakePrediction --master local --packages org.mongodb.spark:mongo-spark-connector_2.12:3.0.1,org.apache.spark:spark-sql-kafka-0-10_2.12:3.0.0 flight_prediction_2.12-0.1.jar'

# Ejecutar el import distances
echo ''
echo '7. Importar distancias'
echo 'cd ~/practicas_big_data_2019'
echo './resources/import_distances.sh'

