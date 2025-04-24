CFLAGS = -Wall -g -DINLINE
MFLAGS = -lm
CC = gcc $(CFLAGS)

.PHONY: all native wasm clean

all: wasm

# Native build (optional)
native: nrlmsise-test

nrlmsise-test: nrlmsise-00.o nrlmsise-00_test.o nrlmsise-00_data.o
	$(CC) -o nrlmsise-test nrlmsise-00.o nrlmsise-00_test.o \
		nrlmsise-00_data.o $(MFLAGS)

nrlmsise-00.o: nrlmsise-00.c nrlmsise-00.h
	$(CC) -c nrlmsise-00.c

nrlmsise-00_test.o: nrlmsise-00_test.c nrlmsise-00.h
	$(CC) -c nrlmsise-00_test.c

nrlmsise-00_data.o: nrlmsise-00_data.c nrlmsise-00.h
	$(CC) -c nrlmsise-00_data.c

# WASM build using Emscripten
wasm:
	@if ! command -v emcmake >/dev/null; then \
		echo "emcmake not found, please install Emscripten."; exit 1; \
	fi
	@mkdir -p build-wasm bin
	@cd build-wasm && emcmake cmake ../ -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF
	@cd build-wasm && cmake --build . --target nrlmsise-interface
	@mv bin/nrlmsise-interface.mjs bin/index.mjs

clean:
	rm -rf nrlmsise-test *.o build-wasm bin