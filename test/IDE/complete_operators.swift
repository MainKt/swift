// RUN: %target-swift-ide-test -code-completion -source-filename=%s -code-completion-token=POSTFIX_1 | FileCheck %s -check-prefix=POSTFIX_1
// RUN: %target-swift-ide-test -code-completion -source-filename=%s -code-completion-token=POSTFIX_2 | FileCheck %s -check-prefix=POSTFIX_2
// RUN: %target-swift-ide-test -code-completion -source-filename=%s -code-completion-token=POSTFIX_3 | FileCheck %s -check-prefix=POSTFIX_3
// RUN: %target-swift-ide-test -code-completion -source-filename=%s -code-completion-token=POSTFIX_4 | FileCheck %s -check-prefix=POSTFIX_4
// RUN: %target-swift-ide-test -code-completion -source-filename=%s -code-completion-token=POSTFIX_5 | FileCheck %s -check-prefix=POSTFIX_5
// RUN: %target-swift-ide-test -code-completion -source-filename=%s -code-completion-token=POSTFIX_6 | FileCheck %s -check-prefix=POSTFIX_6
// RUN: %target-swift-ide-test -code-completion -source-filename=%s -code-completion-token=POSTFIX_7 | FileCheck %s -check-prefix=POSTFIX_7
// RUN: %target-swift-ide-test -code-completion -source-filename=%s -code-completion-token=POSTFIX_8 | FileCheck %s -check-prefix=POSTFIX_8
// RUN: %target-swift-ide-test -code-completion -source-filename=%s -code-completion-token=POSTFIX_9 | FileCheck %s -check-prefix=POSTFIX_9
// RUN: %target-swift-ide-test -code-completion -source-filename=%s -code-completion-token=POSTFIX_10 | FileCheck %s -check-prefix=POSTFIX_10
// RUN: %target-swift-ide-test -code-completion -source-filename=%s -code-completion-token=INFIX_1 | FileCheck %s -check-prefix=S2_INFIX
// RUN: %target-swift-ide-test -code-completion -source-filename=%s -code-completion-token=INFIX_2 | FileCheck %s -check-prefix=S2_INFIX_LVALUE
// RUN: %target-swift-ide-test -code-completion -source-filename=%s -code-completion-token=INFIX_3 | FileCheck %s -check-prefix=S2_INFIX_LVALUE
// RUN: %target-swift-ide-test -code-completion -source-filename=%s -code-completion-token=INFIX_4 | FileCheck %s -check-prefix=S2_INFIX
// RUN: %target-swift-ide-test -code-completion -source-filename=%s -code-completion-token=INFIX_5 | FileCheck %s -check-prefix=S2_INFIX
// RUN: %target-swift-ide-test -code-completion -source-filename=%s -code-completion-token=INFIX_6 | FileCheck %s -check-prefix=S2_INFIX
// RUN: %target-swift-ide-test -code-completion -source-filename=%s -code-completion-token=INFIX_7 | FileCheck %s -check-prefix=S2_INFIX_OPTIONAL
// RUN: %target-swift-ide-test -code-completion -source-filename=%s -code-completion-token=INFIX_8 | FileCheck %s -check-prefix=S3_INFIX_OPTIONAL
// RUN: %target-swift-ide-test -code-completion -source-filename=%s -code-completion-token=INFIX_9 | FileCheck %s -check-prefix=FOOABLE_INFIX
// RUN: %target-swift-ide-test -code-completion -source-filename=%s -code-completion-token=INFIX_10 | FileCheck %s -check-prefix=FOOABLE_INFIX
// RUN: %target-swift-ide-test -code-completion -source-filename=%s -code-completion-token=INFIX_11 | FileCheck %s -check-prefix=NO_OPERATORS
// RUN: %target-swift-ide-test -code-completion -source-filename=%s -code-completion-token=INFIX_12 | FileCheck %s -check-prefix=NO_OPERATORS
// RUN: %target-swift-ide-test -code-completion -source-filename=%s -code-completion-token=INFIX_13 | FileCheck %s -check-prefix=NO_OPERATORS
// RUN: %target-swift-ide-test -code-completion -source-filename=%s -code-completion-token=INFIX_14 | FileCheck %s -check-prefix=NO_OPERATORS
// RUN: %target-swift-ide-test -code-completion -source-filename=%s -code-completion-token=INFIX_15 | FileCheck %s -check-prefix=NO_OPERATORS
// RUN: %target-swift-ide-test -code-completion -source-filename=%s -code-completion-token=INFIX_16 | FileCheck %s -check-prefix=NO_OPERATORS
// RUN: %target-swift-ide-test -code-completion -source-filename=%s -code-completion-token=INFIX_17 | FileCheck %s -check-prefix=NO_OPERATORS
// RUN: %target-swift-ide-test -code-completion -source-filename=%s -code-completion-token=INFIX_18 | FileCheck %s -check-prefix=NO_OPERATORS
// RUN: %target-swift-ide-test -code-completion -source-filename=%s -code-completion-token=INFIX_19 | FileCheck %s -check-prefix=EMPTYCLASS_INFIX
// RUN: %target-swift-ide-test -code-completion -source-filename=%s -code-completion-token=INFIX_20 | FileCheck %s -check-prefix=NO_OPERATORS
// RUN: %target-swift-ide-test -code-completion -source-filename=%s -code-completion-token=INFIX_21 | FileCheck %s -check-prefix=NO_OPERATORS
// RUN: %target-swift-ide-test -code-completion -source-filename=%s -code-completion-token=INFIX_22 | FileCheck %s -check-prefix=NO_OPERATORS

