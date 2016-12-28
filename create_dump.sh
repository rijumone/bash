#!/bin/sh

DIR=`date +%m%d%y`
DEST=~/db_dump/$DIR
# DEST=~/db_dump
mkdir $DEST
mongodump -h 52.66.108.250 -d tracking -o $DEST
mongo tracking --eval "db.dropDatabase()"
mongorestore $DEST/