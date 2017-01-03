#!/usr/bin/env bash

version="2.1"

if [[ $# > 0 ]]; then
	version="$1"
fi

echo "Setting Cassandra version to ${version}."

export CASSANDRA_HOME="/opt/dev/apache/cassandra/${version}"
export PATH="$CASSANDRA_HOME/bin $PATH"

