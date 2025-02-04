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

#ifndef MLIR_ENGINE_PASSES_H
#define MLIR_ENGINE_PASSES_H

#include <memory>

#include "mlir/Pass/Pass.h"



namespace engine {
struct settingsInfo {
  int64_t lowerSettings; // Lowering type: 0 means llvm, 1 verilog
  int64_t type; // data Types: 0 means floats, 1 means integers.
};

std::unique_ptr<mlir::Pass> createLowerSettingsPass(settingsInfo &settings);
std::unique_ptr<mlir::Pass> createLowerToAffinePass(settingsInfo &settings);
std::unique_ptr<mlir::Pass> createLowerToLLVMPass();
} // namespace engine

#endif // MLIR_ENGINE_PASSES_H
