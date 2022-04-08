#!/bin/bash

echo "Installing .NET GitVersion command line tool..."

dotnet tool install --global GitVersion.Tool

if [ $? -eq 0 ]; then
    echo "Installing .NET GitVersion command line tool: Success."
else
    echo "Installing .NET GitVersion command line tool: Failed."
fi