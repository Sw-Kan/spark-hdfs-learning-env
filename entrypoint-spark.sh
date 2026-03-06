#!/bin/bash

if [ -z "$SPARK_LOCAL_IP" ]; then
    export SPARK_LOCAL_IP=$(hostname)
fi

# Define the config files to process
CONFIG_FILES=("spark-env.sh" "spark-defaults.conf" )

for FILE in "${CONFIG_FILES[@]}"; do
    if [ -f "${SPARK_CONF_DIR}/${FILE}.template" ]; then
        echo "Processing template: ${FILE}.template"
        # envsubst replaces $VARIABLE_NAME with actual ENV values
        envsubst < "${SPARK_CONF_DIR}/${FILE}.template" > "${SPARK_CONF_DIR}/${FILE}"
    fi
done

# Execute the command passed to docker run (e.g., spark-class, spark-shell)
exec "$@"