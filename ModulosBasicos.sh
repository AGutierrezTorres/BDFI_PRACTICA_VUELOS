# . Meter al final del .bashrc los exports de los directorios importantes del proyecto
#         <------------CODIGO A METER EN ~/.bashrc------------>
#         export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
#         export SPARK_HOME=/home/upm/spark/spark-3.1.2-bin-hadoop3.2
#         export PROJECT_HOME=/home/upm/practica_big_data_2019
#         <------------CODIGO A METER EN ~/.bashrc------------>
# 4. Ejecutar como superusuario: "sudo su -c ./ModulosBasicos.sh"

echo 'limpiar S.O.' 
cd /var/lib/dpkg/updates
rm *

echo 'Linea 01'; apt -yq update
echo 'Linea 02'; apt -yq install git curl openjdk-8-jre-headless

# Python 3.8
echo 'Linea 04'; apt -yq update
echo 'Linea 05'; apt -yq install python3.8 python3-pip

# SBT
echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | sudo tee /etc/apt/sources.list.d/sbt.list
echo 'Linea 07'; curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add
echo 'Linea 08'; apt -yq update
echo 'Linea 09'; apt -yq install sbt

# mongoDB
echo 'Linea 10'; wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add -
echo 'Linea 11'; echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list
echo 'Linea 12'; apt -yq update
echo 'Linea 13'; apt -yq install mongodb-org
echo 'Linea 14'; systemctl start mongod.service


