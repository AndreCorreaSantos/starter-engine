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

# Include directories for LLVM and MLIR headers
include_directories(${LLVM_INCLUDE_DIRS})
include_directories(${MLIR_INCLUDE_DIRS})
include_directories(${PROJECT_SOURCE_DIR}/include)  # Your include directory for custom headers
include_directories(${PROJECT_BINARY_DIR}/include)   # Generated include directory




# Link directories for LLVM libraries
link_directories(${LLVM_BUILD_LIBRARY_DIR})
add_definitions(${LLVM_DEFINITIONS})

# Add subdirectories for your project components
add_subdirectory(include)      # Contains header files, if any
add_subdirectory(lib)          # Contains your dialect implementation (e.g., EngineDialect.cpp)
# add_subdirectory(test)         # Contains tests for your dialect, if any
add_subdirectory(engine-opt)   # Replace with your executable target (e.g., standalone-opt)
