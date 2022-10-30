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

// Rotate Left (Register)
function Bit#(XLEN) fn_rol(Bit#(XLEN) rs1, Bit#(XLEN) rs2)
provisos (Log#(XLEN,b),Add#(a__, 64, TMul#(XLEN,2)),Mul#(XLEN,2,x2len));
  let idx = valueOf(b);
  let xlen = valueOf(XLEN);
  let xlen2 = valueOf(x2len);

  Bit#(XLEN) zeros = 0; 
  Bit#(b) shamt = rs2[idx-1:0];
  Bit#(x2len) y = {zeros,rs1} << shamt;
  return y[xlen2-1:xlen]|y[xlen-1:0];
endfunction

// Rotate Left Word (Register)
function Bit#(XLEN) fn_rolw(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  Bit#(32) zeros = 0; 
  Bit#(5) shamt = rs2[4:0];
  Bit#(64) y = {zeros,rs1[31:0]} << shamt;
  Bit#(XLEN) res = signExtend(y[63:32]|y[31:0]);
  return res;
endfunction


// Rotate Right (Register)
function Bit#(XLEN) fn_ror(Bit#(XLEN) rs1, Bit#(XLEN) rs2)
provisos (Log#(XLEN,b),Add#(a__, 64, TMul#(XLEN,2)),Mul#(XLEN,2,x2len));
  let idx = valueOf(b);
  let xlen = valueOf(XLEN);
  let xlen2 = valueOf(x2len);

  Bit#(XLEN) zeros = 0; 
  Bit#(b) shamt = rs2[idx-1:0];
  Bit#(x2len) y = {rs1,zeros} >> shamt;
  return y[xlen2-1:xlen]|y[xlen-1:0];
endfunction

/* For Immediate Mode, we can just pass the immediate as the
LSB log(XLEN) bits of rs2 and the call the corresponding
register equivalent function */

// // Rotate Right (Immediate)
// function Bit#(XLEN) fn_rori(Bit#(XLEN) rs1, Bit#(b) shamt)
// provisos (Log#(XLEN,b),Add#(a__, 64, TMul#(XLEN,2)),Mul#(XLEN,2,x2len));
//   let idx = valueOf(b);
//   let xlen = valueOf(XLEN);
//   let xlen2 = valueOf(x2len);

//   Bit#(XLEN) zeros = 0; 
//   Bit#(b) shamt = rs2[idx-1:0];
//   Bit#(x2len) y = {rs1,zeros} >> shamt;
//   return y[xlen2-1:xlen]|y[xlen-1:0];
// endfunction

// // Rotate Right Word (Immediate)
// function Bit#(XLEN) fn_roriw(Bit#(XLEN) rs1, Bit#(b) shamt);
//   Bit#(32) zeros = 0; 
//   Bit#(5) shamt = rs2[4:0];
//   Bit#(64) y = {rs1[31:0],zeros} >> shamt;
//   Bit#(XLEN) res = signExtend(y[63:32]|y[31:0]);
//   return res;
// endfunction


// Rotate Right Word (Register)
function Bit#(XLEN) fn_rorw(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  Bit#(32) zeros = 0; 
  Bit#(5) shamt = rs2[4:0];
  Bit#(64) y = {rs1[31:0],zeros} >> shamt;
  Bit#(XLEN) res = signExtend(y[63:32]|y[31:0]);
  return res;
endfunction
