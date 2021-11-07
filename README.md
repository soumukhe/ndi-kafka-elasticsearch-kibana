# ndi-kafka-elasticsearch-kibana

This is basically the Confluent docker code which has been slightly modified for the purpose of POC usage for Nexus Dashboard Insights Kafka Usage.
With this you can quickly configure your Kafka Producer on NDI to export to the Kafka Consumer running on a docker conatiner and then use Kafka Connect
pipeline so the data is available in elasticsearch for analysis and viewing.  You can then also use Kibana for nice graphs/charts visualizations.

Confluent documentation can be found at: https://docs.confluent.io/platform/current/platform.html

# Modifications from the original Confluent code:
```
a) there is a fixIP script that needs to be run so that you can successfully export data from NDI to the Kafka Consumer
b) logstash container is also configured, but commented out, since for this case we will use Kafka Connect.  If you needed to run logstash, please comment out the logstash block from docker-compose.yaml
c) added network: elk
```

# Requirements:  
VM with ubuntu and docker/docker-compose installed.  If you don't have that, please look at the bottom of this README file

# Steps to install:
1) ssh to ubuntu box and clone this repo:  git clone https://github.com/soumukhe/ndi-kafka-elasticsearch-kibana.git
2) cd ndi-kafka-elasticsearch-kibana
3) run the fixIP script with the IP of the VM.  For example  ./fixIP 10.10.140.10
3) docker-compose up -d 
4) make sure to do a docker ps to verify that all 8 associated containers are up and running

```
You should have 8 cotainers running as shown below:

aciadmin@DMZ-Ubuntu-Jump-User:~/ndi-kafka-elasticsearch-kibana$ docker ps --format '{{ .Names }}' | sort |nl
     1  broker
     2  elasticsearch
     3  kafkacat
     4  kafka-connect
     5  kibana
     6  ksqldb
     7  schema-registry
     8  zookeeper
     
after the containers come up, please repeat the command "docker ps --format '{{ .Names }}' | sort |nl"  after a few minutes.
What I noticed is that ksqldb might have crashed.  If this is the case,  just do "docker-compose up -d" again and then ksqldb will be stable

you can always check logs for ksqldb by:   docker logs -f ksqldb
    
```

# Configuring NDI to export data:
Please see unofficalaciguide.com

# In case you don't have a vm with docker/docker-compose, follow these steps first to install:
```
1) Download Ubuntu 20.04 --  https://ubuntu.com/download/desktop
2) Install Ubuntu VM minimum version
3) update/upgrade ubuntu and install basic utils: 
   sudo -i
   apt update && apt upgrade -y
   apt auto-remove
   apt install -y curl wget vim openssh-server
4) Install docker and docker-compose:
   ssh to your Ubuntu VM on backend APIM EPG
   sudo -i
   apt-get update && apt-get upgrade -y
   echo net.ipv4.ip_forward=1 >> /etc/sysctl.conf
   sysctl -p
   sudo sysctl --system
   exit 
   sudo apt install docker.io -y
   sudo systemctl start docker
   sudo systemctl enable docker
   sudo groupadd docker
   sudo usermod -aG docker $USER
   exit # and ssh back in for this to work
   docker --version
   sudo apt install docker-compose -y
