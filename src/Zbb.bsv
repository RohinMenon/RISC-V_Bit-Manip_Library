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

// Count set bits
function Bit#(XLEN) fn_cpop(Bit#(XLEN) rs1);
  Bit#(XLEN) res = pack(zeroExtend(countOnes(rs1)));
  return res;
endfunction

// Count set bits in word
function Bit#(XLEN) fn_cpopw(Bit#(XLEN) rs1);
  Bit#(XLEN) res = pack(zeroExtend(countOnes(rs1[31:0])));
  return res;
endfunction

// Maximum
function Bit#(XLEN) fn_max(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  Int#(XLEN) s1 = unpack(rs1);
  Int#(XLEN) s2 = unpack(rs2);
  Bit#(XLEN) res = pack(max(s1,s2));
  return res;
endfunction

// Unsigned Maximum
function Bit#(XLEN) fn_maxu(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  return max(rs1,rs2);
endfunction

// Minimum
function Bit#(XLEN) fn_min(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  Int#(XLEN) s1 = unpack(rs1);
  Int#(XLEN) s2 = unpack(rs2);
  Bit#(XLEN) res = pack(min(s1,s2));
  return res;
endfunction

// Unsigned Minimum
function Bit#(XLEN) fn_minu(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  return min(rs1,rs2);
endfunction

// Sign-extend byte
function Bit#(XLEN) fn_sextb(Bit#(XLEN) rs1);
  Bit#(XLEN) res = pack(signExtend(rs1[7:0]));
  return res;
endfunction

// Sign-extend halfword
function Bit#(XLEN) fn_sexth(Bit#(XLEN) rs1);
  Bit#(XLEN) res = pack(signExtend(rs1[15:0]));
  return res;
endfunction

// Zero-extend halfword
function Bit#(XLEN) fn_zexth(Bit#(XLEN) rs1);
  Bit#(XLEN) res = pack(zeroExtend(rs1[15:0]));
  return res;
endfunction
