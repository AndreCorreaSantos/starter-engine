mlirmlirmlirmlirmlirmlirmlirmlirmlir%.Flatten_output_0 = "engine.flatten"(%onnx::Flatten_0) : (memref<784xf64>) -> memref<784xf64> 
%.fc1.Gemm_output_0_int = "engine.matmul"(%.Flatten_output_0,%fc1.weight) : (memref<784xf64>,memref<5x784xf64>) -> memref<5xf64>
%.fc1.Gemm_output_0 = "engine.add"(%.fc1.Gemm_output_0_int,%fc1.bias) : (memref<5xf64>,memref<5xf64>) -> memref<5xf64>
%.Relu_output_0 = "engine.relu"(%.fc1.Gemm_output_0) : (memref<5xf64>) -> memref<5xf64> 
%.fc2_left2.Gemm_output_0_int = "engine.matmul"(%.Relu_output_0,%fc2_left2.weight) : (memref<5xf64>,memref<5x5xf64>) -> memref<5xf64>
%.fc2_left2.Gemm_output_0 = "engine.add"(%.fc2_left2.Gemm_output_0_int,%fc2_left2.bias) : (memref<5xf64>,memref<5xf64>) -> memref<5xf64>
%.Relu_1_output_0 = "engine.relu"(%.fc2_left2.Gemm_output_0) : (memref<5xf64>) -> memref<5xf64> 
%.fc2_right.Gemm_output_0_int = "engine.matmul"(%.Relu_output_0,%fc2_right.weight) : (memref<5xf64>,memref<5x5xf64>) -> memref<5xf64>
%.fc2_right.Gemm_output_0 = "engine.add"(%.fc2_right.Gemm_output_0_int,%fc2_right.bias) : (memref<5xf64>,memref<5xf64>) -> memref<5xf64>
%.Relu_2_output_0 = "engine.relu"(%.fc2_right.Gemm_output_0) : (memref<5xf64>) -> memref<5xf64> 
%.Add_output_0 = "engine.add"(%.Relu_1_output_0,%.Relu_2_output_0) : (memref<5xf64>,memref<5xf64>) -> memref<5xf64> 
%17_int = "engine.matmul"(%.Add_output_0,%fc3.weight) : (memref<5xf64>,memref<10x5xf64>) -> memref<10xf64>
%17 = "engine.add"(%17_int,%fc3.bias) : (memref<10xf64>,memref<10xf64>) -> memref<10xf64>
