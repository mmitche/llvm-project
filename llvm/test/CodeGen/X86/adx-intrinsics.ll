; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-apple-darwin -mcpu=corei7 --show-mc-encoding | FileCheck %s --check-prefix=CHECK
; RUN: llc < %s -mtriple=x86_64-apple-darwin -mcpu=broadwell --show-mc-encoding | FileCheck %s --check-prefix=CHECK

define i8 @test_addcarry_32_load(i8 %c, i32* %aptr, i32 %b, i8* %ptr) {
; CHECK-LABEL: test_addcarry_32_load:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    addb $-1, %dil ## encoding: [0x40,0x80,0xc7,0xff]
; CHECK-NEXT:    adcl (%rsi), %edx ## encoding: [0x13,0x16]
; CHECK-NEXT:    setb %al ## encoding: [0x0f,0x92,0xc0]
; CHECK-NEXT:    movl %edx, (%rcx) ## encoding: [0x89,0x11]
; CHECK-NEXT:    retq ## encoding: [0xc3]
  %a = load i32, i32* %aptr
  %ret = call { i8, i32 } @llvm.x86.addcarry.32(i8 %c, i32 %a, i32 %b)
  %1 = extractvalue { i8, i32 } %ret, 1
  %2 = bitcast i8* %ptr to i32*
  store i32 %1, i32* %2, align 1
  %3 = extractvalue { i8, i32 } %ret, 0
  ret i8 %3
}

define i8 @test_addcarry_32_load2(i8 %c, i32 %a, i32* %bptr, i8* %ptr) {
; CHECK-LABEL: test_addcarry_32_load2:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    addb $-1, %dil ## encoding: [0x40,0x80,0xc7,0xff]
; CHECK-NEXT:    adcl (%rdx), %esi ## encoding: [0x13,0x32]
; CHECK-NEXT:    setb %al ## encoding: [0x0f,0x92,0xc0]
; CHECK-NEXT:    movl %esi, (%rcx) ## encoding: [0x89,0x31]
; CHECK-NEXT:    retq ## encoding: [0xc3]
  %b = load i32, i32* %bptr
  %ret = call { i8, i32 } @llvm.x86.addcarry.32(i8 %c, i32 %a, i32 %b)
  %1 = extractvalue { i8, i32 } %ret, 1
  %2 = bitcast i8* %ptr to i32*
  store i32 %1, i32* %2, align 1
  %3 = extractvalue { i8, i32 } %ret, 0
  ret i8 %3
}

declare { i8, i32 } @llvm.x86.addcarry.32(i8, i32, i32)

define i8 @test_addcarry_32(i8 %c, i32 %a, i32 %b, i8* %ptr) {
; CHECK-LABEL: test_addcarry_32:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    addb $-1, %dil ## encoding: [0x40,0x80,0xc7,0xff]
; CHECK-NEXT:    adcl %edx, %esi ## encoding: [0x11,0xd6]
; CHECK-NEXT:    setb %al ## encoding: [0x0f,0x92,0xc0]
; CHECK-NEXT:    movl %esi, (%rcx) ## encoding: [0x89,0x31]
; CHECK-NEXT:    retq ## encoding: [0xc3]
  %ret = call { i8, i32 } @llvm.x86.addcarry.32(i8 %c, i32 %a, i32 %b)
  %1 = extractvalue { i8, i32 } %ret, 1
  %2 = bitcast i8* %ptr to i32*
  store i32 %1, i32* %2, align 1
  %3 = extractvalue { i8, i32 } %ret, 0
  ret i8 %3
}

declare { i8, i64 } @llvm.x86.addcarry.64(i8, i64, i64)

define i8 @test_addcarry_64(i8 %c, i64 %a, i64 %b, i8* %ptr) {
; CHECK-LABEL: test_addcarry_64:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    addb $-1, %dil ## encoding: [0x40,0x80,0xc7,0xff]
; CHECK-NEXT:    adcq %rdx, %rsi ## encoding: [0x48,0x11,0xd6]
; CHECK-NEXT:    setb %al ## encoding: [0x0f,0x92,0xc0]
; CHECK-NEXT:    movq %rsi, (%rcx) ## encoding: [0x48,0x89,0x31]
; CHECK-NEXT:    retq ## encoding: [0xc3]
  %ret = call { i8, i64 } @llvm.x86.addcarry.64(i8 %c, i64 %a, i64 %b)
  %1 = extractvalue { i8, i64 } %ret, 1
  %2 = bitcast i8* %ptr to i64*
  store i64 %1, i64* %2, align 1
  %3 = extractvalue { i8, i64 } %ret, 0
  ret i8 %3
}

