#!/bin/bash

if [ "$#" -ne 3 ]
then
  echo "Usage:"
  echo -e "\t$0 <POSTGRES_URI_SOURCE> <POSTGRES_URI_TARGET> <SCHEMA_NAME>\n"
  echo "Use the standard POSTGRE_URI format: postgresql://username:password@hostname:port/database"
  exit -1
fi

POSTGRES_URI_SOURCE="$1"
POSTGRES_URI_TARGET="$2"
SCHEMA_NAME="$3"

SAMPLE_CFG="
load database \n
  from $POSTGRES_URI_SOURCE \n
  into $POSTGRES_URI_TARGET \n
  with \n
    schema only, data only \n

  including only table names matching ~/./ in schema '$SCHEMA_NAME' \n
  ; \n
"

TMP_FILE="pgloader_$(date +%s)"
echo -e $SAMPLE_CFG > /tmp/$TMP_FILE

./build/bin/pgloader /tmp/$TMP_FILE
