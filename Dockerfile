FROM openjdk:7-jre-slim

ENV MFI_VERSION 2.1.11

RUN apt-get update \
	&& apt-get -y dist-upgrade \
	&& apt-get -y install --no-install-recommends \
		wget jsvc mongodb-server binutils unzip \
	&& apt-get -y clean \
	&& rm -Rf /var/lib/apt/lists/*

RUN cd /tmp \
	&& wget "http://dl.ubnt.com/mfi/${MFI_VERSION}/mFi.unix.zip" \
	&& unzip mFi.unix.zip \
	&& mv /tmp/mFi /usr/lib/mfi

EXPOSE 6080 6443

VOLUME /usr/lib/mfi/data

WORKDIR /var/lib/mfi
CMD ["/usr/bin/java", "-Xmx1024M", "-jar", "/usr/lib/mfi/lib/ace.jar", "start"]
