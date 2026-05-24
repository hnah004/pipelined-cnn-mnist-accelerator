*old project uploaded recently*

# pipelined-cnn-mnist-accelerator
Pipelined CNN hardware accelerator in Verilog with 25× throughput improvement.

The baseline was adapted from: https://github.com/boaaaang/CNN-Implementation-in-Verilog

![](docs/architecture.png)

- 8-bit fixed point integer (Q1.7)
- Number of parameters: 796
- Dataset: MNIST
- Accuracy: 96%

## Block Diagram and Simulation Results

![](docs/block_diagram.png)

## Implementation Results

- Target board: PYNQ-Z2
- Using Vivado

![](docs/imp_result_1.png)

## Proposed Idea

![](docs/idea.png)

## Pipeline Architecture

![](docs/pipeline.png)

## Simulation after pipeline
- Processing: 1334 cycles -> 1349 cycles

![](docs/sim_pipeline.png)

## Implementation after pipeline

![](docs/imp_pipe.png)




