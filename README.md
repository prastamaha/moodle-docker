# Moodle LMS docker
to deploy moodle, we need moodle images and dbms (mariadb, msql) images

## pull image

- [moodle image](https://hub.docker.com/repository/docker/prasta/moodle)

```
$ docker pull prasta/moodle:latest
```

- [dbms image (mariadb)](https://hub.docker.com/_/mariadb)

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

docker-compose file [link](https://github.com/prastamaha/moodle-docker/blob/master/docker-compose.yml)

```
version: '3'
services:
    mariadb-moodle:
        image: mariadb:latest
        volumes:
            - moodle_data:/var/lib/mysql
        restart: always
        environment:
            MYSQL_ROOT_PASSWORD: m00dle
            MYSQL_DATABASE: moodle
            MYSQL_USER: moodle
            MYSQL_PASSWORD: m00dle
        networks:
            - moodle
        
    moodle-container:
        depends_on: 
            - mariadb-moodle
        image: prasta/moodle:latest
        ports:
            - "80:80"
        restart: always
	networks:
	    - moodle

volumes:
    moodle_data:        

networks:
    moodle:
```


