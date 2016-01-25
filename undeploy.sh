#!/usr/bin/env bash

war_filename="$(pwd|sed 's/.*\/\([^\/]\+\)$/\1/'|tr -d -).war"
deployed_filename="$CATALINA_HOME"/webapps/"${war_filename}"

echo "	Deleting deployed WAR file."
rm -v "${deployed_filename}"
echo "	Done deleting deployed WAR file."

