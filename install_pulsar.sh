#!/bin/bash
#title          :pulsar_install.sh
#description    :The script to install pulsar
#author         :Motty Cohen
#date           :05-Feb-2015
#usage          :/bin/bash install_pulsar.sh

#PULSAR_VERSION=$1
PULSAR_FILENAME=apache-pulsar-$PULSAR_VERSION
PULSAR_ARCHIVE_NAME=${PULSAR_FILENAME}-bin.tar.gz


PULSAR_DOWNLOAD_ADDRESS=http://10.8.19.100/download/$PULSAR_ARCHIVE_NAME

INSTALL_DIR=/opt
PULSAR_FULL_DIR=$INSTALL_DIR/$PULSAR_FILENAME
PULSAR_DIR=$INSTALL_DIR/pulsar
PULSAR_SERVICE=pulsar

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root."
   exit 1
fi

echo "Downloading: $PULSAR_DOWNLOAD_ADDRESS..."
[ -e "$PULSAR_ARCHIVE_NAME" ] && echo 'pulsar archive already exists.'
if [ ! -e "$PULSAR_ARCHIVE_NAME" ]; then
  wget -q $PULSAR_DOWNLOAD_ADDRESS
  if [ $? -ne 0 ]; then
    echo "Not possible to download pulsar."
    exit 1
  fi
fi

echo "Cleaning up..."
rm -f "$PULSAR_DIR"
rm -rf "$PULSAR_FULL_DIR"
rm -rf "/var/run/$PULSAR_SERVICE/"
rm -f "/etc/init.d/$PULSAR_SERVICE"

echo "Installation to $PULSAR_FULL_DIR ..."
mkdir $PULSAR_FULL_DIR
tar -zxvf $PULSAR_ARCHIVE_NAME -C $INSTALL_DIR

echo "Creating symbolic link: to $PULSAR_DIR ..."
ln -s $PULSAR_FULL_DIR/ $PULSAR_DIR


echo "Cleaning archive..."
rm -f "$PULSAR_ARCHIVE_NAME"


