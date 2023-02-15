// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vdut.h for the primary calling header

#include "Vdut___024root.h"
#include "Vdut__Syms.h"

//==========

VL_INLINE_OPT void Vdut___024root___combo__TOP__1(Vdut___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root___combo__TOP__1\n"); );
    // Body
    vlSelf->out_1 = ((2U & (IData)(vlSelf->op)) ? (
                                                   (1U 
                                                    & (IData)(vlSelf->op))
                                                    ? (IData)(vlSelf->in_4)
                                                    : (IData)(vlSelf->in_3))
                      : ((1U & (IData)(vlSelf->op))
                          ? (IData)(vlSelf->in_2) : (IData)(vlSelf->in_1)));
}

void Vdut___024root___eval(Vdut___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root___eval\n"); );
    // Body
    Vdut___024root___combo__TOP__1(vlSelf);
}

QData Vdut___024root___change_request_1(Vdut___024root* vlSelf);

VL_INLINE_OPT QData Vdut___024root___change_request(Vdut___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root___change_request\n"); );
    // Body
    return (Vdut___024root___change_request_1(vlSelf));
}

VL_INLINE_OPT QData Vdut___024root___change_request_1(Vdut___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root___change_request_1\n"); );
    // Body
    // Change detection
    QData __req = false;  // Logically a bool
    return __req;
}

#ifdef VL_DEBUG
void Vdut___024root___eval_debug_assertions(Vdut___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vdut__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdut___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->clk & 0xfeU))) {
        Verilated::overWidthError("clk");}
    if (VL_UNLIKELY((vlSelf->rst & 0xfeU))) {
        Verilated::overWidthError("rst");}
    if (VL_UNLIKELY((vlSelf->in_1 & 0xfcU))) {
        Verilated::overWidthError("in_1");}
    if (VL_UNLIKELY((vlSelf->in_2 & 0xfcU))) {
        Verilated::overWidthError("in_2");}
    if (VL_UNLIKELY((vlSelf->in_3 & 0xfcU))) {
        Verilated::overWidthError("in_3");}
    if (VL_UNLIKELY((vlSelf->in_4 & 0xfcU))) {
        Verilated::overWidthError("in_4");}
    if (VL_UNLIKELY((vlSelf->op & 0xfcU))) {
        Verilated::overWidthError("op");}
}
#endif  // VL_DEBUG
