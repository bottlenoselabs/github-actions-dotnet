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

uname_str="$(uname -a)"
case "${uname_str}" in
    *Microsoft*)    TARGET_BUILD_OS="windows";;
    *microsoft*)    TARGET_BUILD_OS="windows";;
    Linux*)         TARGET_BUILD_OS="linux";;
    Darwin*)        TARGET_BUILD_OS="macos";;
    CYGWIN*)        TARGET_BUILD_OS="linux";;
    MINGW*)         TARGET_BUILD_OS="windows";;
    *Msys)          TARGET_BUILD_OS="windows";;
    *)              TARGET_BUILD_OS="UNKNOWN:${uname_str}"
esac

if [[ "$TARGET_BUILD_OS" == "windows" ]]; then
    # GitVersion for Windows is broken; it only returns a JSON result no matter what... Have to parse value out of JSON using Python: https://stackoverflow.com/questions/1955505/parsing-json-with-unix-tools
    ~/.dotnet/tools/dotnet-gitversion $1 /output json >> $1/version.json
    DOTNET_APP_VERSION=`python -c "import sys, json; print(json.load(open(sys.argv[1]))['NuGetVersionV2'])" $1/version.json`
    rm -rf $1/version.json
else
    DOTNET_APP_VERSION=`~/.dotnet/tools/dotnet-gitversion /output json /showvariable NuGetVersionV2`
fi    

echo "Getting SemVer2 for the Git repository '$1': Finished. Version: '$DOTNET_APP_VERSION'."

echo "Exited: version.sh $1"