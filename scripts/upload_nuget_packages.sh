#!/bin/bash
# NOTE: This script uploads NuGet packages to feed.
# INPUT:
#   $1: Directory path of the Git repository.
#   $2: The access token to upload NuGet packages to myget.org. Leave empty to prevent uploading NuGet packages to myget.org.
#   $3: The access token to upload NuGet packages to nuget.org. Leave empty to prevent uploading NuGet packages to nuget.org.
# OUTPUT: Uploaded NuGet packages.

echo "Entered: upload_nuget_packages.sh"

if [[ ! -z "$2" ]]; then
    echo "Uploading NuGet packages to myget.org..."
    dotnet nuget push "$1/**/*.nupkg" --source https://www.myget.org/F/bottlenoselabs/api/v3/index.json --skip-duplicate --api-key $2
    echo "Uploading NuGet packages to myget.org: Finished."
fi

if [[ ! -z "$3" ]]; then
    echo "Uploading NuGet packages to nuget.org..."
    dotnet nuget push "$1/**/*.nupkg" --source https://api.nuget.org/v3/index.json --skip-duplicate --api-key $3
    echo "Uploading NuGet packages to nuget.org: Finished."
fi

echo "Exited: upload_nuget_packages.sh"