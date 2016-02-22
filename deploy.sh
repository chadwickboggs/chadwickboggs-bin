#!/usr/bin/env bash

echo "[$(now)] Deploying..."

#cp $@ target/*.war $CATALINA_HOME/webapps/.
lspf "{} -name '*.war'" | parallel cp $@ "{}" $CATALINA_HOME/webapps/.

exit_code=$?

echo "[$(now)] Done deploying."

exit ${exit_code}

