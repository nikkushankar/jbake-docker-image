FROM centos:centos7

# Maintainer
# ----------------------------------------------
MAINTAINER Nikku.Shankar@outlook.com

# Environment variables 
# ----------------------------------------------

ARG JBAKE_VER

ENV JAVA_OPTS "-Xms256m -Xmx1024m -Djava.net.preferIPv4Stack=true" 
ENV JAVA_VER jdk8u232-b09
ENV JAVA_HOME /u01/app/${JAVA_VER}
ENV PATH ${PATH}:${JAVA_HOME}/bin:/u01/app/${JBAKE_VER}-bin/bin/

RUN yum -y install wget && \
 yum -y install tar && \
 yum -y install zip && \
 yum -y install unzip

# Final setup
WORKDIR /u01/app/
RUN wget -q https://dl.bintray.com/jbake/binary/${JBAKE_VER}-bin.zip
RUN wget -q https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u232-b09/OpenJDK8U-jdk_x64_linux_hotspot_8u232b09.tar.gz
RUN unzip ${JBAKE_VER}-bin.zip
RUN tar -xzf OpenJDK8U-jdk_x64_linux_hotspot_8u232b09.tar.gz 

COPY src /u01/app/src

CMD ["jbake","-b","/u01/app/src","/u01/app/www"]
