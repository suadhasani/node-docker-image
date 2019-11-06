#!/bin/bash

/usr/bin/python3 "/waves-node/starter.py"
echo "Node is starting..."
mkdir -p /waves/data
gc="-XX:+UseShenandoahGC"
if [[ $WAVES_ENABLE_SHENANDOAH_GC != "yes" ]]; then gc="" fi
java -Dlogback.stdout.level="${WAVES_LOG_LEVEL}" "-XX:+ExitOnOutOfMemoryError" "-XX:+UnlockExperimentalVMOptions" $gc "-Xmx${WAVES_HEAP_SIZE}" -jar "/waves-node/waves-all-${WAVES_VERSION}.jar" $WAVES_CONFIG_FILE