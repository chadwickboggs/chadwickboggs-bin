#!/usr/bin/env bash

echo "[$(now)] Undeploying..."

war_filename="$(pwd|sed 's/.*\/\([^\/]\+\)$/\1/'|tr -d -).war"
deployed_filename="$CATALINA_HOME"/webapps/"${war_filename}"

lspf -q "{} -name '*.war'" | parallel "basename {}" | parallel rm $@ "$CATALINA_HOME/webapps/{}"

exit_code=$?

echo "[$(now)] Done undeploying."

exit ${exit_code}

