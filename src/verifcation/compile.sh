# Assemble
python ../assembler/assembler.py -i ../assembler/input/example.asm -o ../assembler/output/example.mem

# Compile with iverilog
rm dsn test.vcd
iverilog -g 2012 -o dsn -c file_list.txt

# Run
vvp dsn

# open wave file with GTKWave
gtkwave test.vcd &
