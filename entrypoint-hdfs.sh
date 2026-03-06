#!/bin/bash
set -e # Exit on Error

# Default values if not provide
export NAMENODE_HOST=${NAMENODE_HOST:-namenode}
export HDFS_REPLICATION_FACTOR=${HDFS_REPLICATION_FACTOR:-2}

# Substitute environment variables into config templates
envsubst < ${HADOOP_CONF_DIR}/core-site.xml.template > ${HADOOP_CONF_DIR}/core-site.xml
envsubst < ${HADOOP_CONF_DIR}/hdfs-site.xml.template > ${HADOOP_CONF_DIR}/hdfs-site.xml

if [ "$NODE_TYPE" = "namenode" ]; then
    # Format only if NameNode directory is empty
    if [ ! -d "/hadoop/dfs/name/current" ]; then
        echo "Formatting NameNode..."
        hdfs namenode -format -force
    fi
    echo "Starting NameNode..."
    hdfs namenode
elif [ "$NODE_TYPE" = "datanode" ]; then
    echo "Starting DataNode..."
    hdfs datanode
else
    echo "Error: NODE_TYPE must be 'namenode' or 'datanode'"
    exit 1
fi