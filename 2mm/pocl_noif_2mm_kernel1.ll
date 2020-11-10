; ModuleID = 'parallel.bc'
source_filename = "parallel_bc"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind readnone speculatable willreturn
declare float @llvm.fmuladd.f32(float, float, float) #0

; Function Attrs: alwaysinline nofree norecurse nounwind
define void @_pocl_kernel_mm2_kernel1(float* nocapture %0, float* nocapture readonly %1, float* nocapture readonly %2, i32 %3, i32 %4, i32 %5, i32 %6, float %7, float %8, { [3 x i64], [3 x i64], [3 x i64], i8*, i32*, i32, i32 }* nocapture readnone %9, i64 %10, i64 %11, i64 %12) local_unnamed_addr #1 !kernel_arg_addr_space !5 !kernel_arg_access_qual !6 !kernel_arg_type !7 !kernel_arg_base_type !8 !kernel_arg_type_qual !9 !kernel_arg_name !10 !pocl_generated !11 {
  %mul.i.i = shl i64 %10, 5
  %mul3.i.i = shl i64 %11, 3
  %cmp32.i = icmp sgt i32 %5, 0, !llvm.access.group !12
  %14 = sext i32 %4 to i64
  %wide.trip.count.i = zext i32 %5 to i64
  br label %pregion_for_entry.pregion_for_init.i

pregion_for_entry.pregion_for_init.i:             ; preds = %pregion_for_end.i, %13
  %_local_id_y.0 = phi i64 [ 0, %13 ], [ %25, %pregion_for_end.i ]
  %add6.i.i = add nuw nsw i64 %_local_id_y.0, %mul3.i.i, !llvm.access.group !12
  %conv2.i = trunc i64 %add6.i.i to i32, !llvm.access.group !12
  %mul.i = mul nsw i32 %conv2.i, %4, !llvm.access.group !12
  %mul4.i = mul nsw i32 %conv2.i, %5
  %15 = sext i32 %mul4.i to i64
  br label %pregion_for_entry.entry.i

pregion_for_entry.entry.i:                        ; preds = %for.end.r_exit.i, %pregion_for_entry.pregion_for_init.i
  %_local_id_x.0 = phi i64 [ 0, %pregion_for_entry.pregion_for_init.i ], [ %24, %for.end.r_exit.i ]
  %add1.i.i = add nuw nsw i64 %_local_id_x.0, %mul.i.i, !llvm.access.group !12
  %conv.i = trunc i64 %add1.i.i to i32, !llvm.access.group !12
  %add.i = add nsw i32 %mul.i, %conv.i, !llvm.access.group !12
  %idxprom.i = sext i32 %add.i to i64, !llvm.access.group !12
  %arrayidx.i = getelementptr inbounds float, float* %0, i64 %idxprom.i, !llvm.access.group !12
  store float 0.000000e+00, float* %arrayidx.i, align 4, !tbaa !15, !llvm.access.group !12
  br i1 %cmp32.i, label %for.body.lr.ph.i, label %for.end.r_exit.i, !llvm.access.group !12

for.body.lr.ph.i:                                 ; preds = %pregion_for_entry.entry.i
  %sext.i = shl i64 %add1.i.i, 32, !llvm.access.group !12
  %16 = ashr exact i64 %sext.i, 32, !llvm.access.group !12
  br label %for.body.i, !llvm.access.group !12

for.body.i:                                       ; preds = %for.body.i, %for.body.lr.ph.i
  %indvars.iv.next.i2 = phi i64 [ %indvars.iv.next.i, %for.body.i ], [ 0, %for.body.lr.ph.i ]
  %17 = phi float [ %23, %for.body.i ], [ 0.000000e+00, %for.body.lr.ph.i ]
  %18 = add nsw i64 %indvars.iv.next.i2, %15, !llvm.access.group !12
  %arrayidx7.i = getelementptr inbounds float, float* %1, i64 %18, !llvm.access.group !12
  %19 = load float, float* %arrayidx7.i, align 4, !tbaa !15, !llvm.access.group !12
  %mul8.i = fmul float %19, %7, !llvm.access.group !12
  %20 = mul nsw i64 %indvars.iv.next.i2, %14, !llvm.access.group !12
  %21 = add nsw i64 %20, %16, !llvm.access.group !12
  %arrayidx12.i = getelementptr inbounds float, float* %2, i64 %21, !llvm.access.group !12
  %22 = load float, float* %arrayidx12.i, align 4, !tbaa !15, !llvm.access.group !12
  %23 = call float @llvm.fmuladd.f32(float %mul8.i, float %22, float %17) #3, !llvm.access.group !12
  store float %23, float* %arrayidx.i, align 4, !tbaa !15, !llvm.access.group !12
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.next.i2, 1, !llvm.access.group !12
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, %wide.trip.count.i, !llvm.access.group !12
  br i1 %exitcond.not.i, label %for.end.r_exit.i.loopexit, label %for.body.i, !llvm.loop !19, !llvm.access.group !12

