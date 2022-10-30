#See LICENSE.iitm for license details
'''

Author   : Santhosh Pavan
Email id : santhosha@mindgrovetech.in
Details  : This file consists cocotb testbench for bbox dut

--------------------------------------------------------------------------------------------------
'''
'''
TODO:
Task Description: Add list of instructions in Testfactory block. So that testbench generates tests for listed instructions. One instruction is implemented as an example. 
		  For multiple instructions, provided as comment (see after TestFactory(TB)). Please the use the same format.
                  Note - Comments are provided for TestFactory.
		  Note - The value of instr (ANDN) is a temp value, it needed to be changed according to spec.

Note - Here testbench assumes below verilog port names are generated by bluespec compiler. Please implement the bluespec design with below port names.

 DUT Ports:
 Name                         I/O  size 
 bbox_out                       O    65/33
 CLK                            I     1 
 RST_N                          I     1 
 instr                          I    32
 rs1                            I    64/32
 rs2                            I    64/32
   (instr, rs1, rs2) -> bbox_out
'''


import string
import random
import cocotb
import logging as _log
from cocotb.decorators import coroutine
from cocotb.triggers import Timer, RisingEdge, FallingEdge
from cocotb.binary import BinaryValue
from cocotb.clock import Clock
from cocotb.regression import TestFactory

from bbox_ref_model import bbox_rm


#generates clock and reset
async def initial_setup(dut):
	cocotb.start_soon(Clock(dut.CLK, 1, units='ns').start())
        
	dut.RST_N.value = 0
	await RisingEdge(dut.CLK)
	dut.RST_N.value = 1


#drives input data to dut
async def input_driver(dut, instr, rs1, rs2, single_opd):
    await RisingEdge(dut.CLK)
    dut.instr.value = instr
    dut.rs1.value = rs1
    dut._log.info("---------------- DUT Input Info -----------------------")
    if single_opd == 1:
        await RisingEdge(dut.CLK)
        dut._log.info("instr = %s  rs1 = %s ",hex(dut.instr.value), hex(dut.rs1.value))

    else :
        dut.rs2.value = rs2
        await RisingEdge(dut.CLK)
        dut._log.info("instr = %s  rs1 = %s rs2 = %s",hex(dut.instr.value), hex(dut.rs1.value), hex(dut.rs2.value))
    dut._log.info("-------------------------------------------------------")

#monitors dut output
async def output_monitor(dut):
    while True:
        await RisingEdge(dut.CLK)
        if(dut.bbox_out.value[0]): break

    dut_result = dut.bbox_out.value
    return dut_result

#compares output of dut and rm
async def scoreboard(dut, dut_result, rm_result):
    dut._log.info("------------ Compare DUT o/p & Ref Model o/p ----------")
    dut._log.info("Expected output  = %s", rm_result)
    dut._log.info("DUT output       = %s", dut_result)
    assert rm_result == str(dut_result),"Failed"
    dut._log.info("-------------------------------------------------------")

#Testbench
async def TB(dut, XLEN, instr, instr_name, single_opd, num_of_tests):
    await initial_setup(dut)
    dut._log.info("*******************************************************")
    dut._log.info("------------- Test %r of RV%d starts --------------" %(instr_name,XLEN))
    dut._log.info("*******************************************************")
    for i in range (num_of_tests):
        rs1 = random.randint(0,(2**XLEN)-1) 
        rs2 = random.randint(0,(2**XLEN)-1)
        # rs1 = 0xd6267543aba72e4c
        # rs2 = 0x9e5f3c30599df82f
        print(instr)
        rm_result = bbox_rm(instr, rs1, rs2, XLEN)
    
        await input_driver(dut, instr, rs1, rs2, single_opd)
        dut_result = await output_monitor(dut)
    
        await scoreboard(dut, dut_result, rm_result)	
    dut._log.info("*******************************************************")
    dut._log.info("------------- Test %r of RV%d ends ----------------" %(instr_name,XLEN))
    dut._log.info("*******************************************************")


# generates sets of tests based on the different permutations of the possible arguments to the test function
tf = TestFactory(TB)

base = 'RV64' #Set as RV64 or RV32

test_instr32 = [(0b0010000_010_0110011,'sh1add',0),(0b0010000_100_0110011,'sh2add',0),(0b0010000_110_0110011,'sh3add',0),(0b0100000_111_0110011, 'addn', 0),(0b0100000_110_0110011,'orn',0),(0b0100000_100_0110011,'xnor',0),
                (0b0110000_00000_001_0010011,'clz',1),(0b0110000_00001_001_0010011,'ctz',1),
                (0b0110000_00010_001_0010011,'cpop',1),
                (0b0000101_110_0110011,'max',0),(0b0000101_111_0110011,'maxu',0),(0b0000101_100_0110011,'min',0),(0b0000101_101_0110011,'minu',0)]
test_instr64 = [(0b0000100_000_0111011,'adduw',0)
                ,(0b0010000_010_0110011,'sh1add',0),(0b0010000_010_0111011,'sh1adduw',0)
                ,(0b0010000_100_0110011,'sh2add',0),(0b0010000_100_0111011,'sh2adduw',0)
                ,(0b0010000_110_0110011,'sh3add',0),(0b0010000_110_0111011,'sh3adduw',0)
                ,(0b000010_001_0011011,'slliuw',1)
                ,(0b0100000_111_0110011, 'addn', 0),(0b0100000_110_0110011,'orn',0),(0b0100000_100_0110011,'xnor',0),
                (0b0110000_00000_001_0010011,'clz',1),(0b0110000_00000_001_0011011,'clzw',1),(0b0110000_00001_001_0010011,'ctz',1),(0b0110000_00001_001_0011011,'ctzw',1),
                (0b0110000_00010_001_0010011,'cpop',1),(0b0110000_00010_001_0011011,'cpopw',1),
                (0b0000101_110_0110011,'max',0),(0b0000101_111_0110011,'maxu',0),(0b0000101_100_0110011,'min',0),(0b0000101_101_0110011,'minu',0)]

#generates tests for instructions of RV32
if base == 'RV32':
    tf.add_option('XLEN', [32])
    tf.add_option(('instr','instr_name','single_opd'), test_instr32)


#generates tests for instructions of RV64
elif base == 'RV64':
    tf.add_option('XLEN', [64])
    tf.add_option(('instr','instr_name','single_opd'), test_instr64)

#for each instruction below line generates 10 test vectors, can change to different no.
tf.add_option('num_of_tests',[10])
tf.generate_tests()
