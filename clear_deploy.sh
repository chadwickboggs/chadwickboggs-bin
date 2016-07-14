#!/usr/bin/env bash

echo "[$(now)] Deploying..."

#cp $@ target/*.war $CATALINA_HOME/webapps/.
lspf -q "{} -name '*.war'" | parallel "basename {}" | sed 's/\.war//' | parallel rm -r $@ "${CATALINA_HOME}/work/Catalina/localhost/{}" "${CATALINA_HOME}/webapps/{}" 

exit_code=$?

echo "[$(now)] Done deploying."

exit ${exit_code}

