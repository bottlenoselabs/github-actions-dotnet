#!/bin/bash
# NOTE: This script packs a .NET application.
# INPUT:
#   $1: The file path of the .NET solution (.sln) file or C# project (.csproj) file.
#   $2: The version to use for packing the .NET solution or C# project.
# OUTPUT: A packed .NET application.

echo "Entered: pack.sh"

echo "Packing the .NET application '$1'..."
dotnet pack $1 --nologo --verbosity minimal --configuration Release --no-build -p:PackageVersion=$2
echo "Packing the .NET application '$1': Finished."

echo "Exited: pack.sh"