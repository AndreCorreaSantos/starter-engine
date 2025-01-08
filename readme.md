# ONNX to FPGA

This repository contains an exploration into lowering ONNX models into LLVM and VHDL with the overarching goal of running the models in FPGAs. The project was developed as a learning exercise to familiarize myself with modern compiler tools such as MLIR, understand the fundamental principles behind inference engines, and explore hardware synthesis frameworks like CIRCT. Note that the code is not optimized.

Currently, the project can compile a very simple ONNX model containing only **GEMM**, **Flatten**, and **ReLU** operations into a custom "Engine" dialect. This dialect is defined in MLIR and represents these high-level operations. Also, as the ONNX was the starting point for the project, no changes were made to the compute AST as it is already sorted in the correct order for the model's execution.

## Project Vision

The envisioned plan for this project is illustrated below:  
![Project Overview](project-Page-1.drawio(1).png)

## Progress and Context

For reference, the generated code at each step looks like this:

#### Pytorch Model:

``` python
class Net(nn.Module):
    def __init__(self):
        super().__init__()
        self.fc1 = nn.Linear(28*28, 5)
        self.fc2_left2 = nn.Linear(5, 5)
        self.fc2_right = nn.Linear(5, 5)
        self.fc3 = nn.Linear(5, 10)

    def forward(self, x):
        x = torch.flatten(x, 1)
        x = torch.relu(self.fc1(x))
        left = torch.relu(self.fc2_left2(x))
        right = torch.relu(self.fc2_right(x))
        x = torch.add(left, right)
        x = self.fc3(x)
        return x
```

#### Engine dialect MLIR

``` mlir
module {
func.func @main() {
%_fc1.weight = "engine.constant"() {value=dense<[[-0.0, ... 0.0 ]]>:tensor<5x784xf64>} : () -> memref<5x784xf64>
%_fc1.bias = "engine.constant"() {value=dense<[0.0, -0.2, 0.3, 0.5, 0.2]>:tensor<5xf64>} : () -> memref<5xf64>
%_fc2_left2.weight = "engine.constant"() {value=dense<[[0.8, 0.4, -0.5, 0.3, 0.2], [0.6, 0.1, -0.3, 1.1, -0.9], [-0.1, -0.6, 0.8, 1.0, 0.2], [1.0, -0.2, 0.7, -0.6, -0.6], [-0.3, 1.5, 1.0, -0.0, 0.2]]>:tensor<5x5xf64>} : () -> memref<5x5xf64>
%_fc2_left2.bias = "engine.constant"() {value=dense<[0.3, -0.1, 0.0, -0.2, 0.2]>:tensor<5xf64>} : () -> memref<5xf64>
%_fc2_right.weight = "engine.constant"() {value=dense<[[0.8, 0.3, -0.4, 0.2, 0.8], [-0.2, -0.0, -0.2, -0.1, 0.1], [-0.4, -0.2, 0.5, 1.0, 0.3], [1.0, -0.5, 0.7, -0.3, -0.7], [-0.3, 0.1, -0.2, -0.2, -0.1]]>:tensor<5x5xf64>} : () -> memref<5x5xf64>
%_fc2_right.bias = "engine.constant"() {value=dense<[0.0, -0.1, -0.1, 0.1, 0.0]>:tensor<5xf64>} : () -> memref<5xf64>
%_fc3.weight = "engine.constant"() {value=dense<[[-0.0, 0.7, 0.5, 0.4, -1.4], [-0.4, -0.3, -0.8, 0.2, 1.1], [-0.0, -0.6, -0.5, 1.1, 0.1], [-0.3, -0.5, 0.2, 0.8, 0.2], [0.7, -0.5, 0.1, -1.3, 0.3], [0.1, 0.7, 0.2, 0.1, -0.2], [1.0, -0.1, -0.8, -0.1, -0.4], [-1.2, -0.4, 1.0, -0.3, 0.3], [-0.1, 0.8, -0.4, 0.2, 0.5], [-0.3, 0.2, 0.5, -0.6, 0.5]]>:tensor<10x5xf64>} : () -> memref<10x5xf64>
%_fc3.bias = "engine.constant"() {value=dense<[-1.0, 0.8, 0.3, -0.1, -0.1, 0.1, 0.1, 0.2, -0.7, 0.0]>:tensor<10xf64>} : () -> memref<10xf64>
%_onnx.Flatten_0 = "engine.constant"() {value=dense<[0.0, ... 0.0]>:tensor<784xf64>} : () -> memref<784xf64>
%_.Flatten_output_0 = "engine.flatten"(%_onnx.Flatten_0) : (memref<784xf64>) -> memref<784xf64> 
%_.fc1.Gemm_output_0_int = "engine.matmul"(%_fc1.weight,%_.Flatten_output_0) : (memref<5x784xf64>,memref<784xf64>) -> memref<5xf64>
%_.fc1.Gemm_output_0 = "engine.add"(%_.fc1.Gemm_output_0_int,%_fc1.bias) : (memref<5xf64>,memref<5xf64>) -> memref<5xf64>
%_.Relu_output_0 = "engine.relu"(%_.fc1.Gemm_output_0) : (memref<5xf64>) -> memref<5xf64> 
%_.fc2_left2.Gemm_output_0_int = "engine.matmul"(%_fc2_left2.weight,%_.Relu_output_0) : (memref<5x5xf64>,memref<5xf64>) -> memref<5xf64>
%_.fc2_left2.Gemm_output_0 = "engine.add"(%_.fc2_left2.Gemm_output_0_int,%_fc2_left2.bias) : (memref<5xf64>,memref<5xf64>) -> memref<5xf64>
%_.Relu_1_output_0 = "engine.relu"(%_.fc2_left2.Gemm_output_0) : (memref<5xf64>) -> memref<5xf64> 
%_.fc2_right.Gemm_output_0_int = "engine.matmul"(%_fc2_right.weight,%_.Relu_output_0) : (memref<5x5xf64>,memref<5xf64>) -> memref<5xf64>
%_.fc2_right.Gemm_output_0 = "engine.add"(%_.fc2_right.Gemm_output_0_int,%_fc2_right.bias) : (memref<5xf64>,memref<5xf64>) -> memref<5xf64>
%_.Relu_2_output_0 = "engine.relu"(%_.fc2_right.Gemm_output_0) : (memref<5xf64>) -> memref<5xf64> 
%_.Add_output_0 = "engine.add"(%_.Relu_1_output_0,%_.Relu_2_output_0) : (memref<5xf64>,memref<5xf64>) -> memref<5xf64> 
%_17_int = "engine.matmul"(%_fc3.weight,%_.Add_output_0) : (memref<10x5xf64>,memref<5xf64>) -> memref<10xf64>
%_17 = "engine.add"(%_17_int,%_fc3.bias) : (memref<10xf64>,memref<10xf64>) -> memref<10xf64>
"engine.print"(%_17) : (memref<10xf64>) -> ()
return
}
}
```

#### Lowering to LLVM

The output from each of the passes needed to lower the "engine" dialect's operations into LLVM can be seen in:

[log.mlir](./engineDialect/log.mlir)

#### Disclaimer
This project was greatly inspired by this article: [build-your-own-inference-engine](https://michalpitr.substack.com/p/build-your-own-inference-engine-from), the neural network is the same as seen on the article, and I started the project after building a very simple inference engine in python just after reading the article.
