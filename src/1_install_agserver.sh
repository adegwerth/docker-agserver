#!/bin/bash -e
curl --location --out /arcgis/ArcGIS_Server_Linux_1061_164044.tar.gz \
  http://172.17.0.1/ArcGIS_Server_Linux_1061_164044.tar.gz

tar -zxvf /arcgis/ArcGIS_Server_Linux_1061_164044.tar.gz -C /arcgis/
rm /arcgis/ArcGIS_Server_Linux_1061_164044.tar.gz

/arcgis/ArcGISServer/Setup -m silent -l yes -d /
rm -rf /arcgis/ArcGISServer
