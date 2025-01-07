#include "nrlmsise-00.h"
#include <emscripten.h>
#include <emscripten/bind.h>
#include <vector>
#include <iostream>

using namespace emscripten;

class NrlmsiseModel
{
public:
    // Public properties that can be accessed from JavaScript
    double HE, O, N2, O2, AR, TotalMassDensity, H, N, AnomalousOxygen;
    double ExosphericTemp, TemperatureAtAlt;

    // Constructor
    NrlmsiseModel() : HE(0), O(0), N2(0), O2(0), AR(0), TotalMassDensity(0),
                      H(0), N(0), AnomalousOxygen(0), ExosphericTemp(0), TemperatureAtAlt(0) {}

    // Function to run the model and populate properties
    void run_model(double doy,
                   double sec,
                   double alt,
                   double g_lat,
                   double g_long,
                   double lst,
                   double f107A,
                   double f107,
                   double ap)
    {
        struct nrlmsise_input input = {};
        struct nrlmsise_output output = {};
        struct nrlmsise_flags flags = {};

        input.doy = doy;
        input.sec = sec;
        input.alt = alt;
        input.g_lat = g_lat;
        input.g_long = g_long;
        input.lst = lst;
        input.f107A = f107A;
        input.f107 = f107;
        input.ap = ap;

        for (int i = 0; i < 24; i++)
        {
            flags.switches[i] = 1;
        }

        // Call the model
        gtd7(&input, &flags, &output);

        // Set the properties
        HE = output.d[0];
        O = output.d[1];
        N2 = output.d[2];
        O2 = output.d[3];
        AR = output.d[4];
        TotalMassDensity = output.d[5];
        H = output.d[6];
        N = output.d[7];
        AnomalousOxygen = output.d[8];
        ExosphericTemp = output.t[0];
        TemperatureAtAlt = output.t[1];
    }
};

// Expose the class to JavaScript using Emscripten
EMSCRIPTEN_BINDINGS(nrlmsise_module)
{
    class_<NrlmsiseModel>("NrlmsiseModel")
        .constructor<>()
        .function("run_model", &NrlmsiseModel::run_model)
        .property("HE", &NrlmsiseModel::HE)
        .property("O", &NrlmsiseModel::O)
        .property("N2", &NrlmsiseModel::N2)
        .property("O2", &NrlmsiseModel::O2)
        .property("AR", &NrlmsiseModel::AR)
        .property("TotalMassDensity", &NrlmsiseModel::TotalMassDensity)
        .property("H", &NrlmsiseModel::H)
        .property("N", &NrlmsiseModel::N)
        .property("AnomalousOxygen", &NrlmsiseModel::AnomalousOxygen)
        .property("ExosphericTemp", &NrlmsiseModel::ExosphericTemp)
        .property("TemperatureAtAlt", &NrlmsiseModel::TemperatureAtAlt);
}
