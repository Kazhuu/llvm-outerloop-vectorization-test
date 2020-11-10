# First compile LLVM IR codes and don't use loop unrolling.
# Loop unrolling needs to be disabled because outer loop is not considered
# uniform loop by LLVM terminology.
# Check function isUniformLoop() in LoopVectorizationLegality.cpp in LLVM source
# code for what checks are done to determine if loop is uniform or not.
clang -O3 -S -emit-llvm function.c -o function.ll -fno-unroll-loops
clang -O3 -S -emit-llvm function_vectorize.c -o function_vectorize.ll -fno-unroll-loops

# Compile main and non-vectorized foo function.
clang -O3 -c main.c
echo "Compile non-vectorizated funtion with VPlan"
clang -O3 -c function.ll
# Run VPlan (vectorization plan) based outer loop vectorization for
# foo_vectorize function.
echo "VPlan vectorization IR transformation"
opt $(< ./opt-flags.sh)
# Then compile outer loop vectorized foo_vectorize function.
echo "Compile VPlan vectorized IR"
clang -O3 -c function_vectorize_vpath.ll

echo "Compile main executable"
# The main executable.
clang main.o function.o function_vectorize_vpath.o -o main
