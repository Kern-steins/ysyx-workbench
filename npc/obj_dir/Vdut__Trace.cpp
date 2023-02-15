// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vdut__Syms.h"


void Vdut___024root__traceChgSub0(Vdut___024root* vlSelf, VerilatedVcd* tracep);

void Vdut___024root__traceChgTop0(void* voidSelf, VerilatedVcd* tracep) {
    Vdut___024root* const __restrict vlSelf = static_cast<Vdut___024root*>(voidSelf);
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    // Body
    {
        Vdut___024root__traceChgSub0((&vlSymsp->TOP), tracep);
    }
}

void Vdut___024root__traceChgSub0(Vdut___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    vluint32_t* const oldp = tracep->oldp(vlSymsp->__Vm_baseCode + 1);
    if (false && oldp) {}  // Prevent unused
    // Body
    {
        tracep->chgBit(oldp+0,(vlSelf->clk));
        tracep->chgBit(oldp+1,(vlSelf->rst));
        tracep->chgCData(oldp+2,(vlSelf->in_1),2);
        tracep->chgCData(oldp+3,(vlSelf->in_2),2);
        tracep->chgCData(oldp+4,(vlSelf->in_3),2);
        tracep->chgCData(oldp+5,(vlSelf->in_4),2);
        tracep->chgCData(oldp+6,(vlSelf->op),2);
        tracep->chgCData(oldp+7,(vlSelf->out_1),2);
    }
}

void Vdut___024root__traceCleanup(void* voidSelf, VerilatedVcd* /*unused*/) {
    VlUnpacked<CData/*0:0*/, 1> __Vm_traceActivity;
    Vdut___024root* const __restrict vlSelf = static_cast<Vdut___024root*>(voidSelf);
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    {
        vlSymsp->__Vm_activity = false;
        __Vm_traceActivity[0U] = 0U;
    }
}