for.end.r_exit.i.loopexit:                        ; preds = %for.body.i
  br label %for.end.r_exit.i

for.end.r_exit.i:                                 ; preds = %for.end.r_exit.i.loopexit, %pregion_for_entry.entry.i
  %24 = add nuw nsw i64 %_local_id_x.0, 1
  %exitcond.not = icmp eq i64 %24, 32
  br i1 %exitcond.not, label %pregion_for_end.i, label %pregion_for_entry.entry.i, !llvm.loop !21

pregion_for_end.i:                                ; preds = %for.end.r_exit.i
  %25 = add nuw nsw i64 %_local_id_y.0, 1
  %exitcond3.not = icmp eq i64 %25, 8
  br i1 %exitcond3.not, label %mm2_kernel1.exit, label %pregion_for_entry.pregion_for_init.i, !llvm.loop !24

mm2_kernel1.exit:                                 ; preds = %pregion_for_end.i
  ret void
}

; Function Attrs: nofree nounwind
define void @_pocl_kernel_mm2_kernel1_workgroup(i8** nocapture readonly %0, { [3 x i64], [3 x i64], [3 x i64], i8*, i32*, i32, i32 }* nocapture readnone %1, i64 %2, i64 %3, i64 %4) local_unnamed_addr #2 {
  %6 = bitcast i8** %0 to float***
  %7 = load float**, float*** %6, align 8
  %8 = load float*, float** %7, align 8
  %9 = getelementptr i8*, i8** %0, i64 1
  %10 = bitcast i8** %9 to float***
  %11 = load float**, float*** %10, align 8
  %12 = load float*, float** %11, align 8
  %13 = getelementptr i8*, i8** %0, i64 2
  %14 = bitcast i8** %13 to float***
  %15 = load float**, float*** %14, align 8
  %16 = load float*, float** %15, align 8
  %17 = getelementptr i8*, i8** %0, i64 4
  %18 = bitcast i8** %17 to i32**
  %19 = load i32*, i32** %18, align 8
  %20 = load i32, i32* %19, align 4
  %21 = getelementptr i8*, i8** %0, i64 5
  %22 = bitcast i8** %21 to i32**
  %23 = load i32*, i32** %22, align 8
  %24 = load i32, i32* %23, align 4
  %25 = getelementptr i8*, i8** %0, i64 7
  %26 = bitcast i8** %25 to float**
  %27 = load float*, float** %26, align 8
  %28 = load float, float* %27, align 4
  %mul.i.i.i = shl i64 %2, 5
  %mul3.i.i.i = shl i64 %3, 3
  %cmp32.i.i = icmp sgt i32 %24, 0, !llvm.access.group !12
  %29 = sext i32 %20 to i64
  %wide.trip.count.i.i = zext i32 %24 to i64
  br label %pregion_for_entry.pregion_for_init.i.i

pregion_for_entry.pregion_for_init.i.i:           ; preds = %pregion_for_end.i.i, %5
  %_local_id_y.i.0 = phi i64 [ 0, %5 ], [ %40, %pregion_for_end.i.i ]
  %add6.i.i.i = add nuw nsw i64 %_local_id_y.i.0, %mul3.i.i.i, !llvm.access.group !12
  %conv2.i.i = trunc i64 %add6.i.i.i to i32, !llvm.access.group !12
  %mul.i.i = mul nsw i32 %20, %conv2.i.i, !llvm.access.group !12
  %mul4.i.i = mul nsw i32 %24, %conv2.i.i
  %30 = sext i32 %mul4.i.i to i64
  br label %pregion_for_entry.entry.i.i

