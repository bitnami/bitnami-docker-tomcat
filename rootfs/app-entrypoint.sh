#!/bin/bash
set -e

if [[ "$1" == "harpoon" && "$2" == "start" ]]; then
  status=`harpoon inspect $BITNAMI_APP_NAME`
  if [[ "$status" == *'"lifecycle": "unpacked"'* ]]; then
    harpoon initialize $BITNAMI_APP_NAME --username ${TOMCAT_USER:-manager} --password ${TOMCAT_PASSWORD:-password}
  fi

  chown -R $BITNAMI_APP_USER: $BITNAMI_APP_DIR/webapps || true
fi

exec /entrypoint.sh "$@"
