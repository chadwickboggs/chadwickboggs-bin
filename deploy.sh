#!/usr/bin/env bash

#cp $@ target/*.war $CATALINA_HOME/webapps/.
lspf "{} -name '*.war'" | parallel cp $@ "{}" $CATALINA_HOME/webapps/.

