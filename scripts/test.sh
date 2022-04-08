#!/bin/bash
# NOTE: This script tests a .NET application.
# INPUT:
#   $1: The file path of the .NET solution (.sln) file or C# project (.csproj) file.
# OUTPUT: A tested .NET application.

echo "Entered: test.sh"

dotnet test $1 --nologo --verbosity minimal --configuration Release --no-build

echo "Exited: test.sh"