pregion_for_entry.entry.i.i:                      ; preds = %for.end.r_exit.i.i, %pregion_for_entry.pregion_for_init.i.i
  %_local_id_x.i.0 = phi i64 [ 0, %pregion_for_entry.pregion_for_init.i.i ], [ %39, %for.end.r_exit.i.i ]
  %add1.i.i.i = add nuw nsw i64 %_local_id_x.i.0, %mul.i.i.i, !llvm.access.group !12
  %conv.i.i = trunc i64 %add1.i.i.i to i32, !llvm.access.group !12
  %add.i.i = add nsw i32 %mul.i.i, %conv.i.i, !llvm.access.group !12
  %idxprom.i.i = sext i32 %add.i.i to i64, !llvm.access.group !12
  %arrayidx.i.i = getelementptr inbounds float, float* %8, i64 %idxprom.i.i, !llvm.access.group !12
  store float 0.000000e+00, float* %arrayidx.i.i, align 4, !tbaa !15, !llvm.access.group !12
  br i1 %cmp32.i.i, label %for.body.lr.ph.i.i, label %for.end.r_exit.i.i, !llvm.access.group !12

for.body.lr.ph.i.i:                               ; preds = %pregion_for_entry.entry.i.i
  %sext.i.i = shl i64 %add1.i.i.i, 32, !llvm.access.group !12
  %31 = ashr exact i64 %sext.i.i, 32, !llvm.access.group !12
  br label %for.body.i.i, !llvm.access.group !12

for.body.i.i:                                     ; preds = %for.body.i.i, %for.body.lr.ph.i.i
  %indvars.iv.next.i.i2 = phi i64 [ %indvars.iv.next.i.i, %for.body.i.i ], [ 0, %for.body.lr.ph.i.i ]
  %32 = phi float [ %38, %for.body.i.i ], [ 0.000000e+00, %for.body.lr.ph.i.i ]
  %33 = add nsw i64 %indvars.iv.next.i.i2, %30, !llvm.access.group !12
  %arrayidx7.i.i = getelementptr inbounds float, float* %12, i64 %33, !llvm.access.group !12
  %34 = load float, float* %arrayidx7.i.i, align 4, !tbaa !15, !llvm.access.group !12
  %mul8.i.i = fmul float %28, %34, !llvm.access.group !12
  %35 = mul nsw i64 %indvars.iv.next.i.i2, %29, !llvm.access.group !12
  %36 = add nsw i64 %35, %31, !llvm.access.group !12
  %arrayidx12.i.i = getelementptr inbounds float, float* %16, i64 %36, !llvm.access.group !12
  %37 = load float, float* %arrayidx12.i.i, align 4, !tbaa !15, !llvm.access.group !12
  %38 = call float @llvm.fmuladd.f32(float %mul8.i.i, float %37, float %32) #3, !llvm.access.group !12
  store float %38, float* %arrayidx.i.i, align 4, !tbaa !15, !llvm.access.group !12
  %indvars.iv.next.i.i = add nuw nsw i64 %indvars.iv.next.i.i2, 1, !llvm.access.group !12
  %exitcond.not.i.i = icmp eq i64 %indvars.iv.next.i.i, %wide.trip.count.i.i, !llvm.access.group !12
  br i1 %exitcond.not.i.i, label %for.end.r_exit.i.i.loopexit, label %for.body.i.i, !llvm.loop !19, !llvm.access.group !12

for.end.r_exit.i.i.loopexit:                      ; preds = %for.body.i.i
  br label %for.end.r_exit.i.i

for.end.r_exit.i.i:                               ; preds = %for.end.r_exit.i.i.loopexit, %pregion_for_entry.entry.i.i
  %39 = add nuw nsw i64 %_local_id_x.i.0, 1
  %exitcond.not = icmp eq i64 %39, 32
  br i1 %exitcond.not, label %pregion_for_end.i.i, label %pregion_for_entry.entry.i.i, !llvm.loop !21

pregion_for_end.i.i:                              ; preds = %for.end.r_exit.i.i
  %40 = add nuw nsw i64 %_local_id_y.i.0, 1
  %exitcond3.not = icmp eq i64 %40, 8
  br i1 %exitcond3.not, label %_pocl_kernel_mm2_kernel1.exit, label %pregion_for_entry.pregion_for_init.i.i, !llvm.loop !24

_pocl_kernel_mm2_kernel1.exit:                    ; preds = %pregion_for_end.i.i
  ret void
}

