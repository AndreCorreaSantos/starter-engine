import onnx
import numpy as np


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
    def __init__(self, op_type, inputs):
        self.inputs = inputs
        self.op_type = op_type

    def Gemm(self, m, w, b):
        return np.dot(m, w.T) + b

    def Relu(self, m):
        return np.maximum(m, 0)

    def Flatten(self, m):
        return m.reshape(1, -1)

    def Add(self, m1, m2):
        return m1 + m2
    
    def ArgMax(self, m):
        return np.argmax(m)

    def execute(self):
        if self.op_type == "Flatten":
            return self.Flatten(self.inputs[0])
        elif self.op_type == "Gemm":
            return self.Gemm(self.inputs[0], self.inputs[1], self.inputs[2])
        elif self.op_type == "Relu":
            return self.Relu(self.inputs[0])
        elif self.op_type == "Add":
            return self.Add(self.inputs[0], self.inputs[1])
        elif self.op_type == "ArgMax":
            return self.ArgMax(self.inputs[0])
        else:
            raise Exception(f"Activation Function not recognized: {self.op_type}")

class StarterModel():
    def __init__(self, path, useInt=False,scaleFactor=255):
        self.cache = {}
        self.useInt = useInt
        self.scaleFactor = scaleFactor
        o_model = onnx.load(path)
        for init in o_model.graph.initializer:
            data = convert_raw_data(init)
            if self.useInt:
                self.cache[init.name] = (self.scaleFactor*data).astype(np.int32) # scaling constants
            else:
                self.cache[init.name] = data 
        self.nodes = o_model.graph.node

    def infer(self, input):
        for i, nd in enumerate(self.nodes):
            if i == 0:
                self.cache[nd.input[0]] = input
            inputs = [self.cache[inp] for inp in nd.input]
            n_obj = Node(nd.op_type, inputs)
            if self.useInt:
                self.cache[nd.output[0]] = (n_obj.execute()).astype(np.int32)
            else:
                self.cache[nd.output[0]] = n_obj.execute()
            out = nd.output[0]
        return self.cache[out]
    

