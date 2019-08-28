FROM ubuntu:18.04

LABEL MAINTAINER="beginor <beginor@qq.com>"

COPY ["src/0_base_system.sh", "src/1_install_agserver.sh", "/tmp/"]
COPY ["src/docker_entry_point.sh", "/usr/bin"]
# Create arcgis user
RUN /tmp/0_base_system.sh
# Switch to arcgis and install ArcGIS for Server
USER arcgis
ENV HOME /arcgis
ENV LICENSE_FILE=/arcgis/ags107.ecp
RUN /tmp/1_install_agserver.sh

ENTRYPOINT ["/usr/bin/docker_entry_point.sh"]
