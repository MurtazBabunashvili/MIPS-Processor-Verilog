# MIPS Processor Implementation in Verilog

## Overview

This project focuses on the design and implementation of a MIPS processor using Verilog as part of the Computer Architecture Laboratory. The objective was not only to build processor capable of executing basic MIPS instructions, but also to understand how fundamental hardware components interact within a processor architecture. Rather than relying on prebuilt cores, every module was written from scratch — from the ALU and register file to the instruction decoder, memory units, and control flow logic. Working on this project helped me clearly understand the main ideas behind how instructions run, how the datapath works, and how processors are designed.

The instruction memory was initialized using a .txt file, allowing the simulation to run a fixed program step-by-step. On each clock cycle, the processor fetches the current instruction, decodes it, computes ALU or memory operations as needed, and writes back to the register file. Support for jump, branch, shift, arithmetic, logical, and memory instructions was implemented, ensuring broad coverage of the instruction set used in the lab exercises.

The simulation environment was created using ModelSim. A custom testbench was written to apply the clock and reset signals and monitor key datapath values such as the PC, instruction, ALU result, shift output, and register writeback data. The test program contained a mix of instructions to verify that all modules interacted correctly and that control signals were generated as expected.

This implementation follows well-known academic sources like 'Computer Organization and Design' by David A. Patterson and John L. Hennessy, which explains MIPS instructions and processor structure in detail. It also takes design ideas from Wolfgang J. Paul's 'System Architecture', which looks at processor parts as precise, engineerable modules.

## Project Structure

```
MIPS-Processor-Verilog/
├── src/
│   ├── MIPS_Processor.v
│   ├── InstructionDecoder.v
│   ├── GP.v
│   ├── ALU.v
│   ├── SignalExtension.v
│   ├── Shifter.v
│   ├── BCE.v
│   └── Memory.v
├── testbench/
│   └── testbench.v
├── instructions/
│   └── Instructions.txt
└── docs/
    └── MIPS_Processor_Implementation_Report.pdf
```

## Getting Started

### Prerequisites
- ModelSim or any Verilog simulator
- (Optional) FPGA development board for hardware deployment

### Running Simulation

1. Clone this repository
2. Update the file path in `Memory.v` to point to your `Instructions.txt` location
3. Compile all Verilog files in your simulator
4. Run the testbench
5. Observe the simulation results

## Author

**Murtaz Babunashvili**  
Kutaisi International University  
Computer Architecture Laboratory  
Submission Date: 30.06.2025

## References

1. Wolfgang J. Paul, Christoph Baumann, Petro Lutsyk, Sabine Schmaltz, 'System Architecture: An Ordinary Engineering Discipline', Springer, 2016.
2. David A. Patterson, John L. Hennessy, 'Computer Organization and Design: The Hardware/Software Interface', 5th Edition.

## License

This project is available for educational purposes.
