; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=x86_64-linux-gnu                                  -global-isel -verify-machineinstrs < %s -o - | FileCheck %s --check-prefixes=CHECK,SSE
; RUN: llc -mtriple=x86_64-linux-gnu -mattr=+avx                      -global-isel -verify-machineinstrs < %s -o - | FileCheck %s --check-prefixes=CHECK,AVX
; RUN: llc -mtriple=x86_64-linux-gnu -mattr=+avx512f                  -global-isel -verify-machineinstrs < %s -o - | FileCheck %s --check-prefixes=CHECK,AVX
; RUN: llc -mtriple=x86_64-linux-gnu -mattr=+avx512f -mattr=+avx512vl -global-isel -verify-machineinstrs < %s -o - | FileCheck %s --check-prefixes=CHECK,AVX

define i64 @test_sub_i64(i64 %arg1, i64 %arg2) {
; CHECK-LABEL: test_sub_i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movq %rdi, %rax
; CHECK-NEXT:    subq %rsi, %rax
; CHECK-NEXT:    retq
  %ret = sub i64 %arg1, %arg2
  ret i64 %ret
}

define i32 @test_sub_i32(i32 %arg1, i32 %arg2) {
; CHECK-LABEL: test_sub_i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    subl %esi, %eax
; CHECK-NEXT:    retq
  %ret = sub i32 %arg1, %arg2
  ret i32 %ret
}

define float @test_add_float(float %arg1, float %arg2) {
; SSE-LABEL: test_add_float:
; SSE:       # %bb.0:
; SSE-NEXT:    addss %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_add_float:
; AVX:       # %bb.0:
; AVX-NEXT:    vaddss %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %ret = fadd float %arg1, %arg2
  ret float %ret
}

define double @test_add_double(double %arg1, double %arg2) {
; SSE-LABEL: test_add_double:
; SSE:       # %bb.0:
; SSE-NEXT:    addsd %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_add_double:
; AVX:       # %bb.0:
; AVX-NEXT:    vaddsd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %ret = fadd double %arg1, %arg2
  ret double %ret
}

define float @test_sub_float(float %arg1, float %arg2) {
; SSE-LABEL: test_sub_float:
; SSE:       # %bb.0:
; SSE-NEXT:    subss %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_sub_float:
; AVX:       # %bb.0:
; AVX-NEXT:    vsubss %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %ret = fsub float %arg1, %arg2
  ret float %ret
}

define double @test_sub_double(double %arg1, double %arg2) {
; SSE-LABEL: test_sub_double:
; SSE:       # %bb.0:
; SSE-NEXT:    subsd %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_sub_double:
; AVX:       # %bb.0:
; AVX-NEXT:    vsubsd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %ret = fsub double %arg1, %arg2
  ret double %ret
}

define <4 x i32>  @test_add_v4i32(<4 x i32> %arg1, <4 x i32>  %arg2) {
; SSE-LABEL: test_add_v4i32:
; SSE:       # %bb.0:
; SSE-NEXT:    paddd %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_add_v4i32:
; AVX:       # %bb.0:
; AVX-NEXT:    vpaddd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %ret = add <4 x i32>  %arg1, %arg2
  ret <4 x i32>  %ret
}

define <4 x i32>  @test_sub_v4i32(<4 x i32> %arg1, <4 x i32>  %arg2) {
; SSE-LABEL: test_sub_v4i32:
; SSE:       # %bb.0:
; SSE-NEXT:    psubd %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_sub_v4i32:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsubd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %ret = sub <4 x i32>  %arg1, %arg2
  ret <4 x i32>  %ret
}

define <4 x float>  @test_add_v4f32(<4 x float> %arg1, <4 x float>  %arg2) {
; SSE-LABEL: test_add_v4f32:
; SSE:       # %bb.0:
; SSE-NEXT:    addps %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_add_v4f32:
; AVX:       # %bb.0:
; AVX-NEXT:    vaddps %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %ret = fadd <4 x float>  %arg1, %arg2
  ret <4 x float>  %ret
}

define <4 x float>  @test_sub_v4f32(<4 x float> %arg1, <4 x float>  %arg2) {
; SSE-LABEL: test_sub_v4f32:
; SSE:       # %bb.0:
; SSE-NEXT:    subps %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_sub_v4f32:
; AVX:       # %bb.0:
; AVX-NEXT:    vsubps %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %ret = fsub <4 x float>  %arg1, %arg2
  ret <4 x float>  %ret
}

define i32  @test_copy_float(float %val) {
; SSE-LABEL: test_copy_float:
; SSE:       # %bb.0:
; SSE-NEXT:    movd %xmm0, %eax
; SSE-NEXT:    retq
;
; AVX-LABEL: test_copy_float:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovd %xmm0, %eax
; AVX-NEXT:    retq
  %r = bitcast float %val to i32
  ret i32 %r
}

define float  @test_copy_i32(i32 %val) {
; SSE-LABEL: test_copy_i32:
; SSE:       # %bb.0:
; SSE-NEXT:    movd %edi, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_copy_i32:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovd %edi, %xmm0
; AVX-NEXT:    retq
  %r = bitcast i32 %val to float
  ret float %r
}

