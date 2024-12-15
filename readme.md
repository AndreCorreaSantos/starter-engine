### AST !!!

- parse model.graph.initializers into c++
- parse model.graph.nodes into c++

SAVE INTO TXT FILE:

--------INITIALIZERS--------- (both weights and biases are here)

name
data

-----------------------------

-----------NODES-------------
name
inputs
output
op_type

-------------------------------



#### Current Logic:

- loop over initialzers and set them in cache with their names 
- each node needs: [str] inputs, str output, str op_type
 operation consists of:

``` python
def Node(inputs,output, op_type):
    inputs = [cache[i] for i in inputs] # get weights, biases and inputs from previous layers
    result = execute(inputs,op_type) # compute resulting tensor for this layer
    cache[output] = result # save current tensor on global hashmap
```


#### Python to C++ grammar

``` ebnf
onnx= {initializer},newline,{node};
initializer = string,tuple,newline,{float};
node = ;
```

PARSER NEEDS TO:
1)  CREATE SEVERAL INITIALIZER DEC
2)  CREATE SEVERAL NODES DEC


Execution would be:
    - Loop over initializers and set them in cache with their names.
    - Loop over nodes and execute them.
