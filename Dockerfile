#从官方CentOS7镜像构建
FROM centos:7

MAINTAINER	Ning Zhou "zn19860115@gmail.com"

#拷贝当前路径下所有文件到容器内的tmp目录下
COPY ./* /tmp/


RUN yum install -y net-tools && yum install -y wget && yum install -y libXtst && yum install -y libXi && yum install -y libXrender && yum install -y fontconfig && yum install -y freetype && yum install -y gettext && yum install -y libXfont && yum install -y mesa-libGL && yum install -y mesa-libGLU && yum install -y Xvfb 

#ADD指令会自动解压tar文件
ADD . /src

RUN /usr/sbin/useradd --create-home --home-dir /usr/local/arcgis --shell /bin/bash arcgis 

RUN chown -R arcgis /src

USER arcgis

ENV HOME /usr/local/arcgis

RUN tar xvzf /tmp/ArcGIS_for_Server_Linux_1031_145870.tar.gz -C /tmp/ && /tmp/ArcGISServer/Setup -m silent -l yes -a /tmp/authorization.ecp

#对外暴露相关端口
EXPOSE 1098 4000 4001 4002 4003 4004 6006 6080 6099 6443

#容器运行后默认执行的指令
#ENTRYPOINT ["/usr/local/arcgis/server/startserver.sh"]

#构建镜像
#docker build -t ags .

#运行镜像
#docker-machine ssh default
#docker run -it -p 6080:6080 ags bash