; Function Attrs: nofree nounwind
define void @_pocl_kernel_mm2_kernel1_workgroup_fast(i8** nocapture readonly %0, { [3 x i64], [3 x i64], [3 x i64], i8*, i32*, i32, i32 }* nocapture readnone %1, i64 %2, i64 %3, i64 %4) local_unnamed_addr #2 {
  %6 = bitcast i8** %0 to float**
  %7 = load float*, float** %6, align 8
  %8 = getelementptr i8*, i8** %0, i64 1
  %9 = bitcast i8** %8 to float**
  %10 = load float*, float** %9, align 8
  %11 = getelementptr i8*, i8** %0, i64 2
  %12 = bitcast i8** %11 to float**
  %13 = load float*, float** %12, align 8
  %14 = getelementptr i8*, i8** %0, i64 4
  %15 = bitcast i8** %14 to i32**
  %16 = load i32*, i32** %15, align 8
  %17 = load i32, i32* %16, align 4
  %18 = getelementptr i8*, i8** %0, i64 5
  %19 = bitcast i8** %18 to i32**
  %20 = load i32*, i32** %19, align 8
  %21 = load i32, i32* %20, align 4
  %22 = getelementptr i8*, i8** %0, i64 7
  %23 = bitcast i8** %22 to float**
  %24 = load float*, float** %23, align 8
  %25 = load float, float* %24, align 4
  %mul.i.i.i = shl i64 %2, 5
  %mul3.i.i.i = shl i64 %3, 3
  %cmp32.i.i = icmp sgt i32 %21, 0, !llvm.access.group !12
  %26 = sext i32 %17 to i64
  %wide.trip.count.i.i = zext i32 %21 to i64
  br label %pregion_for_entry.pregion_for_init.i.i

pregion_for_entry.pregion_for_init.i.i:           ; preds = %pregion_for_end.i.i, %5
  %_local_id_y.i.0 = phi i64 [ 0, %5 ], [ %37, %pregion_for_end.i.i ]
  %add6.i.i.i = add nuw nsw i64 %_local_id_y.i.0, %mul3.i.i.i, !llvm.access.group !12
  %conv2.i.i = trunc i64 %add6.i.i.i to i32, !llvm.access.group !12
  %mul.i.i = mul nsw i32 %17, %conv2.i.i, !llvm.access.group !12
  %mul4.i.i = mul nsw i32 %21, %conv2.i.i
  %27 = sext i32 %mul4.i.i to i64
  br label %pregion_for_entry.entry.i.i

pregion_for_entry.entry.i.i:                      ; preds = %for.end.r_exit.i.i, %pregion_for_entry.pregion_for_init.i.i
  %_local_id_x.i.0 = phi i64 [ 0, %pregion_for_entry.pregion_for_init.i.i ], [ %36, %for.end.r_exit.i.i ]
  %add1.i.i.i = add nuw nsw i64 %_local_id_x.i.0, %mul.i.i.i, !llvm.access.group !12
  %conv.i.i = trunc i64 %add1.i.i.i to i32, !llvm.access.group !12
  %add.i.i = add nsw i32 %mul.i.i, %conv.i.i, !llvm.access.group !12
  %idxprom.i.i = sext i32 %add.i.i to i64, !llvm.access.group !12
  %arrayidx.i.i = getelementptr inbounds float, float* %7, i64 %idxprom.i.i, !llvm.access.group !12
  store float 0.000000e+00, float* %arrayidx.i.i, align 4, !tbaa !15, !llvm.access.group !12
  br i1 %cmp32.i.i, label %for.body.lr.ph.i.i, label %for.end.r_exit.i.i, !llvm.access.group !12

for.body.lr.ph.i.i:                               ; preds = %pregion_for_entry.entry.i.i
  %sext.i.i = shl i64 %add1.i.i.i, 32, !llvm.access.group !12
  %28 = ashr exact i64 %sext.i.i, 32, !llvm.access.group !12
  br label %for.body.i.i, !llvm.access.group !12

