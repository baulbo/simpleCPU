import unittest
from assembler import assemble

def get_binary_str(instruction, in_filename="test/temp/input/example.asm", 
                   out_filename="test/temp/output/example.mem"):
    with open(in_filename, 'w') as in_fd:
        in_fd.write(instruction)

    assemble(in_filename, out_filename)

    binary_str = None
    with open(out_filename, 'r') as out_fd:
        binary_str = out_fd.readline()

    return binary_str
 
class TestRTypeInstructions(unittest.TestCase):
    """Tests for the R-Type instructions."""

    def test_add(self):
        """
        Mnemonic: ADD

        Instruction format: 0000000 rs2 rs1 000 rd 0110011
        """
        instruction = "add r3, r1, r2"
        correct_binary_str = "00000000001000001000000110110011"
        binary_str = get_binary_str(instruction=instruction)
        self.assertEqual(binary_str.strip(), correct_binary_str)

    def test_sub(self):
        """
        Mnemonic: SUB

        Instruction format: 0100000 rs2 rs1 000 rd 0110011
        """
        instruction = "sub r3, r1, r2"
        correct_binary_str = "01000000001000001000000110110011"
        binary_str = get_binary_str(instruction=instruction)
        self.assertEqual(binary_str.strip(), correct_binary_str)

    def test_and(self):
        """
        Mnemonic: AND

        Instruction format: 0000000 rs2 rs1 111 rd 0110011
        """
        instruction = "and r3, r1, r2"
        correct_binary_str = "00000000001000001111000110110011"
        binary_str = get_binary_str(instruction=instruction)
        self.assertEqual(binary_str.strip(), correct_binary_str)

    def test_or(self):
        """
        Mnemonic: OR

        Instruction format: 0000000 rs2 rs1 110 rd 0110011
        """
        instruction = "or r3, r1, r2"
        correct_binary_str = "00000000001000001110000110110011"
        binary_str = get_binary_str(instruction=instruction)
        self.assertEqual(binary_str.strip(), correct_binary_str)

    def test_slt(self):
        """
        Mnemonic: SLT

        Instruction format: 0000000 rs2 rs1 010 rd 0110011
        """
        instruction = "slt r3, r1, r2"
        correct_binary_str = "00000000001000001010000110110011"
        binary_str = get_binary_str(instruction=instruction)
        self.assertEqual(binary_str.strip(), correct_binary_str)

class TestITypeInstructions(unittest.TestCase):
    """Tests for the I-Type instructions."""

    def test_addi(self):
        """
        Mnemonic: ADDI

        Instruction format: imm[11:0] rs1 000 rd 0010011
        """
        instruction = "addi r3, r1, 12"
        correct_binary_str = "00000000110000001000000110010011"
        binary_str = get_binary_str(instruction=instruction)
        self.assertEqual(binary_str.strip(), correct_binary_str)

    def test_andi(self):
        """
        Mnemonic: ANDI

        Instruction format: imm[11:0] rs1 111 rd 0010011
        """
        instruction = "andi r3, r1, 12"
        correct_binary_str = "00000000110000001111000110010011"
        binary_str = get_binary_str(instruction=instruction)
        self.assertEqual(binary_str.strip(), correct_binary_str)

    def test_ori(self):
        """
        Mnemonic: ORI

        Instruction format: imm[11:0] rs1 110 rd 0010011
        """
        instruction = "ori r3, r1, 12"
        correct_binary_str = "00000000110000001110000110010011"
        binary_str = get_binary_str(instruction=instruction)
        self.assertEqual(binary_str.strip(), correct_binary_str)

    def test_slti(self):
        """
        Mnemonic: slti

        Instruction format: imm[11:0] rs1 110 rd 0010011
        """
        instruction = "slti r3, r1, 12"
        correct_binary_str = "00000000110000001010000110010011"
        binary_str = get_binary_str(instruction=instruction)
        self.assertEqual(binary_str.strip(), correct_binary_str)

    def test_lw(self):
        """
        Mnemonic: LW

        Instruction format: imm[11:0] rs1 000 rd 0110011
        
        """
        instruction = "lw r2, 2" # lw rd, offset (in data memory / immediate)
        correct_binary_str = "00000000001000000010000100000011"
        binary_str = get_binary_str(instruction=instruction)
        self.assertEqual(binary_str.strip(), correct_binary_str)

    def test_sw(self):
        """
        Mnemonic: SW

        Instruction format: imm[11:5] rs2 rs1 010 imm[4:0] 0100011
        
        """
        instruction = "sw r2, 2"
        correct_binary_str = "00000000001000000010000100100011"
        binary_str = get_binary_str(instruction=instruction)
        self.assertEqual(binary_str.strip(), correct_binary_str)
    

if __name__ == '__main__':
    unittest.main()