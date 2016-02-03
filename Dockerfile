FROM bitnami/base-ubuntu:14.04-onbuild
MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_APP_NAME=tomcat \
    BITNAMI_APP_USER=tomcat \
    BITNAMI_APP_DAEMON=catalina.sh \
    BITNAMI_APP_VERSION=8.0.30-0 \
    BITNAMI_APP_OPTIONS="--username manager --password tomcat" \
    BITNAMI_APP_LANG=java \
    BITNAMI_APP_LANG_VERSION=1.8.0_65-0

ENV BITNAMI_APP_DIR=$BITNAMI_PREFIX/$BITNAMI_APP_NAME \
    BITNAMI_APP_VOL_PREFIX=/bitnami/$BITNAMI_APP_NAME

ENV PATH=$BITNAMI_APP_DIR/bin:$PATH

RUN $BITNAMI_PREFIX/install.sh

COPY rootfs/ /

EXPOSE 8080
VOLUME ["$BITNAMI_APP_VOL_PREFIX/conf", "$BITNAMI_APP_VOL_PREFIX/logs"]

ENTRYPOINT ["/entrypoint.sh"]
