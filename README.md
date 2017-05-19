[![CircleCI](https://circleci.com/gh/bitnami/bitnami-docker-tomcat/tree/master.svg?style=shield)](https://circleci.com/gh/bitnami/bitnami-docker-tomcat/tree/master)
[![Slack](http://slack.oss.bitnami.com/badge.svg)](http://slack.oss.bitnami.com)
[![Kubectl](https://img.shields.io/badge/kubectl-Available-green.svg)](https://raw.githubusercontent.com/bitnami/bitnami-docker-tomcat/master/kubernetes.yml)

# What is Tomcat?

> [Apache Tomcat](http://tomcat.apache.org), often referred to as Tomcat, is an open-source web server and servlet container developed by the [Apache Software Foundation (ASF)](https://www.apache.org). Tomcat implements several Java EE specifications including Java Servlet, JavaServer Pages (JSP), Java EL, and WebSocket, and provides a "pure Java" HTTP web server environment for Java code to run in.

# TL;DR;

```bash
docker run --name tomcat bitnami/tomcat:latest
```

## Docker Compose

```yaml
version: '2'

services:
  tomcat:
    image: 'bitnami/tomcat:latest'
    ports:
      - '8080:8080'
```

## Kubernetes

> **WARNING:** This is a beta configuration, currently unsupported.

Get the raw URL pointing to the kubernetes.yml manifest and use kubectl to create the resources on your Kubernetes cluster like so:

```bash
$ kubectl create -f https://raw.githubusercontent.com/bitnami/bitnami-docker-tomcat/master/kubernetes.yml
```

# Why use Bitnami Images?

* Bitnami closely tracks upstream source changes and promptly publishes new versions of this image using our automated systems.
* With Bitnami images the latest bug fixes and features are available as soon as possible.
* Bitnami containers, virtual machines and cloud images use the same components and configuration approach - making it easy to switch between formats based on your project needs.
* Bitnami images are built on CircleCI and automatically pushed to the Docker Hub.
* All our images are based on [minideb](https://github.com/bitnami/minideb) a minimalist Debian based container image which gives you a small base container image and the familiarity of a leading linux distribution.

# Supported tags and respective `Dockerfile` links

 - [`9.0`, `9.0.0.M21-r0`, `latest` (9.0/Dockerfile)](https://github.com/bitnami/bitnami-docker-tomcat/blob/9.0.0.M21-r0/9.0/Dockerfile)
 - [`8.5`, `8.5.15-r0` (8.5/Dockerfile)](https://github.com/bitnami/bitnami-docker-tomcat/blob/8.5.15-r0/8.5/Dockerfile)
 - [`8.0`, `8.0.43-r2` (8.0/Dockerfile)](https://github.com/bitnami/bitnami-docker-tomcat/blob/8.0.43-r2/8.0/Dockerfile)
 - [`7`, `7.0.77-r2` (7/Dockerfile)](https://github.com/bitnami/bitnami-docker-tomcat/blob/7.0.77-r2/7/Dockerfile)

Subscribe to project updates by watching the [bitnami/tomcat GitHub repo](https://github.com/bitnami/bitnami-docker-tomcat).

# Get this image

The recommended way to get the Bitnami Tomcat Docker Image is to pull the prebuilt image from the [Docker Hub Registry](https://hub.docker.com/r/bitnami/tomcat).

```bash
docker pull bitnami/tomcat:latest
```

To use a specific version, you can pull a versioned tag. You can view the [list of available versions](https://hub.docker.com/r/bitnami/tomcat/tags/) in the Docker Hub Registry.

```bash
docker pull bitnami/tomcat:[TAG]
```

If you wish, you can also build the image yourself.

```bash
docker build -t bitnami/tomcat:latest https://github.com/bitnami/bitnami-docker-tomcat.git
```

# Persisting your Tomcat configurations and deployments

If you remove the container all your Tomcat configurations and deployments will be lost. To avoid this you should mount a volume that will persist even after the container is removed.

**Note!**
If you have already started using your Tomcat deployment, follow the steps on
[backing up](#backing-up-your-container) and [restoring](#restoring-a-backup) to pull the data from your running container down to your host.

The image exposes a volume at `/bitnami/tomcat` for the Tomcat configurations and application deployments. For persistence you can mount a directory at this location from your host. If the mounted directory is empty, it will be initialized on the first run.

```bash
docker run -v /path/to/tomcat-persistence:/bitnami/tomcat bitnami/tomcat:latest
```

or using Docker Compose:

```yaml
version: '2'

services:
  tomcat:
    image: 'bitnami/tomcat:latest'
    ports:
      - '8080:8080'
    volumes:
      - /path/to/tomcat-persistence:/bitnami/tomcat
```

# Deploying web applications on Tomcat

The `/bitnami/tomcat/data` directory is configured as the Tomcat webapps deployment directory. At this location, you either copy a so-called *exploded web application*, i.e. non-compressed, or a compressed web application resource (`.WAR`) file and it will automatically be deployed by Tomcat.

Additionally a helper symlink `/app` is present that points to the webapps deployment directory which enables us to deploy applications on a running Tomcat instance by simply doing:

```bash
docker cp /path/to/app.war tomcat:/app
```

**Note!**
You can also deploy web applications on a running Tomcat instance using the Tomcat management interface.

**Further Reading:**

  - [Tomcat Web Application Deployment](https://tomcat.apache.org/tomcat-7.0-doc/deployer-howto.html)

# Accessing your Tomcat server from the host

To access your web server from your host machine you can ask Docker to map a random port on your host to port `8080` exposed in the container.

```bash
docker run --name tomcat -P bitnami/tomcat:latest
```

Run `docker port` to determine the random ports Docker assigned.

```bash
$ docker port tomcat
8080/tcp -> 0.0.0.0:32768
```

You can also manually specify the ports you want forwarded from your host to the container.

```bash
docker run -p 8080:8080 bitnami/tomcat:latest
```

Access your web server in the browser by navigating to [http://localhost:8080](http://localhost:8080/).

# Configuration

## Environment variables

The Tomcat instance can be customized by specifying environment variables on the first run. The following environment values are provided to custom Tomcat:

- `TOMCAT_SHUTDOWN_PORT`: Tomcat shutdown port. Default: **8005**
- `TOMCAT_HTTP_PORT`: Tomcat HTTP port. Default: **8080**
- `TOMCAT_AJP_PORT`: Tomcat AJP port. Default: **8009**
- `JAVA_HOME`: Java home directory.
- `JAVA_OPTS`: Tomcat java settings. Default: `-Djava.awt.headless=true -XX:+UseG1GC -Dfile.encoding=UTF-8 `
- `TOMCAT_HOME`: Tomcat user's home directory. Default: **/home/tomcat**
- `TOMCAT_USERNAME`: Tomcat user. Default: **user**
- `TOMCAT_PASSWORD`: Tomcat password.
- `TOMCAT_ALLOW_REMOTE_MANAGEMENT`: Allow to connect to manager applications from remote addresses. Valid values are *0* and *1*. Default: **0**

### Creating a custom user

By default, a management user named `user` is created and is not assigned a password. Passing the `TOMCAT_PASSWORD` environment variable when running the image for the first time will set the password of this user to the value of `TOMCAT_PASSWORD`.

Additionally you can specify a user name for the management user using the `TOMCAT_USERNAME` environment variable. When not specified, the `TOMCAT_PASSWORD` configuration is applied on the default user (`user`).

### Specifying Environment variables using Docker Compose

```yaml
version: '2'

services:
  tomcat:
    image: 'bitnami/tomcat:latest'
    ports:
      - '8080:8080'
    environment:
      - TOMCAT_USERNAME=my_user
      - TOMCAT_PASSWORD=my_password
```

### Specifying Environment variables on the Docker command line

```bash
docker run --name tomcat \
  -e TOMCAT_USERNAME=my_user \
  -e TOMCAT_PASSWORD=my_password \
  bitnami/tomcat:latest
```

## Configuration files

This image looks for Tomcat configuration files in `/bitnami/tomcat/conf`. You may recall from the [persisting your tomcat configurations and deployments](#persisting-your-tomcat-configurations-and-deployments) section, `/bitnami/tomcat` is the path to the persistence volume.

Create a directory named `conf/` at this location with your own configuration, or the default configuration will be copied on the first run which can be customized later.

### Step 1: Run the Tomcat image

Run the Tomcat image, mounting a directory from your host.

```bash
docker run --name tomcat -v /path/to/tomcat-persistence:/bitnami/tomcat bitnami/tomcat:latest
```

or using Docker Compose:

```yaml
version: '2'

services:
  tomcat:
    image: 'bitnami/tomcat:latest'
    ports:
      - '8080:8080'
    volumes:
      - /path/to/tomcat-persistence:/bitnami/tomcat
```

### Step 2: Edit the configuration

Edit the configuration on your host using your favorite editor.

eg.

```bash
vim /path/to/tomcat-persistence/conf/server.xml
```

### Step 3: Restart Tomcat

After changing the configuration, restart your Tomcat container for the changes to take effect.

```bash
docker restart tomcat
```

or using Docker Compose:

```bash
docker-compose restart tomcat
```

**Further Reading:**

  - [Tomcat 7 Configuration Reference](https://tomcat.apache.org/tomcat-7.0-doc/config/index.html)

# Logging

The Bitnami Tomcat Docker image sends the container logs to the `stdout`. To view the logs:

```bash
docker logs tomcat
```

or using Docker Compose:

```bash
docker-compose logs tomcat
```

You can configure the containers [logging driver](https://docs.docker.com/engine/admin/logging/overview/) using the `--log-driver` option if you wish to consume the container logs differently. In the default configuration docker uses the `json-file` driver.

# Maintenance

## Backing up your container

To backup your configuration and logs, follow these simple steps:

### Step 1: Stop the currently running container

```bash
docker stop tomcat
```

or using Docker Compose:

```bash
docker-compose stop tomcat
```

### Step 2: Run the backup command

We need to mount two volumes in a container we will use to create the backup: a directory on your host to store the backup in, and the volumes from the container we just stopped so we can access the data.

```bash
docker run --rm -v /path/to/tomcat-backups:/backups --volumes-from tomcat busybox \
  cp -a /bitnami/tomcat /backups/latest
```

or using Docker Compose:

```bash
docker run --rm -v /path/to/tomcat-backups:/backups --volumes-from `docker-compose ps -q tomcat` busybox \
  cp -a /bitnami/tomcat /backups/latest
```

## Restoring a backup

Restoring a backup is as simple as mounting the backup as volumes in the container.

```bash
docker run -v /path/to/tomcat-backups/latest:/bitnami/tomcat bitnami/tomcat:latest
```

or using Docker Compose:

```yaml
version: '2'

services:
  tomcat:
    image: 'bitnami/tomcat:latest'
    ports:
      - '8080:8080'
    volumes:
      - /path/to/tomcat-backups/latest:/bitnami/tomcat
```

## Upgrade this image

Bitnami provides up-to-date versions of Tomcat, including security patches, soon after they are made upstream. We recommend that you follow these steps to upgrade your container.

### Step 1: Get the updated image

```bash
docker pull bitnami/tomcat:latest
```

or if you're using Docker Compose, update the value of the image property to
`bitnami/tomcat:latest`.

### Step 2: Stop and backup the currently running container

Before continuing, you should backup your container's configuration and logs.

Follow the steps on [creating a backup](#backing-up-your-container).

### Step 3: Remove the currently running container

```bash
docker rm -v tomcat
```

or using Docker Compose:

```bash
docker-compose rm -v tomcat
```

### Step 4: Run the new image

Re-create your container from the new image, [restoring your backup](#restoring-a-backup) if necessary.

```bash
docker run --name tomcat bitnami/tomcat:latest
```

or using Docker Compose:

```bash
docker-compose start tomcat
```

# Notable Changes

## 8.0.35-r3

- `TOMCAT_USER` parameter has been renamed to `TOMCAT_USERNAME`.

## 8.0.35-r0

- All volumes have been merged at `/bitnami/tomcat`. Now you only need to mount a single volume at `/bitnami/tomcat` for persistence.
- The logs are always sent to the `stdout` and are no longer collected in the volume.

# Contributing

We'd love for you to contribute to this container. You can request new features by creating an [issue](https://github.com/bitnami/bitnami-docker-tomcat/issues), or submit a [pull request](https://github.com/bitnami/bitnami-docker-tomcat/pulls) with your contribution.

# Issues

If you encountered a problem running this container, you can file an [issue](https://github.com/bitnami/bitnami-docker-tomcat/issues). For us to provide better support, be sure to include the following information in your issue:

- Host OS and version
- Docker version (`docker version`)
- Output of `docker info`
- Version of this container (`echo $BITNAMI_IMAGE_VERSION` inside the container)
- The command you used to run the container, and any relevant output you saw (masking any sensitive information)

# Community

Most real time communication happens in the `#containers` channel at [bitnami-oss.slack.com](http://bitnami-oss.slack.com); you can sign up at [slack.oss.bitnami.com](http://slack.oss.bitnami.com).

Discussions are archived at [bitnami-oss.slackarchive.io](https://bitnami-oss.slackarchive.io).

# License

Copyright (c) 2015-2016 Bitnami

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
