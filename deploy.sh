#!/usr/bin/env bash

#cp -v target/*.war $CATALINA_HOME/webapps/.
lspf "{} -name '*.war'" | parallel cp -v "{}" $CATALINA_HOME/webapps/.

