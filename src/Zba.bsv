// ADD unsigned word
function Bit#(XLEN) fn_adduw(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  return rs2 + zeroExtend(rs1[31:0]);
endfunction
