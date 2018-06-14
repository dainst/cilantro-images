#!/usr/bin/env bash

name=cilantro-convert-worker
tag=stable

docker image build -t ${name}:${tag} .
docker tag ${name}:${tag} dainst/${name}:${tag}
docker push dainst/${name}:${tag}