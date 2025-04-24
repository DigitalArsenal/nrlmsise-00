# WASM-NRLMSISE-00

This is the WASM port of this [NRLMSISE-00 code](https://github.com/magnific0/nrlmsise-00).

## Installation

```bash
npm install nrlmsise-00
```

## Resources

- [C++ Source](https://github.com/magnific0/nrlmsise-00)
- [Original C source code](http://www.brodo.de/space/nrlmsise/)
- [Official Fortran source code](http://uap-www.nrl.navy.mil/models_web/msis/msis_home.htm)
- [CCMC Modelweb description](http://ccmc.gsfc.nasa.gov/modelweb/atmos/nrlmsise00.html)
- [NRL description](http://www.nrl.navy.mil/research/nrl-review/2003/atmospheric-science/picone/)

## Prerequisites

- **CMake** >= 3.13
- **GNU gcc**
- **Emscripten SDK** (for WASM build)
- **make**

## Installing Emscripten

```bash
git clone https://github.com/emscripten-core/emsdk.git
cd emsdk
./emsdk install latest
./emsdk activate latest
source ./emsdk_env.sh
```

Ensure emcmake and emcc are in your PATH:

```bash
which emcmake
which emcc
```

## Build

### Native build

```bash
make
```

### WASM build

```bash
make wasm
```

For WASM artifacts, use the files in the bin/wasm/

## License

[Apache 2.0](LICENSE)
