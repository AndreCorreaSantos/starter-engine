# CMake configuration for engine-opt tool
add_executable(engine-opt main.cpp)

# Link MLIR and your custom EngineDialect library
target_link_libraries(engine-opt
  PRIVATE
    MLIRSupport        # MLIR support utilities
    MLIRIR             # Core MLIR IR library
    MLIRParser         # MLIR file parser
    EngineDialect      # Link your custom EngineDialect library
)

# Include directories
target_include_directories(engine-opt PRIVATE
  ${PROJECT_SOURCE_DIR}/include   # Your project headers
  ${PROJECT_BINARY_DIR}/include   # TableGen-generated headers
  ${MLIR_INCLUDE_DIRS}            # MLIR includes
)

# Output the executable to the bin directory
set_target_properties(engine-opt PROPERTIES
  RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin
)

# Ensure TableGen-generated files are built before engine-opt
add_dependencies(engine-opt EngineDialectGen)

# Update compile flags for LLVM
llvm_update_compile_flags(engine-opt)
mlir_check_link_libraries(engine-opt)
