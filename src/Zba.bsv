// ADD unsigned word
function Bit#(XLEN) fn_adduw(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  return rs2 + zeroExtend(rs1[31:0]);
endfunction

// SHFT left and add 1
function Bit#(XLEN) fn_sh1add(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  return rs2 + (rs1 << 1);
endfunction

// SHFT left unsigned word and add 1
function Bit#(XLEN) fn_sh1adduw(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  return rs2 + (zeroExtend(rs1[31:0]) << 1);
endfunction
