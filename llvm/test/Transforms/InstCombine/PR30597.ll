; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -S | FileCheck %s

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: readonly uwtable
define i1 @dot_ref_s(i32** noalias nocapture readonly dereferenceable(8)) {
; CHECK-LABEL: @dot_ref_s(
; CHECK-NEXT:  entry-block:
; CHECK-NEXT:    ret i1 false
;
entry-block:
  %loadedptr = load i32*, i32** %0, align 8, !nonnull !0
  %ptrtoint = ptrtoint i32* %loadedptr to i64
  %inttoptr = inttoptr i64 %ptrtoint to i32*
  %switchtmp = icmp eq i32* %inttoptr, null
  ret i1 %switchtmp

}

; Function Attrs: readonly uwtable
define i64* @function(i64* noalias nocapture readonly dereferenceable(8)) {
; CHECK-LABEL: @function(
; CHECK-NEXT:  entry-block:
; CHECK-NEXT:    [[LOADED:%.*]] = load i64, i64* [[TMP0:%.*]], align 8, [[RNG0:!range !.*]]
; CHECK-NEXT:    [[INTTOPTR:%.*]] = inttoptr i64 [[LOADED]] to i64*
; CHECK-NEXT:    ret i64* [[INTTOPTR]]
;
entry-block:
  %loaded = load i64, i64* %0, align 8, !range !1
  %inttoptr = inttoptr i64 %loaded to i64*
  ret i64* %inttoptr
}


!0 = !{}
!1 = !{i64 1, i64 140737488355327}
