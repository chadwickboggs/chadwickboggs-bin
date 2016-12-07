#!/usr/bin/env bash

export CATALINA_OPTS_ENV=$1

export CATALINA_OPTS_JVM="-Xms1g -Xmx2g -server -XX:NewSize=256m -XX:MaxNewSize=512m -XX:+DisableExplicitGC -Dfile.encoding=UTF-8"
[[ $(java_major_version.sh) < 8 ]] && CATALINA_OPTS_JVM="-XX:PermSize=512m -XX:MaxPermSize=256m ${CATALINA_OPTS_JVM}"

export CATALINA_OPTS_AWT="-Djava.awt.headless=true"
export CATALINA_OPTS_JMX="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9095 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.password.file=conf/jmxremote.password -Dcom.sun.management.jmxremote.access.file=conf/jmxremote.access"
export CATALINA_OPTS_ARCHAIUS="-Darchaius.deployment.region=US_WEST_2 -Darchaius.deployment.domain=default"
export CATALINA_OPTS_NFOSS="-Dcom.netflix.karyon.eureka.datacenter.type=Cloud -Deureka.datacenter=default -Dovation.app.properties.location=ws-config/ovation/ovation-local-overlay.properties"
export CATALINA_OPTS_APP="-Dapplication.home=${HOME} -DlocalLogging=true -Daesd.archaius.dynamic.url=classpath:///config.properties"

#if [[ "${CATALINA_OPTS_ENV}" -ne "UNSET" ]]; then
	export CATALINA_OPTS_LOGBACK_ENV="-Dlogback-lib.${CATALINA_OPTS_ENV}=filesystem"
	export CATALINA_OPTS_ARCHAIUS_ENV="-Darchaius.deployment.environment=${CATALINA_OPTS_ENV}"
	export CATALINA_OPTS_NFOSS_ENV="-Deureka.environment=${CATALINA_OPTS_ENV}"
#fi

export CATALINA_OPTS_CHARTER="${CATALINA_OPTS_JVM} ${CATALINA_OPTS_AWT} ${CATALINA_OPTS_JMX} ${CATALINA_OPTS_ARCHAIUS} ${CATALINA_OPTS_NFOSS} ${CATALINA_OPTS_APP} ${CATALINA_OPTS_LOGBACK_ENV} ${CATALINA_OPTS_ARCHAIUS_ENV} ${CATALINA_OPTS_NFOSS_ENV}"
export CATALINA_OPTS="${CATALINA_OPTS_CHARTER}"

echo $CATALINA_OPTS
