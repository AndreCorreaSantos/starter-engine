import onnx
import numpy as np

def print_shape(array):
    return np.array2string(array, separator=', ', formatter={'float_kind': lambda x: f'{x:.1f}'}, max_line_width=np.inf).replace("\n","")

def convert_raw_data(initializer):
    data_type = initializer.data_type
    if data_type == onnx.TensorProto.FLOAT:
        return np.frombuffer(initializer.raw_data, dtype=np.float32).reshape(initializer.dims)
    elif data_type == onnx.TensorProto.INT32:
        return np.frombuffer(initializer.raw_data, dtype=np.int32).reshape(initializer.dims)
    elif data_type == onnx.TensorProto.INT64:
        return np.frombuffer(initializer.raw_data, dtype=np.int64).reshape(initializer.dims)
    else:
        raise ValueError(f"Unsupported data type: {data_type}")
    
def write_data(path, model):
    with open(path, "w+") as f:
        for i in model.graph.initializer:
            data = convert_raw_data(i)
            f.write(f'{i.name} {data.shape}\n')
            flat_data = data.flatten()[None, :]
            np.savetxt(f, flat_data, fmt='%s', delimiter=' ', newline='')
            f.write('\n')
        f.write("| \n")
        for i in model.graph.node:
            f.write(f"{i.op_type}\n")
            f.write(f"{' '.join(i.output)}\n")
            f.write(f"{' '.join(i.input)}\n")



class Node():
    def __init__(self, op_type, inputs, output):
        self.inputs = inputs
        self.output = output
        self.op_type = op_type

    def Gemm(self, m, w, b, cache): # m, w and b will be their respective names

        shape1 = cache[m]
        shape2 = cache[w]
        print("sh1",shape1)
        print("sh2",shape2)
        result_shape = shape1 #COME BACK HERE LATER AND INFER THIS SHAPE CORRECTLY
        mlir = f"%{self.output}_int = \"engine.matmul\"(%{m},%{w}) : (memref<{shape1}>,memref<{shape2}>) -> memref<{result_shape}>\n" # matmul with weights
        shape3 = cache[b]
        mlir += f"%{self.output} = \"engine.add\"(%{self.output}_int,%{b}) : (memref<{result_shape}>,memref<{shape3}>) -> memref<{result_shape}>\n" # add bias | Addition preserves input shapes.

        # set resulting tensor shape in the cache
        cache[self.output] = result_shape
        return mlir
       # return np.dot(m, w.T) + b

    def Relu(self, m, cache):
        shape1 = cache[m]
        result_shape = shape1  # Relu Preserves input shapes
        # set resulting tensor shape in the cache
        cache[self.output] = result_shape
        return f"%{self.output} = \"engine.relu\"(%{m}) : (memref<{shape1}>) -> memref<{result_shape}> \n"
       # return np.maximum(m, 0)

    def Flatten(self, m, cache):
        return "to be implemented (FLATTEN) \n"
       # return m.reshape(1, -1)

    def Add(self, m1, m2, cache):
        shape1 = cache[m1]
        shape2 = cache[m2]
        result_shape = shape1 #Addition preserveds input shapes
        # set resulting tensor shape in the cache
        cache[self.output] = result_shape
        return f"%{self.output} = \"engine.add\"(%{m1},%{m2}) : (memref<{shape1}>,memref<{shape2}>) -> memref<{result_shape}> \n"
       # return m1 + m2

    def execute(self, cache):
        if self.op_type == "Flatten":
            return self.Flatten(self.inputs[0],cache)
        elif self.op_type == "Gemm":
            return self.Gemm(self.inputs[0], self.inputs[1], self.inputs[2],cache)
        elif self.op_type == "Relu":
            return self.Relu(self.inputs[0],cache)
        elif self.op_type == "Add":
            return self.Add(self.inputs[0], self.inputs[1], cache)
        else:
            raise Exception(f"Activation Function not recognized: {self.op_type}")

class Model():
    def __init__(self, path):
        self.cache = {}
        o_model = onnx.load(path)
        for init in o_model.graph.initializer:
            data = convert_raw_data(init)
            self.cache[init.name] = data
        self.nodes = o_model.graph.node

    def load_constant(self, input, name,cache):
        shape = ""
        for i in range(0,len(input.shape)):
            shape += f"{i}x"
        shape += "f64"
        data = print_shape(input)
        print(shape)
        cache[name] = "a"
        mlir = f"%{name} = \"engine.constant\"() {{value=dense<{data}>:tensor<{shape}}}> \n"
        return mlir

    def translate(self, input):
        result = ""
        for i, nd in enumerate(self.nodes):
            if i == 0:
                result += self.load_constant(input, nd.input[0],self.cache)
            # print(self.cache)
            n_obj = Node(nd.op_type, nd.input, nd.output[0])
            result += n_obj.execute(self.cache)

        return result
    


    # PASSAR AST PARA MINHA LINGUAGEM 
    #


mod = Model("train/mnist_ffn_complex.onnx")
with open("output.mlir", "w+") as f:
    f.write(mod.translate(np.random.rand(1, 784).astype(np.float32)))

