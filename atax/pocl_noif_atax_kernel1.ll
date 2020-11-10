; ModuleID = 'parallel.bc'
source_filename = "parallel_bc"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind readnone speculatable willreturn
declare float @llvm.fmuladd.f32(float, float, float) #0

; Function Attrs: alwaysinline nofree norecurse nounwind
define void @_pocl_kernel_atax_kernel1(float* nocapture readonly %0, float* nocapture readonly %1, float* nocapture %2, i64 %3, i32 %4, { [3 x i64], [3 x i64], [3 x i64], i8*, i32*, i32, i32 }* nocapture readnone %5, i64 %6, i64 %7, i64 %8) local_unnamed_addr #1 !kernel_arg_addr_space !5 !kernel_arg_access_qual !6 !kernel_arg_type !7 !kernel_arg_base_type !8 !kernel_arg_type_qual !9 !kernel_arg_name !10 !pocl_generated !11 {
  %mul.i.i = shl i64 %6, 5
  %cmp14.i = icmp sgt i32 %4, 0, !llvm.access.group !12
  %wide.trip.count.i = zext i32 %4 to i64
  br label %pregion_for_entry.entry.i

pregion_for_entry.entry.i:                        ; preds = %for.end.r_exit.i, %9
  %_local_id_x.0 = phi i64 [ 0, %9 ], [ %16, %for.end.r_exit.i ]
  %add1.i.i = add nuw nsw i64 %_local_id_x.0, %mul.i.i, !llvm.access.group !12
  br i1 %cmp14.i, label %for.body.lr.ph.i, label %for.end.r_exit.i, !llvm.access.group !12

for.body.lr.ph.i:                                 ; preds = %pregion_for_entry.entry.i
  %conv.i = trunc i64 %add1.i.i to i32, !llvm.access.group !12
  %mul.i = mul nsw i32 %conv.i, %4, !llvm.access.group !12
  %sext.i = shl i64 %add1.i.i, 32, !llvm.access.group !12
  %idxprom5.i = ashr exact i64 %sext.i, 32, !llvm.access.group !12
  %arrayidx6.i = getelementptr inbounds float, float* %2, i64 %idxprom5.i, !llvm.access.group !12
  %10 = sext i32 %mul.i to i64, !llvm.access.group !12
  %.pre.i = load float, float* %arrayidx6.i, align 4, !tbaa !14, !llvm.access.group !12
  br label %for.body.i, !llvm.access.group !12

for.body.i:                                       ; preds = %for.body.i, %for.body.lr.ph.i
  %indvars.iv.next.i2 = phi i64 [ %indvars.iv.next.i, %for.body.i ], [ 0, %for.body.lr.ph.i ]
  %11 = phi float [ %15, %for.body.i ], [ %.pre.i, %for.body.lr.ph.i ]
  %12 = add nsw i64 %indvars.iv.next.i2, %10, !llvm.access.group !12
  %arrayidx.i = getelementptr inbounds float, float* %0, i64 %12, !llvm.access.group !12
  %13 = load float, float* %arrayidx.i, align 4, !tbaa !14, !llvm.access.group !12
  %arrayidx3.i = getelementptr inbounds float, float* %1, i64 %indvars.iv.next.i2, !llvm.access.group !12
  %14 = load float, float* %arrayidx3.i, align 4, !tbaa !14, !llvm.access.group !12
  %15 = call float @llvm.fmuladd.f32(float %13, float %14, float %11) #3, !llvm.access.group !12
  store float %15, float* %arrayidx6.i, align 4, !tbaa !14, !llvm.access.group !12
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.next.i2, 1, !llvm.access.group !12
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, %wide.trip.count.i, !llvm.access.group !12
  br i1 %exitcond.not.i, label %for.end.r_exit.i.loopexit, label %for.body.i, !llvm.loop !18, !llvm.access.group !12

for.end.r_exit.i.loopexit:                        ; preds = %for.body.i
  br label %for.end.r_exit.i

for.end.r_exit.i:                                 ; preds = %for.end.r_exit.i.loopexit, %pregion_for_entry.entry.i
  %16 = add nuw nsw i64 %_local_id_x.0, 1
  %exitcond.not = icmp slt i64 %16, %3
  br i1 %exitcond.not, label %atax_kernel1.exit, label %pregion_for_entry.entry.i, !llvm.loop !20

atax_kernel1.exit:                                ; preds = %for.end.r_exit.i
  ret void
}

; Function Attrs: nofree nounwind
define void @_pocl_kernel_atax_kernel1_workgroup(i8** nocapture readonly %0, { [3 x i64], [3 x i64], [3 x i64], i8*, i32*, i32, i32 }* nocapture readnone %1, i64 %2, i64 %3, i64 %4) local_unnamed_addr #2 {
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
  %mul.i.i.i = shl i64 %2, 5
  %cmp14.i.i = icmp sgt i32 %20, 0, !llvm.access.group !12
  %wide.trip.count.i.i = zext i32 %20 to i64
  br label %pregion_for_entry.entry.i.i

