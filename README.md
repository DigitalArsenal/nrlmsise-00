# WASM-NRLMSISE-00

This is the WASM port of this [NRLMSISE-00 code](https://github.com/magnific0/nrlmsise-00).

## Installation

```bash
npm install nrlmsise-00
```
## Usage

```javascript
    const module = await nrlmsiseModule();
    const NrlmsiseModel = module.NrlmsiseModel;

    // Create an instance of the NrlmsiseModel class
    const model = new NrlmsiseModel();

    // Prepare input values
    const doy = 172;  // Day of year
    const sec = 29000;  // Seconds in the day
    const alt = 400;  // Altitude in km
    const g_lat = 60;  // Geodetic latitude
    const g_long = -70;  // Geodetic longitude
    const lst = 16;  // Local solar time
    const f107A = 150;  // 81-day average of F10.7 flux
    const f107 = 150;  // Daily F10.7 flux
    const ap = 4;  // Magnetic index

    // Run the model
    model.run_model(doy, sec, alt, g_lat, g_long, lst, f107A, f107, ap);

    // Log the results (access the properties directly)
    console.log("HE:", model.HE);
    console.log("O:", model.O);
    console.log("N2:", model.N2);
    console.log("O2:", model.O2);
    console.log("AR:", model.AR);
    console.log("Total Mass Density:", model.TotalMassDensity);
    console.log("H:", model.H);
    console.log("N:", model.N);
    console.log("Anomalous Oxygen:", model.AnomalousOxygen);
    console.log("Exospheric Temp:", model.ExosphericTemp);
    console.log("Temperature at Alt:", model.TemperatureAtAlt);
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
