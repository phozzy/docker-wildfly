# docker-wildfly

wildfly images prepared to work with mysql(not mariadb), postgresql, others tbd...

* to work with mysql do:

`docker pull phozzy/wildfly:mysql`

```
docker run --name='some_name' -it -p 8080:8080 \
-e MYSQL_USER='your_user' \
-e MYSQL_PASSWORD='your_password' \
-e MYSQL_CONNECTION='jdbc:mysql://your_host/your_database' \
phozzy/docker-wildfly:mysql
```

* to work with postgresql do:

`docker pull phozzy/wildfly:postgresql`

```
docker run --name='some_name' -it -p 8080:8080 \
-e POSTGRES_USER='your_user' \
-e POSTGRES_PASSWORD='your_password' \
-e POSTGRES_CONNECTION='jdbc:postgresql://your_host/your_database' \
phozzy/docker-wildfly:postgresql
```
