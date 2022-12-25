echo 'GitHub'
cd ~
git clone https://github.com/ging/practica_big_data_2019.git
cd practica_big_data_2019
resources/download_data.sh

# Virtualenv python
echo ''
echo 'virtualenv()'
sudo apt install python3-pip
rm -rf ~/bdfi_venv
yes | python3 -m pip install virtualenv
python3 -m virtualenv ~/bdfi_venv
. ~/bdfi_venv/bin/activate
cd ~/practica_big_data_2019
yes | python3 -m pip install -r requirements.txt
pip3 install joblib
deactivate
cd

# spark
echo ''
echo 'spark'
cd ~/Downloads
wget https://archive.apache.org/dist/spark/spark-3.1.2/spark-3.1.2-bin-hadoop3.2.tgz
tar -xvzf spark-3.1.2-bin-hadoop3.2.tgz
mkdir -p ~/spark
mv spark-3.1.2-bin-hadoop3.2 ~/spark


# kafka
echo ''
echo 'kafka'
cd ~/Downloads
wget https://archive.apache.org/dist/kafka/3.0.0/kafka_2.12-3.0.0.tgz
tar -xvzf kafka_2.12-3.0.0.tgz 
mkdir ~/kafka
mv kafka_2.12-3.0.0 ~/kafka
cd

# importando en mongo
echo ''
echo 'importar distancias'
cd ~/practicas_big_data_2019
./practica_big_data_2019/resources/import_distances.sh
echo 'Si no funciona el importar distancias hacer cat del import_distances.sh y ejecutar en /practica_big_data_2019,comprobar mongo'
