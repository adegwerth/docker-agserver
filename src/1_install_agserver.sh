#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

cd /arcgis
curl --location --out ArcGIS_Server_Linux_1061_164044.tar.gz \
  http://192.168.2.14/ArcGIS_Server_Linux_1061_164044.tar.gz

tar -zxvf ArcGIS_Server_Linux_1061_164044.tar.gz
rm ArcGIS_Server_Linux_1061_164044.tar.gz

cd ArcGISServer
./Setup -m silent -l yes
cd ..
rm -rf ArcGISServer

curl --out ags106.eap http://192.168.2.14/ags106.ecp
server/tools/authorizeSoftware -f ags106.ecp
rm ags106.ecp
