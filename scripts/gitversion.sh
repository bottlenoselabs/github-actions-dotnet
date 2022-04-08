#!/bin/bash

if [[ ! -z "$1" ]]; then
    GIT_DIRECTORY_PATH="$1"
else
    echo "Please pass the directory path to the Git repository as the first parameter."
    exit 1
fi

if [[ ! -z "$2" ]]; then
    GITVERSION_CONFIG_FILE_PATH="$2"
else
    GITVERSION_CONFIG_FILE_PATH=""
fi

VERSION=$(dotnet-gitversion "$GIT_DIRECTORY_PATH" /config "$GITVERSION_CONFIG_FILE_PATH" /output json /showvariable NuGetVersionV2)
echo $VERSION