# P_Libasm

Assembly yourself!

The aim of this project is to become familiar with assembly language.

## Project Overview

P_Libasm is an educational project focused on implementing fundamental C library functions using x86-64 assembly language (System V AMD64 ABI, Linux). The project helps you to understand how low-level operations work by re-creating standard C functions in assembly, and provides a practical introduction to register usage, the calling convention, and stack management.

## Features

- Implementation of several standard C library functions in assembly (such as `strlen`, `strcpy`, `strcmp`, `write`, `read`, `strdup`, and others).
- Demonstrates proper use of x86-64 registers (including caller-saved and callee-saved registers).
- Shows how to manage the stack and pass arguments to functions in assembly.
- Practice with string and memory operations at a low level.
- Includes C test code (`main.c`) to validate the assembly implementations.

## Getting Started

### Prerequisites

- GCC or Clang (with NASM/YASM assembler support)
- Linux x86-64 environment

### Building

1. Clone the repository:
   ```sh
   git clone https://github.com/OnnaMcadva/P_Libasm.git
   cd P_Libasm
   ```
2. Build the assembly library and test program (example, may require adaptation based on actual Makefile or build scripts):
   ```sh
   make
   ```

### Running

- Run the test program to verify the implemented functions:
  ```sh
  ./main
  ```

## Project Structure

- `src/` — Assembly source files implementing C library functions.
- `main.c` — Test suite to check the correctness of your assembly routines.
- `crib.md` — Cheat sheet with x86-64 register details, calling convention notes, and assembly tips.
- `README.md` — Project overview and instructions.

## Key Concepts Covered

- **Registers**: Understanding and using general-purpose and special-purpose registers (RAX, RBX, RCX, etc.).
- **Calling Convention**: Correctly saving/restoring caller/callee-saved registers, passing function arguments, and returning values.
- **Stack Management**: Pushing and popping values, managing local variables.
- **String and Memory Operations**: Efficient manipulation of data at the byte and word level.
- **Flags and Control**: Using processor flags and instructions for low-level control.

## Example: Register Cheat Sheet

A detailed cheat sheet (`crib.md`) is included, covering:

- Which registers are caller-saved/callee-saved.
- Typical usage patterns for each register.
- How to save/restore registers when calling or writing functions.
- Byte/word/dword/qword register parts and their usage.

## License

This project is for educational purposes.

---
Happy hacking in assembly!
