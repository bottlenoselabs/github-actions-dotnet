#!/bin/bash
# NOTE: This script uploads NuGet packages to feed.
# INPUT:
#   $1: Directory path of the Git repository.
#   $2: The access token to upload NuGet packages to myget.org. Leave empty to prevent uploading NuGet packages to myget.org.
#   $3: The access token to upload NuGet packages to nuget.org. Leave empty to prevent uploading NuGet packages to nuget.org.
# OUTPUT: Uploaded NuGet packages.

echo "Entered: upload_nuget_packages.sh"

if [[ ! -z "$1" ]]; then
    dotnet nuget push "$1/**/*.nupkg" --source https://www.myget.org/F/bottlenoselabs/api/v3/index.json --skip-duplicate --api-key $2
fi

if [[ ! -z "$2" ]]; then
    dotnet nuget push "$1/**/*.nupkg" --source https://api.nuget.org/v3/index.json --skip-duplicate --api-key $3
fi

echo "Exited: upload_nuget_packages.sh"