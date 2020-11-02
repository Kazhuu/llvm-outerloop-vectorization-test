llvm_dir="/home/kazooie/local/llvm/rv"
clang="${llvm_dir}/bin/clang"
opt="${llvm_dir}/bin/opt"

${clang} -O1 -S -emit-llvm gramschmidt.c -o gramschmidt.ll -fno-unroll-loops
${opt} -dot-cfg gramschmidt.ll > /dev/null
dot -Tpdf .gramschmidt_kernel1.dot -o gramschmidt.pdf

echo "VPlan IR"
${opt} gramschmidt.ll -o vplan_gramschmidt.ll -S --loop-vectorize --pass-remarks=loop-vectorize --pass-remarks-missed=loop-vectorize --pass-remarks-analysis=loop-vectorize --enable-vplan-native-path
${opt} -dot-cfg vplan_gramschmidt.ll > /dev/null
dot -Tpdf .gramschmidt_kernel1.dot -o vplan_gramschmidt.pdf
