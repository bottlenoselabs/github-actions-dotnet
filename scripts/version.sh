#!/bin/bash
# NOTE: This script calculates a Semantic Version 2.0 (SemVer2) for a target Git repository on disk.
# INPUT:
#   $1: Directory path of the Git repository.
# OUTPUT: Text file `version.txt` with SemVer2 value.

echo "Entered: version.sh $1"

echo "Installing .NET GitVersion command line tool..."
dotnet tool install --global GitVersion.Tool
if [ $? -eq 0 ]; then
    echo "Installing .NET GitVersion command line tool: Success."
else
    echo "Installing .NET GitVersion command line tool: Already installed."
fi

echo "Getting SemVer2 for the Git repository '$1'..."
DOTNET_APP_VERSION=$(~/.dotnet/tools/dotnet-gitversion $1 /output json /showvariable NuGetVersionV2)
echo "Getting SemVer2 for the Git repository '$1': Finished. Verion: '$DOTNET_APP_VERSION'."

echo "Exited: version.sh $1"