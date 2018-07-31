#!/bin/bash -e

if [ `id -u user` != `id -u` ]
then
  if [ `id -u` != 0 ]
  then
    usermod -u `id -u` user
    chown -R user /home/user
  fi
fi

#if directory empty
if [ -z "$(ls $DIRDST)" ]
then
  cp -a $DIRSRC/* $DIRDST/
fi

DIRSRC=/usr/local/src/iped/iped/resources/config/conf
DIRDST=/iped/conf
mkdir -p $DIRDST

ln -sf conf/IPEDConfig.txt $DIRDST/../IPEDConfig.txt
ln -sf conf/LocalConfig.txt $DIRDST/../LocalConfig.txt

exec "$@"
