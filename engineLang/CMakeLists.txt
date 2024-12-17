cmake_minimum_required(VERSION 3.13.4)

# Set policies for CMake behavior
if(POLICY CMP0068)
  cmake_policy(SET CMP0068 NEW)
  set(CMAKE_BUILD_WITH_INSTALL_NAME_DIR ON)
endif()

if(POLICY CMP0075)
  cmake_policy(SET CMP0075 NEW)
endif()

if(POLICY CMP0077)
  cmake_policy(SET CMP0077 NEW)
endif()

# Define the project name and languages
project(engine-dialect LANGUAGES CXX C)

# Set the C++ standard
set(CMAKE_CXX_STANDARD 17 CACHE STRING "C++ standard to conform to")

# Find MLIR package
find_package(MLIR REQUIRED CONFIG)

# Output information about found packages
message(STATUS "Using MLIRConfig.cmake in: ${MLIR_DIR}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

# Set output directories for runtime and libraries
set(LLVM_RUNTIME_OUTPUT_INTDIR ${CMAKE_BINARY_DIR}/bin)
set(LLVM_LIBRARY_OUTPUT_INTDIR ${CMAKE_BINARY_DIR}/lib)
set(MLIR_BINARY_DIR ${CMAKE_BINARY_DIR})

# Add MLIR and LLVM module paths
list(APPEND CMAKE_MODULE_PATH "${MLIR_CMAKE_DIR}")
list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_DIR}")

# Include necessary MLIR modules
include(TableGen)
include(AddLLVM)
include(AddMLIR)
include(HandleLLVMOptions)

# Collect all include paths for TableGen
set(TABLEGEN_INCLUDE_DIRS
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${MLIR_INCLUDE_DIRS}
  ${LLVM_INCLUDE_DIRS}
)

# Prepare include flags for TableGen
set(TABLEGEN_INCLUDES)
foreach(dir ${TABLEGEN_INCLUDE_DIRS})
  list(APPEND TABLEGEN_INCLUDES -I${dir})
endforeach()

# TableGen setup for Engine Dialect
set(ENGINE_TD_DIR ${CMAKE_CURRENT_SOURCE_DIR})
set(ENGINE_GEN_DIR ${CMAKE_CURRENT_BINARY_DIR}/include)

# Ensure the generated include directory exists
file(MAKE_DIRECTORY ${ENGINE_GEN_DIR})

# Generate headers and sources for Engine Dialect
# Use explicit include paths for mlir-tblgen
add_custom_command(
  OUTPUT ${ENGINE_GEN_DIR}/EngineDialect.h.inc
  COMMAND ${MLIR_TABLEGEN_EXE}
    ${ENGINE_TD_DIR}/EngineDialect.td
    -gen-dialect-decls
    -dialect=engine
    -name=Engine
    ${TABLEGEN_INCLUDES}
    -o ${ENGINE_GEN_DIR}/EngineDialect.h.inc
  DEPENDS 
    ${ENGINE_TD_DIR}/EngineDialect.td
    ${MLIR_TABLEGEN_EXE}
)

add_custom_command(
  OUTPUT ${ENGINE_GEN_DIR}/EngineDialect.cpp.inc
  COMMAND ${MLIR_TABLEGEN_EXE}
    ${ENGINE_TD_DIR}/EngineDialect.td
    -gen-dialect-defs
    -dialect=engine
    -name=Engine
    ${TABLEGEN_INCLUDES}
    -o ${ENGINE_GEN_DIR}/EngineDialect.cpp.inc
  DEPENDS 
    ${ENGINE_TD_DIR}/EngineDialect.td
    ${MLIR_TABLEGEN_EXE}
)

add_custom_command(
  OUTPUT ${ENGINE_GEN_DIR}/EngineOps.h.inc
  COMMAND ${MLIR_TABLEGEN_EXE}
    ${ENGINE_TD_DIR}/EngineOps.td
    -gen-op-decls
    ${TABLEGEN_INCLUDES}
    -o ${ENGINE_GEN_DIR}/EngineOps.h.inc
  DEPENDS 
    ${ENGINE_TD_DIR}/EngineOps.td
    ${ENGINE_TD_DIR}/EngineDialect.td
    ${MLIR_TABLEGEN_EXE}
)

add_custom_command(
  OUTPUT ${ENGINE_GEN_DIR}/EngineOps.cpp.inc
  COMMAND ${MLIR_TABLEGEN_EXE}
    ${ENGINE_TD_DIR}/EngineOps.td
    -gen-op-defs
    ${TABLEGEN_INCLUDES}
    -o ${ENGINE_GEN_DIR}/EngineOps.cpp.inc
  DEPENDS 
    ${ENGINE_TD_DIR}/EngineOps.td
    ${ENGINE_TD_DIR}/EngineDialect.td
    ${MLIR_TABLEGEN_EXE}
)

# Create a target for generated files
add_custom_target(EngineDialectGen 
  DEPENDS 
    ${ENGINE_GEN_DIR}/EngineDialect.h.inc
    ${ENGINE_GEN_DIR}/EngineDialect.cpp.inc
    ${ENGINE_GEN_DIR}/EngineOps.h.inc
    ${ENGINE_GEN_DIR}/EngineOps.cpp.inc
)

# Include directories
include_directories(${MLIR_INCLUDE_DIRS})
include_directories(${LLVM_INCLUDE_DIRS})
include_directories(${PROJECT_SOURCE_DIR}/include)
include_directories(${PROJECT_BINARY_DIR}/include)
include_directories(${ENGINE_GEN_DIR})

# Link directories for LLVM libraries
link_directories(${LLVM_BUILD_LIBRARY_DIR})
add_definitions(${LLVM_DEFINITIONS})

# Add library
add_library(EngineDialect
  lib/EngineDialect.cpp
  lib/EngineOps.cpp
)

# Ensure generated files are created before compiling the library
add_dependencies(EngineDialect EngineDialectGen)

# Add subdirectories for your project components
add_subdirectory(engine-opt)