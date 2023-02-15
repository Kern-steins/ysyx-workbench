// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vdut.h for the primary calling header

#ifndef VERILATED_VDUT___024ROOT_H_
#define VERILATED_VDUT___024ROOT_H_  // guard

#include "verilated_heavy.h"

//==========

class Vdut__Syms;
class Vdut_VerilatedVcd;


//----------

VL_MODULE(Vdut___024root) {
  public:

    // PORTS
    VL_IN8(clk,0,0);
    VL_IN8(rst,0,0);
    VL_IN8(in_1,1,0);
    VL_IN8(in_2,1,0);
    VL_IN8(in_3,1,0);
    VL_IN8(in_4,1,0);
    VL_IN8(op,1,0);
    VL_OUT8(out_1,1,0);

    // INTERNAL VARIABLES
    Vdut__Syms* vlSymsp;  // Symbol table

    // CONSTRUCTORS
  private:
    VL_UNCOPYABLE(Vdut___024root);  ///< Copying not allowed
  public:
    Vdut___024root(const char* name);
    ~Vdut___024root();

    // INTERNAL METHODS
    void __Vconfigure(Vdut__Syms* symsp, bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

//----------


#endif  // guard
