#!/bin/bash

if [ -z "$JAVA_OPTS" ]; then
	JAVA_OPTS="-Xmx1024m"
fi

if [ ! -f /usr/lib/mfi/data/system.properties ]; then
	cp -Rf /usr/lib/mfi/data-orig/. /usr/lib/mfi/data/
fi

if [ `id -u` -eq 0 ]; then
	chown -Rf mfi:mfi /usr/lib/mfi/data

	exec sudo -u mfi java $JAVA_OPTS -jar /usr/lib/mfi/lib/ace.jar start
else
	exec java $JAVA_OPTS -jar /usr/lib/mfi/lib/ace.jar start
fi
