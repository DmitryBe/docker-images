# ssdb docker image

## Description

[SSDB](https://github.com/ideawu/ssdb).

Custom configuration parameters: `work_dir`, `pidfile` and `logger:level`.

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
