//===-- Implementation of the ceilf function for aarch64 ------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "src/math/ceilf.h"
#include "src/__support/common.h"

namespace __llvm_libc {

LLVM_LIBC_FUNCTION(float, ceilf, (float x)) {
  float y;
  __asm__ __volatile__("ldr s0, %1\n"
                       "frintp s0, s0\n"
                       "str s0, %0\n"
                       : "=m"(y)
                       : "m"(x)
                       : "s0");
  return y;
}

} // namespace __llvm_libc
