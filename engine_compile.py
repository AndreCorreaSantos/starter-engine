import onnx
import numpy as np

def remove_illegals(result):
    return result.replace("/",".").replace("::",".")

def print_shape(array):
    result =""
    for dim in array:
        result += str(dim) + "x"
    result += "f64"
    return result

def print_data(array):
    return np.array2string(array, separator=', ', formatter={'float_kind': lambda x: f'{x:.1f}'}, max_line_width=np.inf,threshold=array.size).replace("\n","")

def get_matmul_shape(shape1, shape2):
    t1 = np.zeros(shape1)
    t2 = np.zeros(shape2).T
    result = np.matmul(t1, t2)
    return result.shape

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
        self.inputs = ["_"+i for i in inputs] # last two layers give SSA errors without _ prefix dont know why.
        self.output = "_"+output
        self.op_type = op_type
    def Gemm(self, m, w, b, cache): # m, w and b will be their respective names
        shape1 = print_shape(cache[m])
        shape2 = print_shape(cache[w])
        r_shape = get_matmul_shape(cache[m], cache[w])
        cache[self.output] = r_shape
        result_shape = print_shape(r_shape)
        mlir = f"%{self.output}_int = \"engine.matmul\"(%{w},%{m}) : (memref<{shape2}>,memref<{shape1}>) -> memref<{result_shape}>\n" # matmul with weights
        mlir += f"%{self.output} = \"engine.add\"(%{self.output}_int,%{b}) : (memref<{result_shape}>,memref<{result_shape}>) -> memref<{result_shape}>\n" # add bias | Addition preserves input shapes.
        return mlir

    def Relu(self, m, cache):
        cache[self.output] = cache[m]
        sh = print_shape(cache[m])
        return f"%{self.output} = \"engine.relu\"(%{m}) : (memref<{sh}>) -> memref<{sh}> \n"

    def Flatten(self, m, cache):
        # flatten shape
        shape = 1
        for i in cache[m]:
            shape *= i
        cache[self.output] = (784,)
        sh = print_shape((shape,))
        return f"%{self.output} = \"engine.flatten\"(%{m}) : (memref<{sh}>) -> memref<{sh}> \n"

    def Add(self, m1, m2, cache):
        cache[self.output] = cache[m1]
        sh = print_shape(cache[m1])
        return f"%{self.output} = \"engine.add\"(%{m1},%{m2}) : (memref<{sh}>,memref<{sh}>) -> memref<{sh}> \n"
    
    def ArgMax(self, m, cache):
        cache[self.output] = (1,)
        sh1 = print_shape(cache[m])
        sh2 = print_shape((1,))
        return f"%{self.output} = \"engine.argmax\"(%{m}) : (memref<{sh1}>) -> memref<{sh2}> \n"

    def execute(self, cache):
        if self.op_type == "Flatten":
            return self.Flatten(self.inputs[0],cache)
        elif self.op_type == "Gemm":
            return self.Gemm(self.inputs[0], self.inputs[1], self.inputs[2],cache)
        elif self.op_type == "Relu":
            return self.Relu(self.inputs[0],cache)
        elif self.op_type == "Add":
            return self.Add(self.inputs[0], self.inputs[1], cache)
        elif self.op_type == "ArgMax":
            return self.ArgMax(self.inputs[0], cache)
        else:
            raise Exception(f"Activation Function not recognized: {self.op_type}")

class Model():
    def __init__(self, path):
        self.cache = {} # cache to store tensor {name: shape}
        o_model = onnx.load(path)
        self.initializers = o_model.graph.initializer # weights and biases
        self.nodes = o_model.graph.node # layers
        self.result = "" # final mlir code

    def init_model(self):
        for init in self.initializers:
            data = convert_raw_data(init)
            self.result += self.load_constant(data, "_"+init.name) # doing this for same reason as in Node class
            
    def load_constant(self, input, name):
        shape = print_shape(input.shape)
        data = print_data(input)
        self.cache[name] = input.shape
        mlir = f"%{name} = \"engine.constant\"() {{value=dense<{data}>:tensor<{shape}>}} : () -> memref<{shape}>\n"
        return mlir
 
    def translate(self, input):
        for i, nd in enumerate(self.nodes):
            if i == 0:
                self.result += self.load_constant(input, "_"+nd.input[0]) # "_" same reason as in Node class
            n_obj = Node(nd.op_type, nd.input, nd.output[0])
            self.result += n_obj.execute(self.cache)

        

        header = "module {\nfunc.func @main() {\n"
        footer = "return\n}\n}"
        result_name = nd.output[0]
        result_shape = print_shape(self.cache["_"+result_name])
        print_result = f"\"engine.print\"(%_{result_name}) : (memref<{result_shape}>) -> ()\n"

        return header + remove_illegals(self.result)+print_result+ footer



