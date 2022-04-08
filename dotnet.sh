#!/bin/bash
# NOTE: This script build does a full production release build a .NET application.
# INPUT:
#   $1: Directory path of the Git repository.
#   $2: The file path of the .NET solution (.sln) file or C# project (.csproj) file.
#   $3: The access token to upload NuGet packages to myget.org. Leave empty to prevent uploading NuGet packages to myget.org.
#   $4: The access token to upload NuGet packages to nuget.org. Leave empty to prevent uploading NuGet packages to nuget.org.
# OUTPUT: The built .NET application on disk.

echo "Entered: dotnet.sh"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

function exit_if_last_command_failed() {
    error=$?
    if [ $error -ne 0 ]; then
        echo "Last command failed: $error"
        exit $error
    fi
}

if [[ ! -z "$1" ]]; then
    GIT_DIRECTORY_PATH="$1"
else
    echo "Please pass the directory path to the Git repository as the first parameter."
    exit 1
fi

if [[ ! -z "$2" ]]; then
    DOTNET_APP_SOLUTION_OR_PROJECT_FILE_PATH="$2"
else
    echo "Please pass the file path of the .NET solution (.sln) file or C# project (.csproj) file as the second argument."
    exit 1
fi

if [[ ! -z "$3" ]]; then
    DOTNET_APP_API_KEY_NMYGET="$3"
else
    DOTNET_APP_API_KEY_NMYGET=""
fi

if [[ ! -z "$4" ]]; then
    DOTNET_APP_API_KEY_NUGET="$4"
else
    DOTNET_APP_API_KEY_NUGET=""
fi

source "$DIR/scripts/clean.sh" $DOTNET_APP_SOLUTION_OR_PROJECT_FILE_PATH
exit_if_last_command_failed

source "$DIR/scripts/version.sh" $GIT_DIRECTORY_PATH
exit_if_last_command_failed

source "$DIR/scripts/build.sh" $DOTNET_APP_SOLUTION_OR_PROJECT_FILE_PATH $DOTNET_APP_VERSION
exit_if_last_command_failed

source "$DIR/scripts/test.sh" $DOTNET_APP_SOLUTION_OR_PROJECT_FILE_PATH
exit_if_last_command_failed

source "$DIR/scripts/pack.sh" $DOTNET_APP_SOLUTION_OR_PROJECT_FILE_PATH $DOTNET_APP_VERSION
exit_if_last_command_failed

source "$DIR/scripts/upload_nuget_packages.sh" $GIT_DIRECTORY_PATH $DOTNET_APP_API_KEY_MYGET $DOTNET_APP_API_KEY_NUGET
exit_if_last_command_failed

echo "Exit: dotnet.sh"