// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vdut.h for the primary calling header

#include "Vdut___024unit.h"
#include "Vdut__Syms.h"

//==========


void Vdut___024unit___ctor_var_reset(Vdut___024unit* vlSelf);

Vdut___024unit::Vdut___024unit(const char* _vcname__)
    : VerilatedModule(_vcname__)
 {
    // Reset structure values
    Vdut___024unit___ctor_var_reset(this);
}

void Vdut___024unit::__Vconfigure(Vdut__Syms* _vlSymsp, bool first) {
    if (false && first) {}  // Prevent unused
    this->vlSymsp = _vlSymsp;
}

Vdut___024unit::~Vdut___024unit() {
}

void Vdut___024unit___ctor_var_reset(Vdut___024unit* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vdut___024unit___ctor_var_reset\n"); );
}
