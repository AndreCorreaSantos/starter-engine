configure_lit_site_cfg(
        ${CMAKE_CURRENT_SOURCE_DIR}/lit.site.cfg.py.in
        ${CMAKE_CURRENT_BINARY_DIR}/lit.site.cfg.py
        MAIN_CONFIG
        ${CMAKE_CURRENT_SOURCE_DIR}/lit.cfg.py
)

set(ENGINE_TEST_DEPENDS
        FileCheck count not
        mlir-opt
        engine-opt
        )

add_lit_testsuite(check-engine "Running the engine regression tests"
        ${CMAKE_CURRENT_BINARY_DIR}
        DEPENDS ${ENGINE_TEST_DEPENDS}
        )
set_target_properties(check-engine PROPERTIES FOLDER "Tests")

add_lit_testsuites(ENGINE ${CMAKE_CURRENT_SOURCE_DIR} DEPENDS ${ENGINE_TEST_DEPENDS})
