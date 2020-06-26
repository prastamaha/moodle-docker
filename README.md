# Moodle LMS docker
to deploy moodle, we need moodle images and dbms (mariadb, msql) images

## pull image

- moodle image

```
$ docker pull prasta/moodle:latest
```

- dbms image (mariadb)

```
$ docker pull mariadb:latest
```

## deploy interactively

- create user-define network

```
$ docker network create moodle
```

- run mariadb container

```
$ mkdir /var/lib/mysql-moodle

$ docker run --name=mariadb-moodle --network=moodle \
   -e MYSQL_ROOT_PASSWORD=m00dle \
   -e MYSQL_USER=moodle \
   -e MYSQL_PASSWORD=m00dle \
   -e MYSQL_DATABASE=moodle \
   -v /var/lib/mysql-moodle:/var/lib/mysql \
   mariadb:latest
```

- run moodle container
```
$ docker run --name=moodle-container --network=moodle -d -p 80:80 prasta/moodle:latest
```

## deploy using docker-compose
