#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

echo "Installing .NET GitVersion command line tool..."

dotnet tool install --global GitVersion.Tool

if [ $? -eq 0 ]; then
    echo "Installing .NET GitVersion command line tool: Success."
else
    echo "Installing .NET GitVersion command line tool: Failed."
fi