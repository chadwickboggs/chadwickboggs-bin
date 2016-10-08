#!/usr/bin/env bash

echo "[$(now)] Undeploying..."

lspf -q "{} -name '*.war'" | grep -v cargo | parallel "basename {}" | parallel "rm $@ $CATALINA_HOME/webapps/{}"

exit_code=$?

echo "[$(now)] Done undeploying."

exit ${exit_code}

