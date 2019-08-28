#!/bin/bash -e

curl --location --out /arcgis/ArcGIS_Server_Linux_107_167707.tar.gz \
  http://172.21.68.68/Downloads/ArcGIS_Server_Linux_107_167707.tar.gz

tar -zxvf /arcgis/ArcGIS_Server_Linux_107_167707.tar.gz -C /arcgis/
rm /arcgis/ArcGIS_Server_Linux_107_167707.tar.gz

/arcgis/ArcGISServer/Setup -m silent -l yes -d /
rm -rf /arcgis/ArcGISServer
