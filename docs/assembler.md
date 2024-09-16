# Assembler Documentation

## Examples

Assembling the assembly file `example.asm` and writing the machine code to a memory file called `example.mem`.

```sh
python assembler.py -i input/example.asm -o output/example.mem
```

**Input file**: `example.asm`

```asm
add r3, r1, r2
addi r3, r1, 12
```

**Output file**: `example.mem`
```txt
00000000001000001000000110110011
00000000110000001000000110110011
```

## Running Tests

```sh
python unit_test_assembler.py  -v
```

Should output in case you only have two tests

```sh
test_add (__main__.TestRTypeInstructions.test_add) ... ok
test_addi (__main__.TestRTypeInstructions.test_addi) ... ok

----------------------------------------------------------------------
Ran 2 tests in 0.001s

OK
```