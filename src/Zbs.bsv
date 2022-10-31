// bclr
function Bit#(XLEN) fn_bclr(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
    Bit#(XLEN) tmp = fromInteger(valueOf(XLEN)-1);
    return rs1 & ~( 1 << (rs2 & tmp));
  endfunction
 
// bclri32
function Bit#(XLEN) fn_bclri32(Bit#(XLEN) rs1, Bit#(5) shamt);
    return rs1 & ~( 1 << (shamt));
  endfunction
 
// bclri64
function Bit#(XLEN) fn_bclri64(Bit#(XLEN) rs1, Bit#(6) shamt);
    return rs1 & ~( 1 << (shamt));
  endfunction

// bext
function Bit#(XLEN) fn_bext(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
    Bit#(XLEN) tmp = fromInteger(valueOf(XLEN)-1);
    return (rs1 >> (rs2 & tmp)) & 1;
  endfunction
 
// bexti32
function Bit#(XLEN) fn_bexti32(Bit#(XLEN) rs1, Bit#(5) shamt);
    return (rs1 >> (shamt)) & 1;
  endfunction
 
// bexti64
function Bit#(XLEN) fn_bexti64(Bit#(XLEN) rs1, Bit#(6) shamt);
    return (rs1 >> (shamt)) & 1;
  endfunction

// binv
function Bit#(XLEN) fn_binv(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
    Bit#(XLEN) tmp = fromInteger(valueOf(XLEN)-1);
    return rs1 ^ (1 << (rs2 & tmp));
  endfunction
 
// binvi32
function Bit#(XLEN) fn_binvi32(Bit#(XLEN) rs1, Bit#(5) shamt);
    return rs1 ^ (1 << (shamt));
  endfunction
 
// binvi64
function Bit#(XLEN) fn_binvi64(Bit#(XLEN) rs1, Bit#(6) shamt);
    return rs1 ^ (1 << (shamt));
  endfunction

// bset
function Bit#(XLEN) fn_bset(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
    Bit#(XLEN) tmp = fromInteger(valueOf(XLEN)-1);
    return rs1 | (1 << (rs2 & tmp));
  endfunction
 
// bseti32
function Bit#(XLEN) fn_bseti32(Bit#(XLEN) rs1, Bit#(5) shamt);
    return rs1 | (1 << (shamt));
  endfunction
 
// bseti64
function Bit#(XLEN) fn_bseti64(Bit#(XLEN) rs1, Bit#(6) shamt);
    return rs1 | (1 << (shamt));
  endfunction