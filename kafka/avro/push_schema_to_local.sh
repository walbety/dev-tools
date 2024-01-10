#!/usr/bin/env bash

echo "For more information please access https://docs.confluent.io/current/schema-registry/using.html"
REGISTRY_SERVER='http://localhost'

delete_schema(){
    if test -f "$1"; then
        curl -X DELETE -H "Content-Type: application/vnd.schemaregistry.v1+json" \
            --data '{"compatibility": "FULL"}' \
            $REGISTRY_SERVER:8081/subjects/$2
        echo ""
    fi
}

upload_schema(){
    if test -f "$1"; then
        content=`sed -e 's/\"/\\\"/g' "$1" |tr '\n' ' '`
        echo -e "\e[38;5;82mUploading $1\e[0m"
        curl -X POST -H "Content-Type: application/vnd.schemaregistry.v1+json" \
            --data '{"schema": "'"$content"'"}' \
            $REGISTRY_SERVER:8081/subjects/$2/versions
        curl -X PUT -H "Content-Type: application/vnd.schemaregistry.v1+json" \
            --data '{"compatibility": "FULL"}' \
            $REGISTRY_SERVER:8081/config/$2
        echo ""
    fi
}

### USER SAMPLE
upload_schema user.avsc user-value
