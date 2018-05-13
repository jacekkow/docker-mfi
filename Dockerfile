FROM openjdk:7-jre-slim

ENV MFI_VERSION 2.1.11

RUN apt-get update \
	&& apt-get -y dist-upgrade \
	&& apt-get -y install --no-install-recommends \
		wget jsvc mongodb-server binutils procps unzip \
	&& apt-get -y clean \
	&& rm -Rf /var/lib/apt/lists/*

RUN cd /tmp \
	&& wget "http://dl.ubnt.com/mfi/${MFI_VERSION}/mFi.unix.zip" \
	&& unzip mFi.unix.zip \
	&& rm mFi.unix.zip \
	&& mv /tmp/mFi /usr/lib/mfi \
	&& cp -Rf /usr/lib/mfi/data /usr/lib/mfi/data-orig \
	&& groupadd -r -g 500 mfi \
	&& useradd -r -d /usr/lib/mfi -u 500 -g 500 mfi \
	&& mkdir -p /var/lib/mfi \
	&& chown -Rf mfi:mfi /usr/lib/mfi /var/lib/mfi

EXPOSE 6080 6443

VOLUME /usr/lib/mfi/data

WORKDIR /var/lib/mfi
COPY run.sh /run.sh
CMD /run.sh

USER mfi

HEALTHCHECK --start-period=3m CMD wget -q -O /dev/null --no-check-certificate \
	https://127.0.0.1:6443/login
