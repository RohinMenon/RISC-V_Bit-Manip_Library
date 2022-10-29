#See LICENSE.iitm for license details
'''

Author   : Santhosh Pavan
Email id : santhosh@mindgrovetech.in
Details  : This file consists reference model which is used in verifying the bbox design (DUT).

--------------------------------------------------------------------------------------------------
'''
'''
TODO:
Task Description: Add logic for all instructions. One instruction is implemented as an example. 
                  Note - The value of instr (ANDN) is a temp value, it needed to be changed according to spec.

Note - if instr has single operand, take rs1 as an operand
'''

#Reference model
def bbox_rm(instr, rs1, rs2, XLEN):
    
    # AND with inverted operand
    if instr == 0b0100000_111_0110011:
        res = rs1 & ~rs2
        # Overflow condition
        res = int(bin(((1 << XLEN) - 1) & res),2)
        valid = '1'

    # OR with inverted operand
    elif instr == 0b0100000_110_0110011:
        res = rs1 | ~rs2
        # Overflow condition
        res = int(bin(((1 << XLEN) - 1) & res),2)
        valid = '1'

    # Exclusive NOR
    elif instr == 0b0100000_100_0110011:
        res = ~(rs1 ^ rs2)
        # Overflow condition
        res = int(bin(((1 << XLEN) - 1) & res),2)
        valid = '1'

    # Count leading zero bits
    elif instr == 0b0110000_00000_001_0010011:
        rs1 = bin(rs1)[2:].zfill(XLEN)
        res = (rs1+'1').index('1')
        valid = '1'

    # Count leading zero bits in word
    elif instr == 0b0110000_00000_001_0011011:
        rs1 = bin(rs1)[2:].zfill(XLEN)[-32:]
        res = (rs1+'1').index('1')
        valid = '1'

    # Count trailing zero bits
    elif instr == 0b0110000_00001_001_0010011:
        rs1 = bin(rs1)[2:].zfill(XLEN)
        res = XLEN-('1'+rs1).rindex('1')
        valid = '1'

    # Count trailing zero bits in word
    elif instr == 0b0110000_00001_001_0011011:
        rs1 = bin(rs1)[2:].zfill(XLEN)[-32:]
        res = 32-('1'+rs1).rindex('1')
        valid = '1'
    
    ## logic for all other instr ends
    else:
        res = 0
        valid = '0'

    if XLEN == 32:
        result = '{:032b}'.format(res)
    elif XLEN == 64:
        result = '{:064b}'.format(res)

    return valid+result