struct S {}
postfix operator ++ {}
postfix func ++(inout x: S) -> S { return x }

func testPostfix1(x: S) {
  x#^POSTFIX_1^#
}
// POSTFIX_1-NOT: ++

func testPostfix2(var x: S) {
  x#^POSTFIX_2^#
}
// POSTFIX_2: Begin completions
// POSTFIX_2-DAG: Decl[OperatorFunction]/CurrModule:  ++[#S#]
// POSTFIX_2-DAG-NOT: --
// POSTFIX_2: End completions


postfix operator +- {}
postfix func +-(x: S) -> S? { return x }
func testPostfix3(x: S) {
  x#^POSTFIX_3^#
}
// POSTFIX_3: Decl[OperatorFunction]/CurrModule:  +-[#S?#]

func testPostfix4(x: S?) {
  x#^POSTFIX_4^#
}
// POSTFIX_4: Pattern/None:  ![#S#]

struct T {}
postfix func +-<G>(x: [G]) -> G { return x! }
func testPostfix5(x: [T]) {
  x#^POSTFIX_5^#
}
// POSTFIX_5: Decl[OperatorFunction]/CurrModule:  +-[#T#]

protocol Fooable {}
extension Int : Fooable {}
extension Double : Fooable {}

postfix operator *** {}
postfix func ***<G: Fooable>(x: G) -> G { return x }
func testPostfix6() {
  1 + 2 * 3#^POSTFIX_6^#
}
// POSTFIX_6: Decl[OperatorFunction]/CurrModule:  ***[#Int#]

func testPostfix7() {
  1 + 2 * 3.0#^POSTFIX_7^#
}
// POSTFIX_7: Decl[OperatorFunction]/CurrModule:  ***[#Double#]

func testPostfix8(x: S) {
  x#^POSTFIX_8^#
}
// POSTFIX_8-NOT: ***

protocol P {
  typealias T
  func foo() -> T
}

func testPostfix9<G: P where G.T == Int>(x: G) {
  x.foo()#^POSTFIX_9^#
}
// POSTFIX_9: Decl[OperatorFunction]/CurrModule: ***[#Int#]

func testPostfix10<G: P where G.T : Fooable>(x: G) {
  x.foo()#^POSTFIX_10^#
}
// POSTFIX_10: Decl[OperatorFunction]/CurrModule: ***[#G.T#]


// ===--- Infix operators

struct S2 {}
infix operator ** {
  associativity left
  precedence 123
}
infix operator **= {
  associativity none
  precedence 123
}
func +(x: S2, y: S2) -> S2 { return x }
func **(x: S2, y: Int) -> S2 { return x }
func **=(inout x: S2, y: Int) -> Void { return x }

func testInfix1(x: S2) {
  x#^INFIX_1^#
}
// S2_INFIX: Begin completions
// FIXME: rdar://problem/22997089 - should be CurrModule
// S2_INFIX-DAG: Decl[OperatorFunction]/OtherModule[Swift]:   + {#S2#}[#S2#]
// S2_INFIX-DAG: Decl[OperatorFunction]/CurrModule:   ** {#Int#}[#S2#]
// S2_INFIX-DAG-NOT: **=
// S2_INFIX-DAG-NOT: +=
// S2_INFIX-DAG-NOT: *
// S2_INFIX-DAG-NOT: ??
// S2_INFIX-DAG-NOT: ~=
// S2_INFIX-DAG-NOT: ~>
// S2_INFIX: End completions