declare { i8, i32 } @llvm.x86.subborrow.32(i8, i32, i32)

define i8 @test_subborrow_32(i8 %c, i32 %a, i32 %b, i8* %ptr) {
; CHECK-LABEL: test_subborrow_32:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    addb $-1, %dil ## encoding: [0x40,0x80,0xc7,0xff]
; CHECK-NEXT:    sbbl %edx, %esi ## encoding: [0x19,0xd6]
; CHECK-NEXT:    setb %al ## encoding: [0x0f,0x92,0xc0]
; CHECK-NEXT:    movl %esi, (%rcx) ## encoding: [0x89,0x31]
; CHECK-NEXT:    retq ## encoding: [0xc3]
  %ret = call { i8, i32 } @llvm.x86.subborrow.32(i8 %c, i32 %a, i32 %b)
  %1 = extractvalue { i8, i32 } %ret, 1
  %2 = bitcast i8* %ptr to i32*
  store i32 %1, i32* %2, align 1
  %3 = extractvalue { i8, i32 } %ret, 0
  ret i8 %3
}

declare { i8, i64 } @llvm.x86.subborrow.64(i8, i64, i64)

define i8 @test_subborrow_64(i8 %c, i64 %a, i64 %b, i8* %ptr) {
; CHECK-LABEL: test_subborrow_64:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    addb $-1, %dil ## encoding: [0x40,0x80,0xc7,0xff]
; CHECK-NEXT:    sbbq %rdx, %rsi ## encoding: [0x48,0x19,0xd6]
; CHECK-NEXT:    setb %al ## encoding: [0x0f,0x92,0xc0]
; CHECK-NEXT:    movq %rsi, (%rcx) ## encoding: [0x48,0x89,0x31]
; CHECK-NEXT:    retq ## encoding: [0xc3]
  %ret = call { i8, i64 } @llvm.x86.subborrow.64(i8 %c, i64 %a, i64 %b)
  %1 = extractvalue { i8, i64 } %ret, 1
  %2 = bitcast i8* %ptr to i64*
  store i64 %1, i64* %2, align 1
  %3 = extractvalue { i8, i64 } %ret, 0
  ret i8 %3
}

; Try a version with loads. Previously we crashed on this.
define i32 @load_crash(i64* nocapture readonly %a, i64* nocapture readonly %b, i64* %res)  {
; CHECK-LABEL: load_crash:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    movq (%rdi), %rcx ## encoding: [0x48,0x8b,0x0f]
; CHECK-NEXT:    xorl %eax, %eax ## encoding: [0x31,0xc0]
; CHECK-NEXT:    addq (%rsi), %rcx ## encoding: [0x48,0x03,0x0e]
; CHECK-NEXT:    setb %al ## encoding: [0x0f,0x92,0xc0]
; CHECK-NEXT:    movq %rcx, (%rdx) ## encoding: [0x48,0x89,0x0a]
; CHECK-NEXT:    retq ## encoding: [0xc3]
  %1 = load i64, i64* %a, align 8
  %2 = load i64, i64* %b, align 8
  %3 = bitcast i64* %res to i8*
  %4 = call { i8, i64 } @llvm.x86.addcarry.64(i8 0, i64 %1, i64 %2)
  %5 = extractvalue { i8, i64 } %4, 1
  %6 = bitcast i8* %3 to i64*
  store i64 %5, i64* %6, align 1
  %7 = extractvalue { i8, i64 } %4, 0
  %conv = zext i8 %7 to i32
  ret i32 %conv
}

; Try a really simple all zero input case, which also used to crash
define void @allzeros() {
; CHECK-LABEL: allzeros:
; CHECK:       ## %bb.0: ## %entry
; CHECK-NEXT:    movq $0, 0 ## encoding: [0x48,0xc7,0x04,0x25,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00]
; CHECK-NEXT:    retq ## encoding: [0xc3]
entry:
  %0 = call { i8, i64 } @llvm.x86.addcarry.64(i8 0, i64 0, i64 0)
  %1 = extractvalue { i8, i64 } %0, 1
  store i64 %1, i64* null, align 1
  %2 = extractvalue { i8, i64 } %0, 0
  ret void
}
