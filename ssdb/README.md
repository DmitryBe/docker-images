# ssdb docker image

## Description

[SSDB](https://github.com/ideawu/ssdb).

Custom configuration parameters: `work_dir`, `pidfile` and `logger:level`.

### Pull

```
docker pull dmitryb/ssdb
```

## Usage

```
docker run --rm -p 8888:8888 --name ssdb felixsanz/ssdb
```

This container saves the database files inside `/data`, so if you want to host this files inside your hosts filesystem (good for persistence/backups), start the container with the following command instead:

```
docker run --rm -v ssdb:/data -p 8888:8888 --name ssdb felixsanz/ssdb
```

**Note:** Docker volume `ssdb` must be [created previously](https://docs.docker.com/engine/reference/commandline/volume_create/).

### Custom configuration

```
docker run --rm -v /path/to/ssdb.conf:/usr/local/ssdb/ssdb.conf -p 8888:8888 --name ssdb felixsanz/ssdb
```

### Running `ssdb-cli`

```
docker exec -it ssdb /usr/local/ssdb/ssdb-cli
```

### Java client

Using non-official client [SSDB4J](https://github.com/nutzam/ssdb4j)

```java
import org.nutz.ssdb4j.SSDBs
import org.nutz.ssdb4j.spi.Cmd
import org.nutz.ssdb4j.spi.Response
import org.nutz.ssdb4j.spi.SSDB

val ssdb = SSDBs.pool("127.0.0.1", 8888, 2000, null)

val r = ssdb.set("test", 123)
r.ok()

val r = ssdb.get("test")
r.ok()
r.check().asString

val r2 = ssdb.multi_get("test", "test2")
r2.check().mapString()
```

### Python client

SSDB simple client [SSDB](https://github.com/ideawu/ssdb/blob/master/api/python/SSDB.py)

```python
import os, sys
from sys import stdin, stdout
from SSDB import SSDB

ssdb = SSDB('127.0.0.1', 8888)

ssdb.request('set', ['test', '123'])

ssdb.request('get', ['test'])

ssdb.request('del', ['test'])
```

### CLI 

Command Line examples [CLI](http://ssdb.io/docs/ssdb-cli.html)

```sh
/usr/local/ssdb/ssdb-cli -h 127.0.0.1 -p 8888

set k 1

get k

del k

info

dbsize
```

### Deploy with mesos && marathon

```json
{
   "id": "/ssdb-dev",
   "apps": [
     {
       "id": "node1",
       "cpus": 16,
       "mem": 50000.0,
       "ports": [8888],
       "requirePorts": true,
       "labels": {
         "traefik.portIndex": "0",
         "traefik.frontend.passHostHeader": "true",
         "appname": "ssdb-dev"
       },
       "instances": 1,
       "container": {
         "type": "DOCKER",
         "volumes": [
           {
             "containerPath": "/var/log",
             "hostPath": "/var/log",
             "mode": "RW"
           }
         ],
         "docker": {
           "image": "dmitryb/ssdb:0.0.1",
           "network": "HOST",
           "forcePullImage": true,
           "parameters": [
             { "key": "env", "value": "FORCE_UPDATE=0" }
           ]
         }
       }
     }
   ]
 }
```

upload to marathon
```
curl -include -XPUT "$MARATHON_MASTER/v2/groups?force=true" -d @<path_to_config.json>
```
