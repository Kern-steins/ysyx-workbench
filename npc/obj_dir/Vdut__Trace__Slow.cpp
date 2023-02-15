// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vdut__Syms.h"


void Vdut___024root__traceInitSub0(Vdut___024root* vlSelf, VerilatedVcd* tracep) VL_ATTR_COLD;

void Vdut___024root__traceInitTop(Vdut___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    {
        Vdut___024root__traceInitSub0(vlSelf, tracep);
    }
}

void Vdut___024root__traceInitSub0(Vdut___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    const int c = vlSymsp->__Vm_baseCode;
    if (false && tracep && c) {}  // Prevent unused
    // Body
    {
        tracep->declBit(c+1,"clk", false,-1);
        tracep->declBit(c+2,"rst", false,-1);
        tracep->declBus(c+3,"in_1", false,-1, 1,0);
        tracep->declBus(c+4,"in_2", false,-1, 1,0);
        tracep->declBus(c+5,"in_3", false,-1, 1,0);
        tracep->declBus(c+6,"in_4", false,-1, 1,0);
        tracep->declBus(c+7,"op", false,-1, 1,0);
        tracep->declBus(c+8,"out_1", false,-1, 1,0);
        tracep->declBit(c+1,"dut clk", false,-1);
        tracep->declBit(c+2,"dut rst", false,-1);
        tracep->declBus(c+3,"dut in_1", false,-1, 1,0);
        tracep->declBus(c+4,"dut in_2", false,-1, 1,0);
        tracep->declBus(c+5,"dut in_3", false,-1, 1,0);
        tracep->declBus(c+6,"dut in_4", false,-1, 1,0);
        tracep->declBus(c+7,"dut op", false,-1, 1,0);
        tracep->declBus(c+8,"dut out_1", false,-1, 1,0);
        tracep->declBus(c+9,"dut DATA_LEN", false,-1, 31,0);
        tracep->declBus(c+9,"dut mux_test DATA_LEN", false,-1, 31,0);
        tracep->declBus(c+3,"dut mux_test in_1", false,-1, 1,0);
        tracep->declBus(c+4,"dut mux_test in_2", false,-1, 1,0);
        tracep->declBus(c+5,"dut mux_test in_3", false,-1, 1,0);
        tracep->declBus(c+6,"dut mux_test in_4", false,-1, 1,0);
        tracep->declBus(c+7,"dut mux_test op", false,-1, 1,0);
        tracep->declBus(c+8,"dut mux_test out_1", false,-1, 1,0);
    }
}

void Vdut___024root__traceFullTop0(void* voidSelf, VerilatedVcd* tracep) VL_ATTR_COLD;
void Vdut___024root__traceChgTop0(void* voidSelf, VerilatedVcd* tracep);
void Vdut___024root__traceCleanup(void* voidSelf, VerilatedVcd* /*unused*/);

void Vdut___024root__traceRegister(Vdut___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    {
        tracep->addFullCb(&Vdut___024root__traceFullTop0, vlSelf);
        tracep->addChgCb(&Vdut___024root__traceChgTop0, vlSelf);
        tracep->addCleanupCb(&Vdut___024root__traceCleanup, vlSelf);
    }
}

void Vdut___024root__traceFullSub0(Vdut___024root* vlSelf, VerilatedVcd* tracep) VL_ATTR_COLD;

void Vdut___024root__traceFullTop0(void* voidSelf, VerilatedVcd* tracep) {
    Vdut___024root* const __restrict vlSelf = static_cast<Vdut___024root*>(voidSelf);
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    {
        Vdut___024root__traceFullSub0((&vlSymsp->TOP), tracep);
    }
}

void Vdut___024root__traceFullSub0(Vdut___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    vluint32_t* const oldp = tracep->oldp(vlSymsp->__Vm_baseCode);
    if (false && oldp) {}  // Prevent unused
    // Body
    {
        tracep->fullBit(oldp+1,(vlSelf->clk));
        tracep->fullBit(oldp+2,(vlSelf->rst));
        tracep->fullCData(oldp+3,(vlSelf->in_1),2);
        tracep->fullCData(oldp+4,(vlSelf->in_2),2);
        tracep->fullCData(oldp+5,(vlSelf->in_3),2);
        tracep->fullCData(oldp+6,(vlSelf->in_4),2);
        tracep->fullCData(oldp+7,(vlSelf->op),2);
        tracep->fullCData(oldp+8,(vlSelf->out_1),2);
        tracep->fullIData(oldp+9,(2U),32);
    }
}
