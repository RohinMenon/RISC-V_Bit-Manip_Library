// ADD unsigned word
function Bit#(XLEN) fn_adduw(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  return rs2 + zeroExtend(rs1[31:0]);
endfunction

// SHFT left and add
function Bit#(XLEN) fn_sh1add(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  return rs2 + (rs1 << 1);
endfunction

// SHFT left unsigned word and add
function Bit#(XLEN) fn_sh1adduw(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  return rs2 + (zeroExtend(rs1[31:0]) << 1);
endfunction

// SHFT left 2 places and add
function Bit#(XLEN) fn_sh2add(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  return rs2 + (rs1 << 2);
endfunction

// SHFT left 2 places unsigned word and add
function Bit#(XLEN) fn_sh2adduw(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  return rs2 + (zeroExtend(rs1[31:0]) << 2);
endfunction

// SHFT left 3 places and add
function Bit#(XLEN) fn_sh3add(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  return rs2 + (rs1 << 3);
endfunction

// SHFT left 3 places unsigned word and add
function Bit#(XLEN) fn_sh3adduw(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  return rs2 + (zeroExtend(rs1[31:0]) << 3);
endfunction