//See LICENSE.iitm for license details
/*

Author : Mouna Krishna
Email id : mounakrishna@mindgrovetech.in
Details: The top function which calls the required function depending 
         on the instruction.

--------------------------------------------------------------------------------------------------
*/

/****** Imports *******/
`include "bbox.defines"
import bbox_types :: *;
`include "Zba.bsv"
`include "Zbb.bsv"
`include "Zbc.bsv"
//`include "Zbs.bsv"
/*********************/


/*doc: function: The top function where depending on the instruction the 
  required function is called, get the result and return it.
  The input argument and return type should not be changed. 
  Other than this, all the other code can be changed as per needs.

  As an example the instruction ANDN of the Zbb group has been implemented.
  NOTE: The value of ANDN in bbox.defines is a temp value, it needed to be 
  changed according to spec.
  The complete Zbb group and all the other groups is expected to be implemented 
  and verified.
*/
function BBoxOutput fn_compute(BBoxInput inp);
  Bit#(XLEN) result;
  Bool valid;
  case(inp.instr) matches
    `ADDUW: begin
      result = fn_adduw(inp.rs1, inp.rs2);
      valid = True;
    end

    `SH1ADD: begin
      result = fn_sh1add(inp.rs1, inp.rs2);
      valid = True;
    end

    `SH1ADDUW: begin
      result = fn_sh1adduw(inp.rs1, inp.rs2);
      valid = True;
    end

    `SH2ADD: begin
      result = fn_sh2add(inp.rs1, inp.rs2);
      valid = True;
    end

    `SH2ADDUW: begin
      result = fn_sh2adduw(inp.rs1, inp.rs2);
      valid = True;
    end

    `SH3ADD: begin
      result = fn_sh3add(inp.rs1, inp.rs2);
      valid = True;
    end

    `SH3ADDUW: begin
      result = fn_sh3adduw(inp.rs1, inp.rs2);
      valid = True;
    end

    `SLLIUW: begin
      result = fn_slliuw(inp.rs1, (inp.instr)[25:20]);
      valid = True;
    end

    `ANDN: begin
      result = fn_andn(inp.rs1, inp.rs2);
      valid = True;
    end

    `ORN: begin
      result = fn_orn(inp.rs1, inp.rs2);
      valid = True;
    end

    `XNOR: begin
      result = fn_xnor(inp.rs1, inp.rs2);
      valid = True;
    end

    `CLZ: begin
      result = fn_clz(inp.rs1);
      valid = True;
    end

    `CLZW: begin
      result = fn_clzw(inp.rs1);
      valid = True;
    end

    `CTZ: begin
      result = fn_ctz(inp.rs1);
      valid = True;
    end

    `CTZW: begin
      result = fn_ctzw(inp.rs1);
      valid = True;
    end

    `CPOP: begin
      result = fn_cpop(inp.rs1);
      valid = True;
    end

    `CPOPW: begin
      result = fn_cpopw(inp.rs1);
      valid = True;
    end

    `MAX: begin
      result = fn_max(inp.rs1, inp.rs2);
      valid = True;
    end

    `MAXU: begin
      result = fn_maxu(inp.rs1, inp.rs2);
      valid = True;
    end

    `MIN: begin
      result = fn_min(inp.rs1, inp.rs2);
      valid = True;
    end

    `MINU: begin
      result = fn_minu(inp.rs1, inp.rs2);
      valid = True;
    end

    `CLMUL: begin
      result = fn_clmul(inp.rs1, inp.rs2);
      valid = True;
    end

    `CLMULH: begin
      result = fn_clmulh(inp.rs1, inp.rs2);
      valid = True;
    end

    default: begin
      result = 0;
      valid = False;
    end
  endcase
  return BBoxOutput{valid: valid, data: result};
endfunction
