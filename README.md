# ArcGIS Server on Docker

```sh
docker run --tty --interactive --hostname agserver.local \
  --name agserver \
  --volume $HOME/Documents/ags107.ecp:/arcgis/ags107.ecp \
  --env LICENSE_FILE=/arcgis/ags107.ecp \
  --publish 6080:6080 -p 6443:6443 \
  beginor/agserver:10.7.0
```
