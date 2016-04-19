FROM gcr.io/stacksmith-images/ubuntu:14.04-r05
MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_APP_NAME=tomcat \
    BITNAMI_APP_VERSION=8.0.30-0 \
    BITNAMI_APP_CHECKSUM=0279e1dcbb0bb8077090dc6b727929f1665a1ecd6f8c811527614addd47b06fd \
    BITNAMI_APP_USER=tomcat

# Install supporting modules
RUN bitnami-pkg install java-1.8.0_71-0 --checksum f61dd50fc207e619cec30d696890694d453f4ee861e25e05c101222514f52df6
ENV PATH=/opt/bitnami/java/bin:$PATH

# Install application
RUN bitnami-pkg unpack $BITNAMI_APP_NAME-$BITNAMI_APP_VERSION --checksum $BITNAMI_APP_CHECKSUM
ENV PATH=/opt/bitnami/$BITNAMI_APP_NAME/bin:$PATH

# Setting entry point
COPY rootfs/ /
ENTRYPOINT ["/app-entrypoint.sh"]
CMD ["harpoon", "start", "--foreground", "tomcat"]

# Exposing ports
EXPOSE 8080

VOLUME ["/bitnami/$BITNAMI_APP_NAME"]
