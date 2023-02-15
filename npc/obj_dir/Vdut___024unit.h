// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vdut.h for the primary calling header

#ifndef VERILATED_VDUT___024UNIT_H_
#define VERILATED_VDUT___024UNIT_H_  // guard

#include "verilated_heavy.h"

//==========

class Vdut__Syms;
class Vdut_VerilatedVcd;


//----------

VL_MODULE(Vdut___024unit) {
  public:

    // INTERNAL VARIABLES
    Vdut__Syms* vlSymsp;  // Symbol table

    // CONSTRUCTORS
  private:
    VL_UNCOPYABLE(Vdut___024unit);  ///< Copying not allowed
  public:
    Vdut___024unit(const char* name);
    ~Vdut___024unit();

    // INTERNAL METHODS
    void __Vconfigure(Vdut__Syms* symsp, bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

//----------


#endif  // guard
