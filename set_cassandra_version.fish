#!/usr/bin/env fish

set version "2.1"

if [ $argv.size > 0 ]
	set version $argv[1]
end

echo "Setting Cassandra version to $version."

set -x CASSANDRA_HOME /opt/dev/apache/cassandra/$version
set -x PATH $CASSANDRA_HOME/bin $PATH

