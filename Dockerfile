https://github.com/scue/docker-opengrok1~FROM tomcat:9.0
RUN mkdir /src
RUN mkdir /data
RUN ln -s /data /var/opengrok
RUN ln -s /src /var/opengrok/src
RUN wget "https://github.com/oracle/opengrok/releases/download/1.7.36/opengrok-1.7.36.tar.gz" -O /tmp/opengrok-1.7.36.tar.gz
RUN wget "http://ftp.us.debian.org/debian/pool/main/e/exuberant-ctags/exuberant-ctags_5.9~svn20110310-8_amd64.deb" -O /tmp/exuberant-ctags_5.9-svn20110310-8_amd64.deb
RUN tar zxvf /tmp/opengrok-1.7.36.tar.gz -C /
RUN dpkg -i /tmp/exuberant-ctags_5.9-svn20110310-8_amd64.deb

ENV SRC_ROOT /src
ENV OPENGROK_TOMCAT_BASE /usr/local/tomcat
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
ENV PATH /opengrok-1.7.36/bin:$PATH

ENV CATALINA_BASE /usr/local/tomcat
ENV CATALINA_HOME /usr/local/tomcat
ENV CATALINA_TMPDIR /usr/local/tomcat/temp
ENV JRE_HOME /usr
ENV CLASSPATH /usr/local/tomcat/bin/bootstrap.jar:/usr/local/tomcat/bin/tomcat-juli.jar

WORKDIR $CATALINA_HOME
RUN /opengrok-1.7.36/bin/OpenGrok deploy

EXPOSE 8080
ADD scripts /scripts
CMD ["/scripts/start.sh"]
