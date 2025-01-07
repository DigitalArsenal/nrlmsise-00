#!/bin/bash

# Ensure Emscripten is in the PATH
if ! command -v emcmake &> /dev/null
then
    echo "emcmake could not be found. Ensure Emscripten is installed and in the PATH."
    exit 1
fi

# Check if the --debug flag is passed
DEBUG_FLAG=0
WASM_FLAG=0
if [[ "$1" == "--debug" ]]; then
  DEBUG_FLAG=1
  shift  # Remove the --debug argument
fi

# Check if the --wasm flag is passed
if [[ "$1" == "--wasm" ]]; then
  WASM_FLAG=1
  shift  # Remove the --wasm argument
fi

# Create a build directory if not exists
mkdir -p build
cd build

# Delete all .o files before building
find . -name "*.o" -type f -exec rm -f {} \;

# Set the CMake build type (Debug or Release) and use emcmake if --wasm flag is set
if [ $DEBUG_FLAG -eq 1 ]; then
  echo "Setting build type to Debug"
  if [ $WASM_FLAG -eq 1 ]; then
    emcmake cmake .. -DCMAKE_BUILD_TYPE=Debug
  else
    cmake .. -DCMAKE_BUILD_TYPE=Debug
  fi
else
  echo "Setting build type to Release"
  if [ $WASM_FLAG -eq 1 ]; then
    emcmake cmake .. -DCMAKE_BUILD_TYPE=Release
  else
    cmake .. -DCMAKE_BUILD_TYPE=Release
  fi
fi

# Build the project
cmake --build .

# Install the compiled artifacts
cmake --install .

cd ..

sed -i "s|'module'|'node:module'|" ./bin/nrlmsise-interface.mjs

# Add the 'Buffer' import after the modified line
sed -i '1a import { Buffer } from "https://deno.land/std@0.126.0/node/buffer.ts";' ./bin/nrlmsise-interface.mjs

echo "nrlmsise-interface.mjs has been modified successfully."