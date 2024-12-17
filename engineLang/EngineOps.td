include "mlir/IR/OpBase.td"
include "EngineDialect.td"

def AddOp : Op<"add", [AttrSizedOperandSegments]> {
    let summary = "An addition operation.";
    let description = [{
        Adds two floating-point numbers.
    }];
    let arguments = (ins F32:$lhs, F32:$rhs);
    let results = (outs F32:$result);
    let builders = [OpBuilder<(ins "Value":$lhs, "Value":$rhs)>];
}
