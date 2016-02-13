#!/usr/bin/env bash

uservice_function_name='SomeFunction'
read -p "Enter the CamelCase name of the uservice function [$uservice_function_name]: " input
[[ -n "$input" ]] && uservice_function_name=$input

uservice_middle_archetype_version='RELEASE'
read -p "Enter uservice middle archetype version [$uservice_middle_archetype_version]: " input
[[ -n "$input" ]] && uservice_middle_archetype_version=$input

uservice_edge_archetype_version='RELEASE'
read -p "Enter uservice edge archetype version [$uservice_edge_archetype_version]: " input
[[ -n "$input" ]] && uservice_edge_archetype_version=$input

uservice_client_archetype_version='RELEASE'
read -p "Enter uservice client archetype version [$uservice_client_archetype_version]: " input
[[ -n "$input" ]] && uservice_client_archetype_version=$input

#echo "uservice_function_name = \"$uservice_function_name\""
#echo "uservice_middle_archetype_version = \"$uservice_middle_archetype_version\""
#echo "uservice_edge_archetype_version = \"$uservice_edge_archetype_version\""
#echo "uservice_client_archetype_version = \"$uservice_client_archetype_version\""
 
echo "uservice function name = $uservice_function_name"
uservice_function_name_lower=$(echo $uservice_function_name | tr '[:upper:]' '[:lower:]')
echo "uservice function name (lower case) = $uservice_function_name_lower"
uservice_middle_project_dir="${uservice_function_name_lower}-middle"
echo "middle project output directory = $uservice_middle_project_dir"
uservice_edge_project_dir="${uservice_function_name_lower}-edge"
echo "edge project directory = $uservice_edge_project_dir"
uservice_client_project_dir="${uservice_function_name_lower}-client"
echo "client project directory = $uservice_client_project_dir"
 
middle_params="-DarchetypeGroupId=com.charter.aesd"
middle_params="$middle_params -DarchetypeArtifactId=microservice-middle-archetype"
middle_params="$middle_params -DarchetypeVersion=$uservice_middle_archetype_version"
middle_params="$middle_params -DgroupId=groupid.is.not.used.anywhere"
middle_params="$middle_params -DartifactId=$uservice_middle_project_dir"
middle_params="$middle_params -Dversion=0.1.0-SNAPSHOT"
middle_params="$middle_params -Dpackage=com.charter.aesd"
middle_params="$middle_params -DgroupIdSuffix=$uservice_function_name_lower"
middle_params="$middle_params -DincludeGitIgnoreFile=.gitignore"
middle_params="$middle_params -Dmiddle-service-name-camelcase=$uservice_function_name"
 
echo "Generating 'middle' project using params: $middle_params"
mvn -e archetype:generate -DinteractiveMode=false $middle_params
 
 
edge_params="-DarchetypeGroupId=com.charter.aesd"
edge_params="$edge_params -DarchetypeArtifactId=microservice-edge-archetype"
edge_params="$edge_params -DarchetypeVersion=$uservice_edge_archetype_version"
edge_params="$edge_params -DgroupId=groupid.is.not.used.anywhere"
edge_params="$edge_params -DartifactId=$uservice_edge_project_dir"
edge_params="$edge_params -Dversion=0.1.0-SNAPSHOT"
edge_params="$edge_params -Dpackage=com.charter.aesd"
edge_params="$edge_params -DgroupIdSuffix=$uservice_function_name_lower"
edge_params="$edge_params -DincludeGitIgnoreFile=.gitignore"
edge_params="$edge_params -Dedge-service-name-camelcase=$uservice_function_name"
 
echo "Generating 'edge' project using params: $edge_params"
mvn -e archetype:generate -DinteractiveMode=false $edge_params
 
 
client_params="-DarchetypeGroupId=com.charter.aesd"
client_params="$client_params -DarchetypeArtifactId=microservice-client-archetype"
client_params="$client_params -DarchetypeVersion=$uservice_client_archetype_version"
client_params="$client_params -DgroupId=groupid.is.not.used.anywhere"
client_params="$client_params -DartifactId=$uservice_client_project_dir"
client_params="$client_params -Dversion=0.1.0-SNAPSHOT"
client_params="$client_params -Dpackage=com.charter.aesd"
client_params="$client_params -DgroupIdSuffix=$uservice_function_name_lower"
client_params="$client_params -DincludeGitIgnoreFile=.gitignore"
client_params="$client_params -Dclient-name-camelcase=$uservice_function_name"
 
echo "Generating 'client' project using params: $client_params"
mvn -e archetype:generate -DinteractiveMode=false $client_params

