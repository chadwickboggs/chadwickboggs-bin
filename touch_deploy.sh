#!/usr/bin/env bash

war_filename="$(pwd|sed 's/.*\/\([^\/]\+\)$/\1/'|tr -d -).war"
deployed_filename="$CATALINA_HOME"/webapps/"${war_filename}"

echo "	Touching deployed WAR file.  Filename: \"${deployed_filename}\""
touch "${deployed_filename}"
echo "	Done touching deployed WAR file."

