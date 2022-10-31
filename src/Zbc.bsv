// CLMUL 
function Bit#(XLEN) fn_clmul(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
    Bit#(XLEN) res = 0;
    for(Integer i=0; i<valueOf(XLEN); i=i+1)
    begin
        if(((rs2 >> i) & 1)!=0)
        begin
            res = res ^ (rs1 << i);
        end
    end
    return res;
  endfunction

// CLMULH
function Bit#(XLEN) fn_clmulh(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
    Bit#(XLEN) res = 0;
    for(Integer i=1; i<valueOf(XLEN); i=i+1)
    begin
        if(((rs2 >> i) & 1)!=0)
        begin
            res = res ^ (rs1 >> (valueOf(XLEN)-i));
        end
    end
    return res;
  endfunction

// CLMULR
function Bit#(XLEN) fn_clmulr(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
    Bit#(XLEN) res = 0;
    for(Integer i=0; i<valueOf(XLEN); i=i+1)
    begin
        if(((rs2 >> i) & 1)!=0)
        begin
            res = res ^ (rs1 >> (valueOf(XLEN)-i-1));
        end
    end
    return res;
  endfunction