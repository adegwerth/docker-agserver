# starting from a CentOS 7 base image.
FROM centos:7
MAINTAINER Rob Howard <howardro@ecu.edu>

# metadata about this Docker image.
LABEL name="ArcGIS for Server Advanced Enterprise" \
      version="10.4.1" \
      description="ArcGIS for Server is software that makes your geographic information available to others in your organization and optionally anyone with an Internet connection." \
      license="proprietary" \
      url="http://www.esri.com/software/arcgis/arcgisserver"

# update and install required packaged from yum.
RUN yum -y update && \
    yum -y install gettext net-tools fontconfig freetype libXfont libXtst \
        libXi libXrender mesa-libGL mesa-libGLU Xvfb && \
    yum clean all && \
    rm -rf /var/cache/yum

# add the contents of the build directory to the /src directory of the image.
COPY ./ags104.ecp /tmp
COPY ./ArcGIS_for_Server_Linux_1041_151978.tar.gz /tmp

# make sure that the arcgis user account exists and that it has permission to modify files
# in the installation and source paths.
RUN groupadd arcgis && \
    useradd -m -r arcgis -g arcgis && \
    mkdir -p /arcgis/server && \
    chown -R arcgis:arcgis /arcgis && \
    chown -R arcgis:arcgis /tmp && \
    chmod -R 755 /arcgis

RUN echo -e "arcgis soft nofile 65535\narcgis hard nofile 65535\narcgis soft nproc 25059\narcgis hard nproc 25059" >> /etc/security/limits.conf

# switch to the arcgis user account to setup the environment.
USER arcgis

RUN tar xvzf /tmp/ArcGIS_for_Server_Linux_1041_151978.tar.gz -C /tmp/ && \
    /tmp/ArcGISServer/Setup -m silent -l yes -a /tmp/ags104.ecp -d /

RUN rm /tmp/ArcGIS_for_Server_Linux_1041_151978.tar.gz && \
    rm /tmp/ags104.ecp && \
    rm -rf rf /tmp/ArcGISServer

COPY ./init.sh /arcgis
# expose ports used for connecting to services and other site machines
# but not ones that are used for internal purposes.
EXPOSE 1098 4000 4001 4002 4003 4004 6006 6080 6099 6443

# execute the init script.
CMD ["/arcgis/init.sh"]