pregion_for_entry.entry.i.i:                      ; preds = %for.end.r_exit.i.i, %5
  %_local_id_x.i.0 = phi i64 [ 0, %5 ], [ %27, %for.end.r_exit.i.i ]
  %add1.i.i.i = add nuw nsw i64 %_local_id_x.i.0, %mul.i.i.i, !llvm.access.group !12
  br i1 %cmp14.i.i, label %for.body.lr.ph.i.i, label %for.end.r_exit.i.i, !llvm.access.group !12

for.body.lr.ph.i.i:                               ; preds = %pregion_for_entry.entry.i.i
  %conv.i.i = trunc i64 %add1.i.i.i to i32, !llvm.access.group !12
  %mul.i.i = mul nsw i32 %20, %conv.i.i, !llvm.access.group !12
  %sext.i.i = shl i64 %add1.i.i.i, 32, !llvm.access.group !12
  %idxprom5.i.i = ashr exact i64 %sext.i.i, 32, !llvm.access.group !12
  %arrayidx6.i.i = getelementptr inbounds float, float* %16, i64 %idxprom5.i.i, !llvm.access.group !12
  %21 = sext i32 %mul.i.i to i64, !llvm.access.group !12
  %.pre.i.i = load float, float* %arrayidx6.i.i, align 4, !tbaa !14, !llvm.access.group !12
  br label %for.body.i.i, !llvm.access.group !12

for.body.i.i:                                     ; preds = %for.body.i.i, %for.body.lr.ph.i.i
  %indvars.iv.next.i.i2 = phi i64 [ %indvars.iv.next.i.i, %for.body.i.i ], [ 0, %for.body.lr.ph.i.i ]
  %22 = phi float [ %26, %for.body.i.i ], [ %.pre.i.i, %for.body.lr.ph.i.i ]
  %23 = add nsw i64 %indvars.iv.next.i.i2, %21, !llvm.access.group !12
  %arrayidx.i.i = getelementptr inbounds float, float* %8, i64 %23, !llvm.access.group !12
  %24 = load float, float* %arrayidx.i.i, align 4, !tbaa !14, !llvm.access.group !12
  %arrayidx3.i.i = getelementptr inbounds float, float* %12, i64 %indvars.iv.next.i.i2, !llvm.access.group !12
  %25 = load float, float* %arrayidx3.i.i, align 4, !tbaa !14, !llvm.access.group !12
  %26 = call float @llvm.fmuladd.f32(float %24, float %25, float %22) #3, !llvm.access.group !12
  store float %26, float* %arrayidx6.i.i, align 4, !tbaa !14, !llvm.access.group !12
  %indvars.iv.next.i.i = add nuw nsw i64 %indvars.iv.next.i.i2, 1, !llvm.access.group !12
  %exitcond.not.i.i = icmp eq i64 %indvars.iv.next.i.i, %wide.trip.count.i.i, !llvm.access.group !12
  br i1 %exitcond.not.i.i, label %for.end.r_exit.i.i.loopexit, label %for.body.i.i, !llvm.loop !18, !llvm.access.group !12

for.end.r_exit.i.i.loopexit:                      ; preds = %for.body.i.i
  br label %for.end.r_exit.i.i

for.end.r_exit.i.i:                               ; preds = %for.end.r_exit.i.i.loopexit, %pregion_for_entry.entry.i.i
  %27 = add nuw nsw i64 %_local_id_x.i.0, 1
  %exitcond.not = icmp eq i64 %27, 32
  br i1 %exitcond.not, label %_pocl_kernel_atax_kernel1.exit, label %pregion_for_entry.entry.i.i, !llvm.loop !20

_pocl_kernel_atax_kernel1.exit:                   ; preds = %for.end.r_exit.i.i
  ret void
}

; Function Attrs: nofree nounwind
define void @_pocl_kernel_atax_kernel1_workgroup_fast(i8** nocapture readonly %0, { [3 x i64], [3 x i64], [3 x i64], i8*, i32*, i32, i32 }* nocapture readnone %1, i64 %2, i64 %3, i64 %4) local_unnamed_addr #2 {
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
  %mul.i.i.i = shl i64 %2, 5
  %cmp14.i.i = icmp sgt i32 %17, 0, !llvm.access.group !12
  %wide.trip.count.i.i = zext i32 %17 to i64
  br label %pregion_for_entry.entry.i.i

