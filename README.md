# mFi

This is a Docker image of mFi Controller
(https://www.ubnt.com/download/mfi/default/default/mfiunixzip)
based on `openjdk:7-jre-slim`.

## Disk space requirements

mFi requires significant amount of storage - 3 GB just for starters.
Secure appropriate disk space and configure data retention.

## Usage

```bash
docker run -d --name=mfi \
	-p 6080:6080 -p 6443:6443 \
	jacekkow/mfi
```

First run wizard should be available at https://127.0.0.1:6443/
(note that self-signed certificate is used).

By default container uses Docker data volume for persistence.

You can update such installation by passing `--volumes-from` option
to `docker run`:

```bash
docker pull jacekkow/mfi
docker stop mfi
docker rename mfi mfi-old
docker run -d --name=mfi \
	-p 6080:6080 -p 6443:6443 \
	--volumes-from mfi-old \
	jacekkow/mfi
docker rm -v mfi-old
```

## Local storage

If you prefer to have direct access to container's data
from the host, you can use local storage instead of data volumes:

```bash
docker run -d --name=mfi \
	-p 6080:6080 -p 6443:6443 \
	-v /srv/mfi:/usr/lib/mfi/data \
	jacekkow/mfi
```

`/usr/lib/mfi/data` will be automatically populated
with default configuration if necessary.

File ownership is recursively changed to
`mfi:mfi` (`500:500`) on each start.

## Configuration

By default the JVM is started with options `-Xmx1024m`.
You can override this default using `JAVA_OPTS` environment variable:

```bash
docker run -d --name=mfi \
	-p 6080:6080 -p 6443:6443 \
	-e "JAVA_OPTS=-Xmx2048m" \
	jacekkow/mfi
```
