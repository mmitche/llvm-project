add_llvm_library(
  LibcUnitTest
  Test.h
  LibcTest.cpp
  LibcTest.h
)
target_include_directories(LibcUnitTest PUBLIC ${LIBC_SOURCE_DIR})
add_dependencies(LibcUnitTest libc.utils.CPP.standalone_cpp)
target_link_libraries(LibcUnitTest PUBLIC libc_test_utils)
