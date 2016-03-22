FROM gcr.io/stacksmith-images/ubuntu:14.04-r05
MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_APP_NAME=tomcat \
    BITNAMI_APP_USER=tomcat \
    BITNAMI_APP_VERSION=8.0.30-0 \
    TOMCAT_PACKAGE_SHA256="0279e1dcbb0bb8077090dc6b727929f1665a1ecd6f8c811527614addd47b06fd" \
    BITNAMI_APP_LANG=java \
    BITNAMI_APP_LANG_VERSION=1.8.0_71-0 \
    JAVA_PACKAGE_SHA256="f61dd50fc207e619cec30d696890694d453f4ee861e25e05c101222514f52df6"

ENV BITNAMI_APP_DIR=/opt/bitnami/$BITNAMI_APP_NAME \
    BITNAMI_APP_VOL_PREFIX=/bitnami/$BITNAMI_APP_NAME

ENV PATH=$BITNAMI_APP_DIR/bin:$PATH

RUN bitnami-pkg install $BITNAMI_APP_LANG-$BITNAMI_APP_LANG_VERSION

RUN bitnami-pkg unpack $BITNAMI_APP_NAME-$BITNAMI_APP_VERSION

# these symlinks should be setup by harpoon at unpack
RUN mkdir -p $BITNAMI_APP_VOL_PREFIX && \
    ln -s $BITNAMI_APP_DIR/webapps /app && \
    ln -s $BITNAMI_APP_DIR/conf $BITNAMI_APP_VOL_PREFIX/conf && \
    ln -s $BITNAMI_APP_DIR/logs $BITNAMI_APP_VOL_PREFIX/logs

COPY rootfs/ /

EXPOSE 8080

ENTRYPOINT ["/app-entrypoint.sh"]
CMD ["harpoon", "start", "--foreground", "tomcat"]
