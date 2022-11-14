# BitManip Extension project (CS22E002 & CS22E003)

Thsi repo consists of the design of the Bit Manipulation Spec by RISC-V, implemented using **Bluespec** and verified using **cocotb**. The spec pdf is present in docs/bitmanip-1.0.0-38-g865e7a7.pdf .

### The repo structure is as follows:
- bbox.bsv - The top module of the design. Has the interface definition and module definition which calls the BitManip calculation.
- Makefile - Has make commands to generate_verilog and simulate and clean.
- src/ - The directory contains files with functions of the BitManip calculations. The files present are
	- compute.bsv - The top function which selects between the functions implemented for the spec depending on the instruction.
	- bbox.defines - The function which has the macro definition used to select between the instructions.
	- bbox_types.bsv - The structures, enum, bsc macors are defined here.
	- Zba.bsv - Address generation instructions
    - Zbb.bsv - Basic bit-manipulation
    - Zbc.bsv - Carry-less multiplication
    - Zbs.bsv - Single-bit instructions
- bbox_verif/ - The directory where the scripts required for running the cocotb tests are present. The files present are:
	- test_bbox.py - This file consists cocotb testbench for bbox dut. 
	- bbox_ref_model.py - This file consists reference model which used in verifying the design (DUT).
- result64 - Contains terminal output of design test in RV64
- result32 - Contains terminal output of design test in RV32

### Steps to run:
Make sure you have installed all the required tools as mentioned in docs/Tool_setup.pdf and the python environment is activated.

To make the code more user friendly to run, the Makefile is designed such that the user does not have to make changes to both Makefile macros and the corresponding base variable in the python file.

1. To run the design in base 64, use the following command

```bash
$ make
```
or
```bash
$ make BSCDEFINES=RV64
```
2. To run the design in base 32, use the following command
```bash
$ make BSCDEFINES=RV32
```

**_NOTE:_** No changes are required elsewhere as the Makefile is designed to be user-friendly 

### Optimizations:
In order to make sure that the generated design is as optimal as possible (atleast the best among a few different approaches), we have sythesized the design of each function on Arty-7 FPGA using Vivado and have chosen the design which yielded the least number of LUT's (as much as possible)

**_NOTE:_** We have tried to maximize the use of built-in functions in Bluespec under the assumption that these would yield the most optimal design

### Results:
The design was tested for all the instruction availabe for 10 test cases for each instruction. All the instructions (43 for RV64 and 32 for RV32) were able to successfully pass the verification. One such simulation result, for each base, are present in the files **result64** (for RV64) and **result32** (for RV32)

**Link to Github Repo:**  https://gitlab.com/c.rohinmenon/cad_project_cs22e002_cs22e003.git