// Licensed to the Apache Software Foundation (ASF) under one
// or more contributor license agreements.  See the NOTICE file
// distributed with this work for additional information
// regarding copyright ownership.  The ASF licenses this file
// to you under the Apache License, Version 2.0 (the
// "License"); you may not use this file except in compliance
// with the License.  You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

#include "mlir/IR/Builders.h"
#include "mlir/IR/OpImplementation.h"

#include "Engine/EngineDialect.h"
#include "Engine/EngineOps.h"

using namespace mlir;
using namespace engine;

//===----------------------------------------------------------------------===//
// Engine dialect.
//===----------------------------------------------------------------------===//

#include "Engine/EngineOpsDialect.cpp.inc"

void EngineDialect::initialize() {
  addOperations<
#define GET_OP_LIST
#include "Engine/EngineOps.cpp.inc"
      >();
}

void engine::ConstantOp::build(mlir::OpBuilder &builder,
                              mlir::OperationState &state, double value) {
  auto dataType = RankedTensorType::get({}, builder.getF64Type());
  auto dataAttribute = DenseElementsAttr::get(dataType, value);
  engine::ConstantOp::build(builder, state, dataType, dataAttribute);
}

mlir::Operation *EngineDialect::materializeConstant(mlir::OpBuilder &builder,
                                                   mlir::Attribute value,
                                                   mlir::Type type,
                                                   mlir::Location loc) {
  return builder.create<engine::ConstantOp>(
      loc, type, mlir::cast<mlir::DenseElementsAttr>(value));
}