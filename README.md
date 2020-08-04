This project contains the source files for a number of phase-decoupled click-based asynchronous components, as well as two example circuits built from them (Fibonacci implementation and GCD implementation). Both implementations have been run and tested on the Nexys4DDR FPGA board. The source files for the asynchronous components can be imported from the /src directory and used directly for implementation on an FPGA board. The /src directory also contains schematics of the implemented components (with the same name as the corresponding source file). 

    .
    ├── src 
    │   ├── components              # Implemented components as described in [1]
    │   │   └── diagrams            # Diagrams of the implemented components
    │   ├── examples                # Implementation, top modules and test benches for Fibonacci and GCD circuits
    │   │   └── simulation_results  # Waveform configurations and waveform snippets for the implemented examples
    │   ├── funcblocks              # Function blocks used for the Fibonacci and GCD circuits (combinational logic + delay)
    │   └── misc                    # Definition file for global parameters; button and switch debouncers used in the examples
    └── README.md

# Running the Fibonacci circuit:
The fibonacci circuit can be run on a Nexys4DDR FPGA simply by importing the source files into a project. The top module for synthesis is called Fib_top.vhd and the testbench for the circuit is Fibonacci_tb. For the Fibonacci circuit, the constraint file can be found in src/Nexys4DDR-Fib.xdc. 

The following sequence of steps need to be performed to correctly initialize the circuit (the instructions assume a Nexys4DDR board):
1. Set the reset signal (SW[1] - L16) to low.
2. Set the start signal (SW[0] - J15) to high (this allows the request signal to propagate to the next component).

At this point the circuit is initialized. The output of the Fibonacci circuit can be seen on the LEDs above the switches (LD[15..0]). The output request signal can be seen on the red LED (LD17) - ON for '1' and OFF for '0'. The respective acknowledgement signal can be controlled from switch SW[15] (V10). After the initial steps, the LEDs output a new value for every toggle of the acknowledgement switch.

To safely reset the circuit to its initial state, the reset signal (SW[1]) needs to be toggled ON and the start signal (SW[0]) needs to be toggled OFF. Normal operation can be resumed again after following the first two steps.

# Running the GCD circuit:
Setting up the GCD example for synthesis and simulation follows the same steps as for the Fibonacci circuit. The top module and testbench are called GCD_top.vhd and GCD_tb.vhd respectively. A separate constraint file is provided in src/Nexys4-GCD.xdc.

1. The operands are inserted from the switches (SW[7..0] for operand 1 and SW[15..8] for operand 2).
2. The reset signal is toggled by button BTNC (N17). The current status of the reset line is visible on LD[15].
3. After the reset is brought low, the circuit is started by toggling the request signal on the input channel - BTNL (P17), the status of which can be seen on LD[14].
4. Acknowledging the resulting token is done by toggling the acknowledge signal on the output channel - BTNR (M17), the status of which can be seen on LD[13].

The result is mapped to LD[7..0]. LD16 shows the acknowledge signal on the input channel and LD17 shows the request signal on the output channel.

# Citation
If you use any part of this code in your research, please cite our paper:

```
@inproceedings{async19clickdesign,
author = {Mardari, Adrian and Jelcicova, Zuzana and Sparso, Jens},
year = {2019},
month = {05},
pages = {9-18},
title = {Design and FPGA-implementation of Asynchronous Circuits Using Two-Phase Handshaking},
doi = {10.1109/ASYNC.2019.00010}
}
```


### References
1. Adrian Mardari, Zuzana Jelcicová and Jens Sparsø. Design and FPGA-implementation of Asynchronous Circuits Using Two-phase Handshaking.
