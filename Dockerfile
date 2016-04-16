FROM debian
MAINTAINER Jacek Kowalski <Jacek@jacekk.info>

ENV MFI_VERSION 2.1.11

RUN apt-get update \
	&& apt-get -y dist-upgrade \
	&& apt-get -y install wget jsvc openjdk-7-jre-headless mongodb-server binutils unzip \
	&& apt-get -y clean

RUN cd /tmp \
	&& wget "http://dl.ubnt.com/mfi/${MFI_VERSION}/mFi.unix.zip" \
	&& unzip mFi.unix.zip \
	&& mv /tmp/mFi /usr/lib/mfi

EXPOSE 8080 8081 8443 8843 8880

VOLUME /usr/lib/mfi/data

WORKDIR /var/lib/mfi
CMD ["/usr/bin/java", "-Xmx1024M", "-jar", "/usr/lib/mfi/lib/ace.jar", "start"]
