// AND with inverted operand
function Bit#(XLEN) fn_andn(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  return rs1 & ~rs2;
endfunction

// OR with inverted operand
function Bit#(XLEN) fn_orn(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  return rs1 | ~rs2;
endfunction

// Exclusive NOR
function Bit#(XLEN) fn_xnor(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  return ~(rs1 ^ rs2);
endfunction

// Count leading zero bits
function Bit#(XLEN) fn_clz(Bit#(XLEN) rs1);
  Bit#(XLEN) res = pack(zeroExtend(countZerosMSB(rs1)));
  return res;
endfunction

// Count leading zero bits in word
function Bit#(XLEN) fn_clzw(Bit#(XLEN) rs1);
  Bit#(XLEN) res = pack(zeroExtend(countZerosMSB(rs1[31:0])));
  return res;
endfunction

// Count trailing zero bits
function Bit#(XLEN) fn_ctz(Bit#(XLEN) rs1);
  Bit#(XLEN) res = pack(zeroExtend(countZerosLSB(rs1)));
  return res;
endfunction

// Count trailing zero bits in word
function Bit#(XLEN) fn_ctzw(Bit#(XLEN) rs1);
  Bit#(XLEN) res = pack(zeroExtend(countZerosLSB(rs1[31:0])));
  return res;
endfunction