# First compile LLVM IR codes and don't use loop unrolling.
clang -O3 -S -emit-llvm function.c -o function.ll -fno-unroll-loops
clang -O3 -S -emit-llvm function_vectorize.c -o function_vectorize.ll -fno-unroll-loops

# Compile main and non-vectorized foo function.
clang -O3 -c main.c
clang -O3 -c function.ll
# Run VPlan (vectorization plan) based outer loop vectorization for
# foo_vectorize function.
opt $(< ./opt-flags.sh)
# Then compile outer loop vectorized foo_vectorize function.
clang -O3 -c function_vectorize_vpath.ll

# The main executable.
clang main.o function.o function_vectorize_vpath.o -o main
