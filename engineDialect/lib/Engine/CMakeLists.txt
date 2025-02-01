add_mlir_dialect_library(MLIREngine
		EngineDialect.cpp
		EngineOps.cpp
		LowerToAffine.cpp
		LowerSettings.cpp
		LowerToLLVM.cpp
		LowerToSPIR.cpp

        ADDITIONAL_HEADER_DIRS
        ${PROJECT_SOURCE_DIR}/include/Engine

        DEPENDS
        MLIREngineOpsIncGen

	LINK_LIBS PUBLIC
	MLIRIR
	)
