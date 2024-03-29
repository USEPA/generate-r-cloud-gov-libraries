#!/bin/bash

#Make sure we get a command line parameter for the file
if [ $# -eq 0 ]
  then
    echo "Supply the location of the lib (e.g. /usr/lib/libgdal.so)"
    exit
fi

#Check that the file exists
if ! test -f "$1"; then
    echo "$1 does not exist"
    exit
fi

DIR=$(dirname "$1")
FILE=$(basename "$1")

cp -v $1 $TEMP_DIR

if [[ "$FILE" == *".so"* ]]; then
    ldd $1 | grep "=> /" | awk '{print $3}' | xargs -I '{}' cp -v '{}' r-lib
fi

echo "Complete: created $FILE_NAME containing the shared objects"
