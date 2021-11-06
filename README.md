# ndi-kafka-elasticsearch-kibana

This is basically the Confluent docker code which has been slightly modified for the purpose of POC usage for Nexus Dashboard Insights Kafka Usage.
With this you can quickly configure your Kafka Producer on NDI to export to the Kafka Consumer running on a docker conatiner and then use Kafka Connect
pipeline so the data is available in elasticsearch for analysis and viewing.  You can then also use Kibana for nice graphs/charts visualizations.

Confluent documentation can be found at: https://docs.confluent.io/platform/current/platform.html

# Usage:


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