func testInfix2(var x: S2) {
  x#^INFIX_2^#
}
// S2_INFIX_LVALUE: Begin completions
// FIXME: rdar://problem/22997089 - should be CurrModule
// S2_INFIX_LVALUE-DAG: Decl[OperatorFunction]/OtherModule[Swift]:   + {#S2#}[#S2#]
// S2_INFIX_LVALUE-DAG: Decl[OperatorFunction]/CurrModule:   ** {#Int#}[#S2#]
// S2_INFIX_LVALUE-DAG: Decl[OperatorFunction]/CurrModule:   **= {#Int#}[#Void#]
// S2_INFIX_LVALUE-DAG-NOT: +=
// S2_INFIX_LVALUE-DAG-NOT: *
// S2_INFIX_LVALUE-DAG-NOT: ??
// S2_INFIX_LVALUE-DAG-NOT: ~=
// S2_INFIX_LVALUE-DAG-NOT: ~>
// S2_INFIX_LVALUE: End completions

func testInfix3(inout x: S2) {
  x#^INFIX_3^#
}

func testInfix4() {
  S2()#^INFIX_4^#
}

func testInfix5() {
  (S2() + S2())#^INFIX_5^#
}

func testInfix6<T: P where T.T == S2>(x: T) {
  x.foo()#^INFIX_6^#
}

func testInfix7(x: S2?) {
  x#^INFIX_7^#
}
// S2_INFIX_OPTIONAL: Begin completions
// S2_INFIX_OPTIONAL-DAG: Decl[OperatorFunction]/OtherModule[Swift]:  ?? {#S2#}[#S2#]
// S2_INFIX_OPTIONAL-DAG: Decl[OperatorFunction]/OtherModule[Swift]:  == {#{{.*}}#}[#Bool#]
// S2_INFIX_OPTIONAL-DAG: Decl[OperatorFunction]/OtherModule[Swift]:  != {#{{.*}}#}[#Bool#]
// The equality operators don't come from equatable.
// S2_INFIX_OPTIONAL-DAG-NOT: == {#S2
// FIXME: rdar://problem/22996887 - shouldn't complete with optional LHS
// S2_INFIX_OPTIONAL-DAG: Decl[OperatorFunction]/CurrModule:   ** {#Int#}[#S2#]
// S2_INFIX_OPTIONAL: End completions

struct S3: Equatable {}
func ==(x: S3, y: S3) -> Bool { return true }
func !=(x: S3, y: S3) -> Bool { return false}

func testInfix8(x: S3?) {
  x#^INFIX_8^#
}
// The equality operators come from equatable.
// S3_INFIX_OPTIONAL: Begin completions
// S3_INFIX_OPTIONAL-DAG: Decl[OperatorFunction]/OtherModule[Swift]:  != {#S3?#}[#Bool#]
// S3_INFIX_OPTIONAL-DAG: Decl[OperatorFunction]/OtherModule[Swift]:  == {#S3?#}[#Bool#]
// S3_INFIX_OPTIONAL: End completions

infix operator **** {
  associativity left
  precedence 123
}
func ****<T: Fooable>(x: T, y: T) -> T { return x }

func testInfix9<T: P where T.T: Fooable>(x: T) {
  x.foo()#^INFIX_9^#
}
// FOOABLE_INFIX: Decl[OperatorFunction]/CurrModule:   **** {#T.T#}[#T.T#]

func testInfix10<T: P where T.T: Fooable>(x: T) {
  (x.foo() **** x.foo())#^INFIX_10^#
}

func testInfix11() {
  S2#^INFIX_11^#
}
// NO_OPERATORS-NOT: Decl[OperatorFunction]
func testInfix12() {
  P#^INFIX_12^#
}
func testInfix13() {
  P.foo#^INFIX_13^#
}
func testInfix14() {
  P.T#^INFIX_14^#
}
func testInfix15<T: P where T.T == S2>() {
  T#^INFIX_15^#
}
func testInfix16<T: P where T.T == S2>() {
  T.foo#^INFIX_16^#
}
func testInfix17(x: Void) {
  x#^INFIX_17^#
}
func testInfix18(x: (S2, S2) {
  x#^INFIX_18^#
}
class EmptyClass {}
func testInfix19(x: EmptyClass) {
  x#^INFIX_19^#
}
// EMPTYCLASS_INFIX: Begin completions
// EMPTYCLASS_INFIX-DAG: Decl[OperatorFunction]/OtherModule[Swift]: === {#AnyObject?#}[#Bool#]
// EMPTYCLASS_INFIX-DAG: Decl[OperatorFunction]/OtherModule[Swift]: !== {#AnyObject?#}[#Bool#]
// EMPTYCLASS_INFIX: End completions

enum E {
  case A
  case B(S2)
}
func testInfix20(x: E) {
  x#^INFIX_20^#
}
func testInfix21() {
  E.A#^INFIX_21^#
}
func testInfix22() {
  E.B#^INFIX_22^#
}