for.body.i.i:                                     ; preds = %for.body.i.i, %for.body.lr.ph.i.i
  %indvars.iv.next.i.i2 = phi i64 [ %indvars.iv.next.i.i, %for.body.i.i ], [ 0, %for.body.lr.ph.i.i ]
  %29 = phi float [ %35, %for.body.i.i ], [ 0.000000e+00, %for.body.lr.ph.i.i ]
  %30 = add nsw i64 %indvars.iv.next.i.i2, %27, !llvm.access.group !12
  %arrayidx7.i.i = getelementptr inbounds float, float* %10, i64 %30, !llvm.access.group !12
  %31 = load float, float* %arrayidx7.i.i, align 4, !tbaa !15, !llvm.access.group !12
  %mul8.i.i = fmul float %25, %31, !llvm.access.group !12
  %32 = mul nsw i64 %indvars.iv.next.i.i2, %26, !llvm.access.group !12
  %33 = add nsw i64 %32, %28, !llvm.access.group !12
  %arrayidx12.i.i = getelementptr inbounds float, float* %13, i64 %33, !llvm.access.group !12
  %34 = load float, float* %arrayidx12.i.i, align 4, !tbaa !15, !llvm.access.group !12
  %35 = call float @llvm.fmuladd.f32(float %mul8.i.i, float %34, float %29) #3, !llvm.access.group !12
  store float %35, float* %arrayidx.i.i, align 4, !tbaa !15, !llvm.access.group !12
  %indvars.iv.next.i.i = add nuw nsw i64 %indvars.iv.next.i.i2, 1, !llvm.access.group !12
  %exitcond.not.i.i = icmp eq i64 %indvars.iv.next.i.i, %wide.trip.count.i.i, !llvm.access.group !12
  br i1 %exitcond.not.i.i, label %for.end.r_exit.i.i.loopexit, label %for.body.i.i, !llvm.loop !19, !llvm.access.group !12

for.end.r_exit.i.i.loopexit:                      ; preds = %for.body.i.i
  br label %for.end.r_exit.i.i

for.end.r_exit.i.i:                               ; preds = %for.end.r_exit.i.i.loopexit, %pregion_for_entry.entry.i.i
  %36 = add nuw nsw i64 %_local_id_x.i.0, 1
  %exitcond.not = icmp eq i64 %36, 32
  br i1 %exitcond.not, label %pregion_for_end.i.i, label %pregion_for_entry.entry.i.i, !llvm.loop !21

pregion_for_end.i.i:                              ; preds = %for.end.r_exit.i.i
  %37 = add nuw nsw i64 %_local_id_y.i.0, 1
  %exitcond3.not = icmp eq i64 %37, 8
  br i1 %exitcond3.not, label %_pocl_kernel_mm2_kernel1.exit, label %pregion_for_entry.pregion_for_init.i.i, !llvm.loop !24

_pocl_kernel_mm2_kernel1.exit:                    ; preds = %pregion_for_end.i.i
  ret void
}

attributes #0 = { nounwind readnone speculatable willreturn }
attributes #1 = { alwaysinline nofree norecurse nounwind "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "stackrealign" "target-cpu"="skylake" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+invpcid,+lzcnt,+mmx,+movbe,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+sahf,+sgx,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves" "uniform-work-group-size"="true" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nofree nounwind }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0, !1, !2}
!opencl.ocl.version = !{!3}
!llvm.ident = !{!4}
!opencl.spir.version = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 1, i32 2}
!4 = !{!"clang version 12.0.0 (git@github.com:llvm/llvm-project.git a95b25b29ecf498afa17ad526226ae3a4271d228)"}
!5 = !{i32 1, i32 1, i32 1, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0}
!6 = !{!"none", !"none", !"none", !"none", !"none", !"none", !"none", !"none", !"none"}
!7 = !{!"DATA_TYPE*", !"DATA_TYPE*", !"DATA_TYPE*", !"int", !"int", !"int", !"int", !"DATA_TYPE", !"DATA_TYPE"}
!8 = !{!"float*", !"float*", !"float*", !"int", !"int", !"int", !"int", !"float", !"float"}
!9 = !{!"", !"", !"", !"", !"", !"", !"", !"", !""}
!10 = !{!"tmp", !"A", !"B", !"ni", !"nj", !"nk", !"nl", !"alpha", !"beta"}
!11 = !{i32 1}
!12 = !{!13, !14}
!13 = distinct !{}
!14 = distinct !{}
!15 = !{!16, !16, i64 0}
!16 = !{!"float", !17, i64 0}
!17 = !{!"omnipotent char", !18, i64 0}
!18 = !{!"Simple C/C++ TBAA"}
!19 = distinct !{!19, !20}
!20 = !{!"llvm.loop.unroll.disable"}
!21 = distinct !{!21, !22, !23}
!22 = !{!"llvm.loop.parallel_accesses", !13}
!23 = !{!"llvm.loop.vectorize.enable", i1 true}
!24 = distinct !{!24, !25}
!25 = !{!"llvm.loop.parallel_accesses", !14}
