//===-- UseAuto/UseAuto.cpp - Use auto type specifier ---------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
///
/// \file
/// \brief This file provides the implementation of the UseAutoTransform class.
///
//===----------------------------------------------------------------------===//

#include "UseAuto.h"
#include "UseAutoActions.h"
#include "UseAutoMatchers.h"

using clang::ast_matchers::MatchFinder;
using namespace clang;
using namespace clang::tooling;

int UseAutoTransform::apply(FileOverrides &InputStates,
                            const clang::tooling::CompilationDatabase &Database,
                            const std::vector<std::string> &SourcePaths) {
  ClangTool UseAutoTool(Database, SourcePaths);

  unsigned AcceptedChanges = 0;

  MatchFinder Finder;
  IteratorReplacer ReplaceIterators(getReplacements(), AcceptedChanges,
                                    Options().MaxRiskLevel, /*Owner=*/ *this);
  NewReplacer ReplaceNew(getReplacements(), AcceptedChanges,
                         Options().MaxRiskLevel, /*Owner=*/ *this);

  Finder.addMatcher(makeIteratorDeclMatcher(), &ReplaceIterators);
  Finder.addMatcher(makeDeclWithNewMatcher(), &ReplaceNew);

  setOverrides(InputStates);

  if (int Result = UseAutoTool.run(createActionFactory(Finder))) {
    llvm::errs() << "Error encountered during translation.\n";
    return Result;
  }

  setAcceptedChanges(AcceptedChanges);

  return 0;
}

struct UseAutoFactory : TransformFactory {
  Transform *createTransform(const TransformOptions &Opts) LLVM_OVERRIDE {
    return new UseAutoTransform(Opts);
  }
};

// Register the factory using this statically initialized variable.
static TransformFactoryRegistry::Add<UseAutoFactory>
X("use-auto", "Use of 'auto' type specifier");

// This anchor is used to force the linker to link in the generated object file
// and thus register the factory.
volatile int UseAutoTransformAnchorSource = 0;
