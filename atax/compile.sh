llvm_dir="/home/kazooie/local/llvm/rv/bin"
opt="${llvm_dir}/opt"
debug="--debug"

#file="pocl_atax_kernel1.ll"
file="pocl_noif_atax_kernel1.ll"
dot_file="._pocl_kernel_atax_kernel1.dot"

echo "POCL IR"
${opt} -dot-cfg ${file} > /dev/null 2>&1
dot -Tpdf ${dot_file} -o ${file}.pdf

printf "\n\n\n\n"
echo "VPlan IR with native path"
${opt} ${file} -o vplan_${file} -S ${debug} --loop-vectorize --pass-remarks=loop-vectorize --pass-remarks-missed=loop-vectorize --pass-remarks-analysis=loop-vectorize --enable-vplan-native-path
${opt} -dot-cfg vplan_${file} > /dev/null 2>&1
dot -Tpdf ${dot_file} -o vplan_${file}.pdf

printf "\n\n\n\n"
echo "VPlan IR with predication"
${opt} ${file} -o vplan_predicate_${file} -S ${debug} --loop-vectorize --pass-remarks=loop-vectorize --pass-remarks-missed=loop-vectorize --pass-remarks-analysis=loop-vectorize --enable-vplan-native-path --enable-vplan-predication
${opt} -dot-cfg vplan_predicate_${file} > /dev/null 2>&1
dot -Tpdf ${dot_file} -o vplan_predicate_${file}.pdf

printf "\n\n\n\n"
echo "RV IR"
${opt} ${file} --load=libRV.so -o rv_${file} -S ${debug} --rv-loopvec --rv-loop-vectorize --pass-remarks=rv-loop --pass-remarks-missed=rv-loop --pass-remarks-analysis=rv-loop
${opt} -dot-cfg rv_${file} > /dev/null 2>&1
dot -Tpdf ${dot_file} -o rv_${file}.pdf

printf "\nResults:\n"
if grep -q vectorized vplan_${file}; then
  echo "VPlan native path vectorized!"
else
  echo "VPlan native path not vectorized!"
fi
if grep -q vectorized vplan_predicate_${file}; then
  echo "VPlan with predication vectorized!"
else
  echo "VPlan with predication not vectorized!"
fi
if grep -q vectorized rv_${file}; then
  echo "RV vectorized!"
else
  echo "RV not vectorized!"
fi
