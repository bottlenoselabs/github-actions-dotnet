#!/bin/bash
# NOTE: This script builds a .NET application.
# INPUT:
#   $1: The file path of the .NET solution (.sln) file or C# project (.csproj) file.
#   $2: The version string to use for building the .NET solution or C# project.
# OUTPUT: A built .NET application on disk.

echo "Entered: build.sh $1 $2"

echo "Building the .NET application '$1'..."
dotnet build $1 --nologo --verbosity diagnostic --configuration Release -p:Version="$2"
echo "Building the .NET application '$1': Finished."

echo "Exited: build.sh $1 $2"