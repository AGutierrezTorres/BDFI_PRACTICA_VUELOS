
if test "$#" -ne 1 
then 
        echo 'Modificar ~/practica_big_data_2019/flight_prediction/src/main/scala/es/upm/dit/ging/predictor/MakePrediction.scala y cambiar val base_path por val base_path = "/home/upm/practica_big_data_2019". Reejecutar script con un argumento'
else
	export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
	export SPARK_HOME=/home/upm/spark/spark-3.1.2-bin-hadoop3.2

	echo 'Entrenamiento'
	cd ~/practica_big_data_2019
	. ~/bdfi_venv/bin/activate
	python3 resources/train_spark_mllib_model.py .

	echo 'Compilar scala en .jar'
	cd ~/practica_big_data_2019/flight_prediction
		sbt package 

fi
