#!/usr/bin/env bash

sleep_time=7
script_path=$(dirname $0)

"${script_path}"/undeploy.sh

echo "	Sleeping for ${sleep_time} seconds..."
sleep ${sleep_time}
echo "	Done sleeping."

echo "	Deploying WAR file."
cp -v target/*.war "$CATALINA_HOME"/webapps/.
echo "	Done deploying WAR file."

