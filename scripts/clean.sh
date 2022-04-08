#!/bin/bash
# NOTE: This script cleans the file system in preparation for a build.
# INPUT:
#   $1: The file path of the .NET solution (.sln) file or C# project (.csproj) file.
# OUTPUT: Removed files and directories.

echo "Entered: clean.sh"

# dotnet nuget locals all --clear
dotnet clean $1 --verbosity quiet --configuration Release

echo "Exited: clean.sh"