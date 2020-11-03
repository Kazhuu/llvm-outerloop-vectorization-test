llvm_dir="/home/kazooie/local/llvm/master/bin"
clang="${llvm_dir}/clang"
opt="${llvm_dir}/opt"
debug=""

echo "POCL IR"
${opt} -dot-cfg pocl_2mm.ll > /dev/null 2>&1
dot -Tpdf .mm2_kernel1.dot -o pocl_2mm.pdf

echo "VPlan IR"
${opt} pocl_2mm.ll -o vplan_2mm.ll -S ${debug} --loop-vectorize --pass-remarks=loop-vectorize --pass-remarks-missed=loop-vectorize --pass-remarks-analysis=loop-vectorize --enable-vplan-native-path
${opt} -dot-cfg vplan_2mm.ll > /dev/null 2>&1
dot -Tpdf .mm2_kernel1.dot -o vplan_2mm.pdf

echo "VPlan IR with predication"
${opt} pocl_2mm.ll -o vplan_predication_2mm.ll -S ${debug} --loop-vectorize --pass-remarks=loop-vectorize --pass-remarks-missed=loop-vectorize --pass-remarks-analysis=loop-vectorize --enable-vplan-native-path --enable-vplan-predication
${opt} -dot-cfg vplan_predication_2mm.ll > /dev/null 2>&1
dot -Tpdf .mm2_kernel1.dot -o vplan_predication_2mm.pdf
