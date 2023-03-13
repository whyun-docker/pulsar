#!/bin/bash
set -e

export PULSAR_VERSION=2.11.0
TAG_LATEST=yunnysunny/pulsar:latest
TAG_CURRENT=yunnysunny/pulsar:${PULSAR_VERSION}

docker pull yunnysunny/jre:latest
docker build . -f ./Dockerfile -t ${TAG_LATEST} -t ${TAG_CURRENT} --build-arg PULSAR_VERSION=${PULSAR_VERSION}
if [ "$NEED_PUSH" = "1" ] ; then
    docker push ${TAG_LATEST}
    docker push ${TAG_CURRENT}
fi