pregion_for_entry.entry.i.i:                      ; preds = %for.end.r_exit.i.i, %5
  %_local_id_x.i.0 = phi i64 [ 0, %5 ], [ %24, %for.end.r_exit.i.i ]
  %add1.i.i.i = add nuw nsw i64 %_local_id_x.i.0, %mul.i.i.i, !llvm.access.group !12
  br i1 %cmp14.i.i, label %for.body.lr.ph.i.i, label %for.end.r_exit.i.i, !llvm.access.group !12

for.body.lr.ph.i.i:                               ; preds = %pregion_for_entry.entry.i.i
  %conv.i.i = trunc i64 %add1.i.i.i to i32, !llvm.access.group !12
  %mul.i.i = mul nsw i32 %17, %conv.i.i, !llvm.access.group !12
  %sext.i.i = shl i64 %add1.i.i.i, 32, !llvm.access.group !12
  %idxprom5.i.i = ashr exact i64 %sext.i.i, 32, !llvm.access.group !12
  %arrayidx6.i.i = getelementptr inbounds float, float* %13, i64 %idxprom5.i.i, !llvm.access.group !12
  %18 = sext i32 %mul.i.i to i64, !llvm.access.group !12
  %.pre.i.i = load float, float* %arrayidx6.i.i, align 4, !tbaa !14, !llvm.access.group !12
  br label %for.body.i.i, !llvm.access.group !12

for.body.i.i:                                     ; preds = %for.body.i.i, %for.body.lr.ph.i.i
  %indvars.iv.next.i.i2 = phi i64 [ %indvars.iv.next.i.i, %for.body.i.i ], [ 0, %for.body.lr.ph.i.i ]
  %19 = phi float [ %23, %for.body.i.i ], [ %.pre.i.i, %for.body.lr.ph.i.i ]
  %20 = add nsw i64 %indvars.iv.next.i.i2, %18, !llvm.access.group !12
  %arrayidx.i.i = getelementptr inbounds float, float* %7, i64 %20, !llvm.access.group !12
  %21 = load float, float* %arrayidx.i.i, align 4, !tbaa !14, !llvm.access.group !12
  %arrayidx3.i.i = getelementptr inbounds float, float* %10, i64 %indvars.iv.next.i.i2, !llvm.access.group !12
  %22 = load float, float* %arrayidx3.i.i, align 4, !tbaa !14, !llvm.access.group !12
  %23 = call float @llvm.fmuladd.f32(float %21, float %22, float %19) #3, !llvm.access.group !12
  store float %23, float* %arrayidx6.i.i, align 4, !tbaa !14, !llvm.access.group !12
  %indvars.iv.next.i.i = add nuw nsw i64 %indvars.iv.next.i.i2, 1, !llvm.access.group !12
  %exitcond.not.i.i = icmp eq i64 %indvars.iv.next.i.i, %wide.trip.count.i.i, !llvm.access.group !12
  br i1 %exitcond.not.i.i, label %for.end.r_exit.i.i.loopexit, label %for.body.i.i, !llvm.loop !18, !llvm.access.group !12

for.end.r_exit.i.i.loopexit:                      ; preds = %for.body.i.i
  br label %for.end.r_exit.i.i

for.end.r_exit.i.i:                               ; preds = %for.end.r_exit.i.i.loopexit, %pregion_for_entry.entry.i.i
  %24 = add nuw nsw i64 %_local_id_x.i.0, 1
  %exitcond.not = icmp eq i64 %24, 32
  br i1 %exitcond.not, label %_pocl_kernel_atax_kernel1.exit, label %pregion_for_entry.entry.i.i, !llvm.loop !20

_pocl_kernel_atax_kernel1.exit:                   ; preds = %for.end.r_exit.i.i
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
!5 = !{i32 1, i32 1, i32 1, i32 0, i32 0}
!6 = !{!"none", !"none", !"none", !"none", !"none"}
!7 = !{!"DATA_TYPE*", !"DATA_TYPE*", !"DATA_TYPE*", !"int", !"int"}
!8 = !{!"float*", !"float*", !"float*", !"int", !"int"}
!9 = !{!"", !"", !"", !"", !""}
!10 = !{!"A", !"x", !"tmp", !"nx", !"ny"}
!11 = !{i32 1}
!12 = !{!13}
!13 = distinct !{}
!14 = !{!15, !15, i64 0}
!15 = !{!"float", !16, i64 0}
!16 = !{!"omnipotent char", !17, i64 0}
!17 = !{!"Simple C/C++ TBAA"}
!18 = distinct !{!18, !19}
!19 = !{!"llvm.loop.unroll.disable"}
!20 = distinct !{!20, !21, !22, !23}
!21 = !{!"llvm.loop.parallel_accesses", !13}
!22 = !{!"llvm.loop.vectorize.enable", i1 true}
!23 = !{!"llvm.loop.vectorize.width", i32 8}
