#从官方CentOS7镜像构建
FROM centos:7

MAINTAINER	Ning Zhou "zn19860115@gmail.com"

#拷贝当前路径下所有文件到容器内的tmp目录下
COPY ./* /tmp/


RUN yum install -y net-tools && yum install -y wget && yum install -y libXtst && yum install -y libXi && yum install -y libXrender && yum install -y fontconfig && yum install -y freetype && yum install -y gettext && yum install -y libXfont && yum install -y mesa-libGL && yum install -y mesa-libGLU && yum install -y Xvfb && yum install -y vim && yum install -y tar && yum install hostname

#ADD指令会自动解压tar文件
ADD . /src

RUN /usr/sbin/useradd --create-home --home-dir /usr/local/arcgis --shell /bin/bash arcgis 

RUN chown -R arcgis /src

RUN echo -e "arcgis soft nofile 65535\narcgis hard nofile 65535\narcgis soft nproc 25059\narcgis hard nproc 25059" >> /etc/security/limits.conf

USER arcgis

ENV HOME /usr/local/arcgis

RUN tar xvzf /tmp/ArcGIS_Server_Linux_105_154052.tar.gz -C /tmp/ && /tmp/ArcGISServer/Setup -m silent -l yes -a /tmp/ArcGISServer105all.ecp

#对外暴露相关端口
EXPOSE 1098 4000 4001 4002 4003 4004 6006 6080 6099 6443

RUN rm /tmp/ArcGIS_Server_Linux_105_154052.tar.gz && rm -rf rf /tmp/ArcGISServer

#CMD /usr/local/arcgis/arcgis/server/startserver.sh && tail -f /usr/local/arcgis/arcgis/server/framework/etc/service_error.log

#容器运行后默认执行的指令
#ENTRYPOINT ["/usr/local/arcgis/arcgis/server/startserver.sh"]

#构建镜像
#docker build -t ags105 .

#运行镜像
#docker-machine ssh default
#docker run --name agsxxx -d --hostname agsxxx -it -p 6080:6080 -p 6443:6443 ags105 bash