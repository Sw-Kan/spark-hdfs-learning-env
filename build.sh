#!/bin/bash

echo "build base image..."
docker buildx build -f Dockerfile.base -t ubuntu-base .

echo "build hadoop image..."
docker buildx build -f Dockerfile.hdfs -t myhadoop .

echo "build spark image..."
docker buildx build -f Dockerfile.spark -t myspark .