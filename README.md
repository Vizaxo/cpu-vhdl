[![Build Status](https://travis-ci.com/Vizaxo/cpu-vhdl.svg?branch=master)](https://travis-ci.com/Vizaxo/cpu-vhdl)

# CPU-VHDL

Learning VHDL with the goal of learning how to design CPUs.

## Building

### Requirements

- [nvc](https://github.com/nickg/nvc) VHDL compiler and simulator

  It's likely any other VHDL compiler would work, but this is the one I'm testing against.

- [gnu make](https://www.gnu.org/software/make/)

### Running tests

```bash
make test
```
Will run the tests defined in `testbench.vhd`.

## Licence

This project is licenced under the GNU General Public License Version 3 (GPLv3). A copy of the licence text is provided in the LICENSE file.

## Inspiration/resources

- [nand2tetris](https://www.nand2tetris.org/) and [The Elements of Computing Systems](https://www.nand2tetris.org/book) by Noam Nisan and Shimon Schocken

  This is a fantastic course and book for learning how computers work, from the basic logic gates to running high-level programs. I've done the hardware part of the course in the supplied HDL language; this VHDL project will probably follow a similar structure.

- [Ben Eater - Buliding an 8-bit breadboard computer!](https://www.youtube.com/playlist?list=PLowKtXNTBypGqImE405J2565dvjafglHU)

  A great series following the development of a CPU made out of real logic chips and breadboard components, with in-depth explanations of how each of the parts work.
