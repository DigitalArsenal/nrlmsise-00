# WASM-NRLMSISE-00

This is the WASM port of this [NRLMSISE-00 code](https://github.com/magnific0/nrlmsise-00).

## NRLMSISE-00

Unofficial Github repository of the C source code for the NRLMSISE-00 Model 2001 empirical atmosphere model.

## Version

This version is based on the nrlmsise-00.20151122 release of C sourcecode of NRLMISE-00, which in itself is based on the official NRLMSISE-00 version 2.0 Fortran release.  
At the moment this (GitHub) version is zero fixes ahead of 20151122, please see the [commit log](https://github.com/magnific0/NRLMISE-00/commits/master) for more information. It is the intention to merge future releases of [brodo.de/space/nrlmsise/](http://www.brodo.de/space/nrlmsise) into this version and communicate any changes made here as suggestions.

## Documentation

Please refer to the DOCUMENTATION file.

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
