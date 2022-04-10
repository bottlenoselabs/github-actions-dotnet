#!/bin/bash
# NOTE: This script calculates a Semantic Version 2.0 (SemVer2) for a target Git repository on disk.
# INPUT:
#   $1: Directory path of the Git repository.
# OUTPUT: Text file `version.txt` with SemVer2 value.

echo "Entered: version.sh"

echo "Searching for GitVersion installed as a .NET tool..."
DOTNET_GITVERSION_TOOL_VERSION="$(dotnet tool list --global | grep "gitversion.tool" | tr -s " " "\n" | sed -n 2p)"
if [ $? -ne 0 ]; then
    echo "Searching for GitVersion installed as a .NET tool: Failed."
    exit 1
fi

if [[ -z $DOTNET_GITVERSION_TOOL_VERSION ]]; then
    echo "Did not find GitVersion installed as a .NET tool. Installing..."
    dotnet tool install --global GitVersion.Tool
    if [ $? -eq 0 ]; then
        echo "Installing .NET GitVersion command line tool: Success."
    else
        echo "Installing .NET GitVersion command line tool: Failed."
        exit 1
    fi
else
    echo "Searching for GitVersion installed as a .NET tool: Success. GitVersion: $DOTNET_GITVERSION_TOOL_VERSION"
fi

echo "Getting SemVer2 for the Git repository '$1'..."
DOTNET_APP_VERSION=$(~/.dotnet/tools/dotnet-gitversion "$GIT_DIRECTORY_PATH" /output json /showvariable NuGetVersionV2)
echo "Getting SemVer2 for the Git repository '$1': Finished. The version is '$DOTNET_APP_VERSION'."

echo "Exited: version.sh"