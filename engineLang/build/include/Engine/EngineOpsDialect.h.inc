/*===- TableGen'erated file -------------------------------------*- C++ -*-===*\
|*                                                                            *|
|* Dialect Declarations                                                       *|
|*                                                                            *|
|* Automatically generated file, do not edit!                                 *|
|* From: EngineOps.td                                                         *|
|*                                                                            *|
\*===----------------------------------------------------------------------===*/

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

  /// Materialize a single constant operation from a given attribute value with
  /// the desired resultant type.
  ::mlir::Operation *materializeConstant(::mlir::OpBuilder &builder,
                                         ::mlir::Attribute value,
                                         ::mlir::Type type,
                                         ::mlir::Location loc) override;
};
} // namespace engine
MLIR_DECLARE_EXPLICIT_TYPE_ID(::engine::EngineDialect)
