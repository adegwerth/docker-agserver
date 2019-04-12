#!/bin/sh -e
docker run --tty --interactive --ulimit nofile=65535 --ulimit nproc=25059 \
  --volume $(pwd)/src:/src --publish 6080:6080 --publish 6443:6443 \
  --hostname agserver.local ubuntu:18.04

docker run --tty --interactive --hostname agserver.local \
  --name agserver \
  --volume $HOME/Documents/ags106.ecp:/arcgis/ags106.ecp \
  --env LICENSE_FILE=/arcgis/ags106.ecp \
  --publish 6080:6080 -p 6443:6443 \
  beginor/agserver:10.6.1
