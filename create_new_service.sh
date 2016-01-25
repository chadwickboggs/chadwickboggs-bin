#!/bin/sh
microservice_function_name_default='SomeFunction'
read -p "Enter the CamelCase name of the microservice function [$microservice_function_name_default]?: " microservice_function_name_input
if [ ! -z $microservice_function_name_input ]
then
    microservice_function_name=$microservice_function_name_input
else
    microservice_function_name=$microservice_function_name_default
fi
 
echo "microservice function name = $microservice_function_name"
microservice_function_name_lower=$(echo $microservice_function_name | tr '[:upper:]' '[:lower:]')
echo "microservice function name (lower case) = $microservice_function_name_lower"
microservice_middle_project_dir="${microservice_function_name_lower}-middle"
echo "middle project output directory = $microservice_middle_project_dir"
microservice_edge_project_dir="${microservice_function_name_lower}-edge"
echo "edge project directory = $microservice_edge_project_dir"
microservice_client_project_dir="${microservice_function_name_lower}-client"
echo "client project directory = $microservice_client_project_dir"
 
middle_params="-DarchetypeGroupId=com.charter.aesd"
middle_params="$middle_params -DarchetypeArtifactId=microservice-middle-archetype"
middle_params="$middle_params -DarchetypeVersion=1.5.9"
middle_params="$middle_params -DgroupId=groupid.is.not.used.anywhere"
middle_params="$middle_params -DartifactId=$microservice_middle_project_dir"
middle_params="$middle_params -Dversion=0.1.0-SNAPSHOT"
middle_params="$middle_params -Dpackage=com.charter.aesd"
middle_params="$middle_params -DgroupIdSuffix=$microservice_function_name_lower"
middle_params="$middle_params -DincludeGitIgnoreFile=.gitignore"
middle_params="$middle_params -Dmiddle-service-name-camelcase=$microservice_function_name"
 
echo "Generating 'middle' project using params: $middle_params"
mvn -e archetype:generate -DinteractiveMode=false $middle_params
 
 
edge_params="-DarchetypeGroupId=com.charter.aesd"
edge_params="$edge_params -DarchetypeArtifactId=microservice-edge-archetype"
edge_params="$edge_params -DarchetypeVersion=1.4.0"
edge_params="$edge_params -DgroupId=groupid.is.not.used.anywhere"
edge_params="$edge_params -DartifactId=$microservice_edge_project_dir"
edge_params="$edge_params -Dversion=0.1.0-SNAPSHOT"
edge_params="$edge_params -Dpackage=com.charter.aesd"
edge_params="$edge_params -DgroupIdSuffix=$microservice_function_name_lower"
edge_params="$edge_params -DincludeGitIgnoreFile=.gitignore"
edge_params="$edge_params -Dedge-service-name-camelcase=$microservice_function_name"
 
echo "Generating 'edge' project using params: $edge_params"
mvn -e archetype:generate -DinteractiveMode=false $edge_params
 
 
client_params="-DarchetypeGroupId=com.charter.aesd"
client_params="$client_params -DarchetypeArtifactId=microservice-client-archetype"
client_params="$client_params -DarchetypeVersion=1.1.0"
client_params="$client_params -DgroupId=groupid.is.not.used.anywhere"
client_params="$client_params -DartifactId=$microservice_client_project_dir"
client_params="$client_params -Dversion=0.1.0-SNAPSHOT"
client_params="$client_params -Dpackage=com.charter.aesd"
client_params="$client_params -DgroupIdSuffix=$microservice_function_name_lower"
client_params="$client_params -DincludeGitIgnoreFile=.gitignore"
client_params="$client_params -Dclient-name-camelcase=$microservice_function_name"
 
echo "Generating 'client' project using params: $client_params"
mvn -e archetype:generate -DinteractiveMode=false $client_params
