/*===- TableGen'erated file -------------------------------------*- C++ -*-===*\
|*                                                                            *|
|* Dialect Definitions                                                        *|
|*                                                                            *|
|* Automatically generated file, do not edit!                                 *|
|* From: EngineDialect.td                                                     *|
|*                                                                            *|
\*===----------------------------------------------------------------------===*/

MLIR_DEFINE_EXPLICIT_TYPE_ID(mlir::engine::EngineDialect)
namespace mlir {
namespace engine {

EngineDialect::EngineDialect(::mlir::MLIRContext *context)
    : ::mlir::Dialect(getDialectNamespace(), context, ::mlir::TypeID::get<EngineDialect>())
    
     {
  
  initialize();
}

EngineDialect::~EngineDialect() = default;

} // namespace engine
} // namespace mlir
