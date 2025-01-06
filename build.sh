#!/bin/bash

# Ensure Emscripten is in the PATH
if ! command -v emcmake &> /dev/null
then
    echo "emcmake could not be found. Ensure Emscripten is installed and in the PATH."
    exit 1
fi

# Create a build directory if not exists
mkdir -p build
cd build

# Run emcmake to configure the project
emcmake cmake ..

# Build the project
cmake --build .

# Install the compiled artifacts
cmake --install .
