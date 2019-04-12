#!/bin/sh -e

docker run --tty --interactive --hostname agserver.local \
  --name agserver \
  --volume $HOME/Documents/ags106.ecp:/arcgis/ags106.ecp \
  --env LICENSE_FILE=/arcgis/ags106.ecp \
  --publish 6080:6080 -p 6443:6443 \
  beginor/agserver:10.6.1
