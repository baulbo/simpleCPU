"""

Does not support ___

    * comments, i.e., not '#' or ';'
    * upper case mnemonics
    * etc... 
"""
import argparse

def decode_asm_instruction(instruction) -> list:
    """Decodes assembly instruction to binary representation (machine code) string"""
    instruction = instruction.replace(',', '')
    # remove all whitespace characters by splitting, rejoining, and splitting again
    tokens = ' '.join(instruction.split(' ')).split(' ') 

    if tokens[0] in ["", "\n"]:
        # empty line => don't compile
        return 

    # intialize to be parsed variables
    opcode = ''
    func3 = ''
    rd = ''
    rs2 = ''
    rs1 = ''
    imm = ''
    func7 = ''
    # R-type
    if tokens[0] == "add":
        opcode = '0110011'
        func3 = '000'
        rd = format(int(tokens[1][1:]), "05b")
        rs1 = format(int(tokens[2][1:]), "05b")
        rs2 = format(int(tokens[3][1:]), "05b")
        func7 = '0000000'

    elif tokens[0] == "sub":
        opcode = '0110011'
        func3 = '000'
        rd = format(int(tokens[1][1:]), "05b")
        rs1 = format(int(tokens[2][1:]), "05b")
        rs2 = format(int(tokens[3][1:]), "05b")
        func7 = '0100000'

    elif tokens[0] == "and":
        opcode = '0110011'
        func3 = '111'
        rd = format(int(tokens[1][1:]), "05b")
        rs1 = format(int(tokens[2][1:]), "05b")
        rs2 = format(int(tokens[3][1:]), "05b")
        func7 = '0000000'

    elif tokens[0] == "or":
        opcode = '0110011'
        func3 = '110'
        rd = format(int(tokens[1][1:]), "05b")
        rs1 = format(int(tokens[2][1:]), "05b")
        rs2 = format(int(tokens[3][1:]), "05b")
        func7 = '0000000'

    elif tokens[0] == "slt":
        opcode = '0110011'
        func3 = '010'
        rd = format(int(tokens[1][1:]), "05b")
        rs1 = format(int(tokens[2][1:]), "05b")
        rs2 = format(int(tokens[3][1:]), "05b")
        func7 = '0000000'


    # I-type
    elif tokens[0] == "addi":
        opcode = '0010011'
        func3 = '000'
        rd = format(int(tokens[1][1:]), "05b")
        rs1 = format(int(tokens[2][1:]), "05b")
        imm = format(int(tokens[3][0:]), "012b")

    elif tokens[0] == "andi":
        opcode = '0010011'
        func3 = '111'
        rd = format(int(tokens[1][1:]), "05b")
        rs1 = format(int(tokens[2][1:]), "05b")
        imm = format(int(tokens[3][0:]), "012b")

    elif tokens[0] == "ori":
        opcode = '0010011'
        func3 = '110'
        rd = format(int(tokens[1][1:]), "05b")
        rs1 = format(int(tokens[2][1:]), "05b")
        imm = format(int(tokens[3][0:]), "012b")
    
    elif tokens[0] == "slti":
        opcode = '0010011'
        func3 = '010'
        rd = format(int(tokens[1][1:]), "05b")
        rs1 = format(int(tokens[2][1:]), "05b")
        imm = format(int(tokens[3][0:]), "012b")
    
    elif tokens[0] == "lw": 
        opcode = '0000011'
        func3 = '010'
        rd = format(int(tokens[1][1:]), "05b")
        # NOTE: rs1 refers to the register in reg file holding the base address, we just refer to x0 because it's always 32'b0.
        rs1 = format(0, "05b") 
        imm = format(int(tokens[2][0:]), "012b")
  
    elif tokens[0] == "sw": 
        """
        Notes:
            rs2: should output the register's value you want to store in data memory
            rs1: is the base address, i.e., zero in our case from which we take the offset using the immediate
            imm: the offset in data memory to store rs2's value
        """
        opcode = '0100011'
        func3 = '010'
        # NOTE: rs1 refers to the register in reg file holding the base address, we just refer to x0 because it's always 32'b0.
        rs1 = format(0, "05b")
        rs2 = format(int(tokens[1][1:]), "05b")
        imm_temp = format(int(tokens[2][0:]), "012b")
        rd = imm_temp[7:12]
        imm = imm_temp[0:7]
 
    return [func7, imm, rs2, rs1, func3, rd, opcode]
        
def compile_asm(in_fd):
    instr_lines = in_fd.readlines()
    bin_str = ''
    if len(instr_lines) > 0:
        decodings = decode_asm_instruction(instruction=instr_lines[0])
        bin_str += ''.join(decodings) 
    for l in instr_lines[1:]:
        decodings = decode_asm_instruction(instruction=l)
        bin_str += '\n' + ''.join(decodings) 
    return bin_str

def assemble(in_filename, out_filename):
    # open the input (.asm) & out (.bin) file given as argument
    in_fd  = open(in_filename, 'r')
    out_fd = open(out_filename, 'w')

    # compilation of assembly (.asm) to machine code (.bin)
    bin_str = compile_asm(in_fd)
    out_fd.write(bin_str)

    in_fd.close()
    out_fd.close()

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-i", "--input", help="the input .asm file", type=str, required=True)
    parser.add_argument("-o", "--output", help="the output .mem filename", type=str, required=True)
    args = parser.parse_args() 

    assemble(in_filename=args.input,
             out_filename=args.output)
