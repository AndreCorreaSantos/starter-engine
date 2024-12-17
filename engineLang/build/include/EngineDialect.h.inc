/*===- TableGen'erated file -------------------------------------*- C++ -*-===*\
|*                                                                            *|
|* Dialect Declarations                                                       *|
|*                                                                            *|
|* Automatically generated file, do not edit!                                 *|
|* From: EngineDialect.td                                                     *|
|*                                                                            *|
\*===----------------------------------------------------------------------===*/

namespace mlir {
namespace engine {

class EngineDialect : public ::mlir::Dialect {
  explicit EngineDialect(::mlir::MLIRContext *context);

  void initialize();
  friend class ::mlir::MLIRContext;
public:
  ~EngineDialect() override;
  static constexpr ::llvm::StringLiteral getDialectNamespace() {
    return ::llvm::StringLiteral("engine");
  }
};
} // namespace engine
} // namespace mlir
MLIR_DECLARE_EXPLICIT_TYPE_ID(mlir::engine::EngineDialect)
