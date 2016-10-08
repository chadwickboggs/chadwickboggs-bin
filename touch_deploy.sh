#!/usr/bin/env bash

echo "[$(now)] Touching deployed WAR files."

lspf -q "{} -name '*.war'" | grep -v cargo | parallel "echo Touching $CATALINA_HOME/webapps/{/} && touch $CATALINA_HOME/webapps/{/}"

exit_code=$?

echo "[$(now)] Done touching deployed WAR files."

exit ${exit_code}

