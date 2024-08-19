#!/bin/bash

#---------------------------------#
#     RECONFIHURE LOCAL DNS       #
#     usage ./start.sh            #
#---------------------------------#
#
# autor: Piotr Koska
# email: noreplay.koska@gmail.com

# change dir.
cd ./

# remove docker container.
# docker container rm -f home-dns

# remove image.
#docker image rm home-dns:arm

# This is banner
figlet -f slant Build

# rebuild local image.
arch_type=$(lscpu | grep "Architecture:" | awk -F" " '{print $2}')
if [ "$arch_type" = "armv7l" ]; then
  type="arm"
  docker build --no-cache -t index.docker.io/piotrskoska/strefakursow-dns:arm -t index.docker.io/piotrskoska/strefakursow-dns:latest .
  if [[ $? -ne 0 ]]; then
    exit 1
  fi
elif [ "$arch_type" = "x86_64" ]; then
  type="x86_64"
  docker build --no-cache -t index.docker.io/piotrskoska/strefakursow-dns:x86_64 -t index.docker.io/piotrskoska/strefakursow-dns:latest .
  if [[ $? -ne 0 ]]; then
    exit 1
  fi
else
  echo "Architecture problem: $arch_type"
  exit 1
fi



# This is banner
figlet -f slant Push 1
# push to docker registry - docker hub.
docker push index.docker.io/piotrskoska/strefakursow-dns:${type}
if [[ $? -ne 0 ]]; then
  exit 1
fi

# prune all docker 
# docker system prune -af

# start DNS container.
#docker run --name strefakursow-dns -d --restart=unless-stopped -p 53:53/tcp -p 53:53/udp index.docker.io/piotrskoska/strefakursow-dns:x86_64

# show all started docker. 
docker ps