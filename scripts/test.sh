#!/bin/bash
# NOTE: This script tests a .NET application.
# INPUT:
#   $1: The file path of the .NET solution (.sln) file or C# project (.csproj) file.
# OUTPUT: A tested .NET application.

echo "Entered: test.sh $1"

echo "Testing the .NET application '$1'..."
dotnet test $1 --nologo --verbosity minimal --configuration Release --no-build
echo "Testing the .NET application '$1': Finished."

echo "Exited: test.sh $1"