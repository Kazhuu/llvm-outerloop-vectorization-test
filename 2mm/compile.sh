llvm_dir="/home/kazooie/local/llvm/rv"
clang="${llvm_dir}/bin/clang"
opt="${llvm_dir}/bin/opt"

${clang} -O1 -S -emit-llvm 2mm.c -o 2mm.ll -fno-unroll-loops
${opt} -dot-cfg 2mm.ll > /dev/null
dot -Tpdf .mm2_kernel1.dot -o 2mm.pdf

#echo "RV IR"
#${opt} 2mm/2mm.ll -o 2mm/rv_2mm.ll -S --load=libRV.so --load-pass-plugin=rv-loopvec -rv-loopvec --pass-remarks=rv --pass-remarks-missed=rv --pass-remarks-analysis=rv
#${opt} -dot-cfg 2mm/rv_2mm.ll > /dev/null
#${dot} -Tpdf ._rv_2mm_mm2_kernel1.dot -o rv_2mm.pdf

echo "VPlan IR"
${opt} 2mm.ll -o vplan_2mm.ll -S --loop-vectorize --pass-remarks=loop-vectorize --pass-remarks-missed=loop-vectorize --pass-remarks-analysis=loop-vectorize --enable-vplan-native-path
${opt} -dot-cfg vplan_2mm.ll > /dev/null
dot -Tpdf .mm2_kernel1.dot -o vplan_2mm.pdf
