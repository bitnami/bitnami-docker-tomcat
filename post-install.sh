#!/bin/bash
cd $BITNAMI_APP_DIR

# create user home
mkdir -m 0755 -p /home/${BITNAMI_APP_USER}
chown -R ${BITNAMI_APP_USER}: /home/${BITNAMI_APP_USER}

# move the default conf directory
mv conf conf.defaults

# move the default webapps directory
mv webapps webapps.defaults

# Create an empty webapps directory
mkdir webapps

# symlink mount points at root to install dir
ln -s $BITNAMI_APP_DIR/webapps /app
ln -s $BITNAMI_APP_DIR/conf $BITNAMI_APP_VOL_PREFIX/conf
ln -s $BITNAMI_APP_DIR/logs $BITNAMI_APP_VOL_PREFIX/logs
