#!/bin/bash
# NOTE: This script builds a .NET application.
# INPUT:
#   $1: The file path of the .NET solution (.sln) file or C# project (.csproj) file.
#   $2: The version string to use for building the .NET solution or C# project.
# OUTPUT: A built .NET application on disk.

echo "Entered: build.sh"

dotnet restore $1 --nologo --verbosity minimal
dotnet build $1 --nologo --no-restore --verbosity minimal --configuration Release -p:Version=$2

echo "Exited: build.sh"