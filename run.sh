#!/bin/bash
docker rm -f filecloud
docker run -itd \
    --name=filecloud \
    -p 8080:8080 \
    -p 8000:8000 \
    -v ${PWD}/src:/code/src \
    -v ${PWD}/filemanager:/code/filemanager \
    -v ${PWD}/djvuetut:/code/djvuetut \
    -v ${PWD}/entrypoint.sh:/code/entrypoint.sh \
    -v ${PWD}/media:/code/media \
    filemanager