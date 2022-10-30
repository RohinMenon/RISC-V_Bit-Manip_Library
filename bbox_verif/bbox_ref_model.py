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
import math
def bbox_rm(instr, rs1, rs2, XLEN):
    
    # ADD unsigned word
    if instr == 0b0000100_000_0111011:
        res = rs2 + (rs1 & int(bin((1 << 32) - 1),2))
        # Overflow condition
        # res = int(bin(((1 << XLEN) - 1) & res),2)
        valid = '1'

    # AND with inverted operand
    elif instr == 0b0100000_111_0110011:
        res = rs1 & ~rs2
        # For DUT output
        res = int(bin(((1 << XLEN) - 1) & res),2)
        valid = '1'

    # OR with inverted operand
    elif instr == 0b0100000_110_0110011:
        res = rs1 | ~rs2
        # For DUT output
        res = int(bin(((1 << XLEN) - 1) & res),2)
        valid = '1'

    # Exclusive NOR
    elif instr == 0b0100000_100_0110011:
        res = ~(rs1 ^ rs2)
        # For DUT output
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
    
    # Count set bits
    elif instr == 0b0110000_00010_001_0010011:
        res = bin(rs1)[2:].zfill(XLEN).count("1")
        valid = '1'

    # Count set bits in word
    elif instr == 0b0110000_00010_001_0011011:
        res = bin(rs1)[2:].zfill(XLEN)[-32:].count("1")
        valid = '1'
    
    # Maximum
    elif instr == 0b0000101_110_0110011:
        s1 = ((rs1 >> (XLEN-1)) & 1)
        s2 = ((rs2 >> (XLEN-1)) & 1)

        x1 = ((-1)**s1) * ((((2**XLEN - (0^s1))^rs1)+s1) & (2**XLEN-1))
        x2 = ((-1)**s2) * ((((2**XLEN - (0^s2))^rs2)+s2) & (2**XLEN-1))

        res = max(x1,x2)
        # For DUT output
        res = int(bin(((1 << XLEN) - 1) & res),2)
        valid = '1'
    
    # Unsigned Maximum
    elif instr == 0b0000101_111_0110011:
        # To unsigned
        rs1 = int(bin(((1 << XLEN) - 1) & rs1),2)
        rs2 = int(bin(((1 << XLEN) - 1) & rs2),2)
        res = max(rs1,rs2)
        valid = '1'

    # Minimum
    elif instr == 0b0000101_100_0110011:
        s1 = ((rs1 >> (XLEN-1)) & 1)
        s2 = ((rs2 >> (XLEN-1)) & 1)

        x1 = ((-1)**s1) * ((((2**XLEN - (0^s1))^rs1)+s1) & (2**XLEN-1))
        x2 = ((-1)**s2) * ((((2**XLEN - (0^s2))^rs2)+s2) & (2**XLEN-1))

        res = min(x1,x2)
        # For DUT output
        res = int(bin(((1 << XLEN) - 1) & res),2)
        valid = '1'

    # Unsigned Minimum
    elif instr == 0b0000101_101_0110011:
        # To unsigned
        rs1 = int(bin(((1 << XLEN) - 1) & rs1),2)
        rs2 = int(bin(((1 << XLEN) - 1) & rs2),2)
        res = min(rs1,rs2)
        valid = '1'
    
    # Signed Extend Byte
    elif instr == 0b0110000_00100_001_0010011:
        sign = str((rs1 >> 7) & 1)
        res = int(bin(rs1)[-8:].rjust(XLEN,sign),2)
        valid = '1'
    
    # Signed Extend Halfword
    elif instr == 0b0110000_00101_001_0010011:
        sign = str((rs1 >> 15) & 1)
        res = int(bin(rs1)[-16:].rjust(XLEN,sign),2)
        valid = '1'
    
    # Zero Extend Halfword
    elif instr == 0b0000100_00000_100_0111011:
        res = int(bin(rs1)[-16:].zfill(XLEN),2)
        valid = '1'
    
    # Rotate Left (Register)
    elif instr == 0b0110000_001_0110011:
        rs2 = bin(rs2)[2:].zfill(XLEN)
        shift = int(rs2[-int(math.log2(XLEN)):],2)
        rs1 = bin(rs1)[2:].zfill(XLEN)

        res = int(rs1[shift:]+rs1[:shift],2)
        valid = '1'
    
    # Rotate Left Word (Register)
    elif instr == 0b0110000_001_0111011:
        rs2 = bin(rs2)[2:].zfill(XLEN)
        shift = int(rs2[-5:],2)
        rs1 = bin(rs1)[2:].zfill(XLEN)[-32:]

        res = rs1[shift:]+rs1[:shift]
        res = int(res.rjust(XLEN,res[-32]),2)
        valid = '1'
    
    # Rotate Right (Register)
    elif instr == 0b0110000_101_0110011:
        rs2 = bin(rs2)[2:].zfill(XLEN)
        shift = int(rs2[-int(math.log2(XLEN)):],2)
        rs1 = bin(rs1)[2:].zfill(XLEN)

        res = int(rs1[-shift:]+rs1[:-shift],2)
        valid = '1'

    ### Assume that the immediate is passed as the LSB log(XLEN) bits of rs2 ###

    # Rotate Right (Immediate)
    elif instr == 0b0110000_101_0010011:
        rs2 = bin(rs2)[2:].zfill(XLEN)
        shift = int(rs2[-int(math.log2(XLEN)):],2)
        rs1 = bin(rs1)[2:].zfill(XLEN)

        res = int(rs1[-shift:]+rs1[:-shift],2)
        valid = '1'

    # Rotate Right Word (Immediate)
    elif instr == 0b0110000_101_0011011:
        rs2 = bin(rs2)[2:].zfill(XLEN)
        shift = int(rs2[-5:],2)
        rs1 = bin(rs1)[2:].zfill(XLEN)[-32:]

        res = rs1[-shift:]+rs1[:-shift]
        res = int(res.rjust(XLEN,res[-32]),2)
        valid = '1'
    
    # Rotate Right Word (Register)
    elif instr == 0b0110000_101_0111011:
        rs2 = bin(rs2)[2:].zfill(XLEN)
        shift = int(rs2[-5:],2)
        rs1 = bin(rs1)[2:].zfill(XLEN)[-32:]

        res = rs1[-shift:]+rs1[:-shift]
        res = int(res.rjust(XLEN,res[-32]),2)
        valid = '1'

    # logic for all other instr ends
    else:
        res = 0
        valid = '0'

    if XLEN == 32:
        result = '{:032b}'.format(res)
    elif XLEN == 64:
        result = '{:064b}'.format(res)

    return valid+result
    