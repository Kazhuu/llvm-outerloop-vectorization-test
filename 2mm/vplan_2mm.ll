; ModuleID = '2mm.ll'
source_filename = "2mm.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nofree norecurse nounwind uwtable
define dso_local void @mm2_kernel1(float* nocapture %tmp, float* nocapture readonly %A, float* nocapture readonly %B, i32 %ni, i32 %nj, i32 %nk, i32 %nl, float %alpha, float %beta) local_unnamed_addr #0 {
entry:
  %0 = sext i32 %nj to i64
  %1 = sext i32 %nj to i64
  %2 = sext i32 %nk to i64
  br i1 false, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %broadcast.splatinsert = insertelement <8 x i64> undef, i64 %1, i32 0
  %broadcast.splat = shufflevector <8 x i64> %broadcast.splatinsert, <8 x i64> undef, <8 x i32> zeroinitializer
  %broadcast.splatinsert1 = insertelement <8 x i64> undef, i64 %2, i32 0
  %broadcast.splat2 = shufflevector <8 x i64> %broadcast.splatinsert1, <8 x i64> undef, <8 x i32> zeroinitializer
  %broadcast.splatinsert4 = insertelement <8 x float> undef, float %alpha, i32 0
  %broadcast.splat5 = shufflevector <8 x float> %broadcast.splatinsert4, <8 x float> undef, <8 x i32> zeroinitializer
  %broadcast.splatinsert6 = insertelement <8 x i64> undef, i64 %0, i32 0
  %broadcast.splat7 = shufflevector <8 x i64> %broadcast.splatinsert6, <8 x i64> undef, <8 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %for.inc2510, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %for.inc2510 ]
  %vec.ind = phi <8 x i64> [ <i64 0, i64 1, i64 2, i64 3, i64 4, i64 5, i64 6, i64 7>, %vector.ph ], [ %vec.ind.next, %for.inc2510 ]
  %3 = mul nsw <8 x i64> %vec.ind, %broadcast.splat
  %4 = getelementptr inbounds float, float* %tmp, <8 x i64> %3
  call void @llvm.masked.scatter.v8f32.v8p0f32(<8 x float> zeroinitializer, <8 x float*> %4, i32 4, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>), !tbaa !2, !llvm.access.group !6
  %5 = mul nsw <8 x i64> %vec.ind, %broadcast.splat2
  br label %for.body93

for.body93:                                       ; preds = %for.body93, %vector.body
  %vec.phi = phi <8 x i64> [ %13, %for.body93 ], [ zeroinitializer, %vector.body ]
  %6 = add nsw <8 x i64> %vec.phi, %5
  %7 = getelementptr inbounds float, float* %A, <8 x i64> %6
  %wide.masked.gather = call <8 x float> @llvm.masked.gather.v8f32.v8p0f32(<8 x float*> %7, i32 4, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x float> undef), !tbaa !2, !llvm.access.group !6
  %8 = fmul <8 x float> %wide.masked.gather, %broadcast.splat5
  %9 = mul nsw <8 x i64> %vec.phi, %broadcast.splat7
  %10 = getelementptr inbounds float, float* %B, <8 x i64> %9
  %wide.masked.gather8 = call <8 x float> @llvm.masked.gather.v8f32.v8p0f32(<8 x float*> %10, i32 4, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x float> undef), !tbaa !2, !llvm.access.group !6
  %11 = fmul <8 x float> %8, %wide.masked.gather8
  %wide.masked.gather9 = call <8 x float> @llvm.masked.gather.v8f32.v8p0f32(<8 x float*> %4, i32 4, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x float> undef), !tbaa !2, !llvm.access.group !6
  %12 = fadd <8 x float> %wide.masked.gather9, %11
  call void @llvm.masked.scatter.v8f32.v8p0f32(<8 x float> %12, <8 x float*> %4, i32 4, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>), !tbaa !2, !llvm.access.group !6
  %13 = add nuw nsw <8 x i64> %vec.phi, <i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1>
  %14 = icmp eq <8 x i64> %13, <i64 1024, i64 1024, i64 1024, i64 1024, i64 1024, i64 1024, i64 1024, i64 1024>
  %15 = extractelement <8 x i1> %14, i32 0
  br i1 %15, label %for.inc2510, label %for.body93

for.inc2510:                                      ; preds = %for.body93
  %16 = add nuw nsw <8 x i64> %vec.ind, <i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1>
  %17 = icmp eq <8 x i64> %16, <i64 1024, i64 1024, i64 1024, i64 1024, i64 1024, i64 1024, i64 1024, i64 1024>
  %18 = extractelement <8 x i1> %17, i32 0
  %index.next = add i64 %index, 8
  %vec.ind.next = add <8 x i64> %vec.ind, <i64 8, i64 8, i64 8, i64 8, i64 8, i64 8, i64 8, i64 8>
  %19 = icmp eq i64 %index.next, 1024
  br i1 %19, label %middle.block, label %vector.body, !llvm.loop !7

middle.block:                                     ; preds = %for.inc2510
  %cmp.n = icmp eq i64 1024, 1024
  br i1 %cmp.n, label %for.cond.cleanup3, label %scalar.ph

scalar.ph:                                        ; preds = %middle.block, %entry
  %bc.resume.val = phi i64 [ 1024, %middle.block ], [ 0, %entry ]
  br label %if.then

for.cond.cleanup3:                                ; preds = %middle.block, %for.inc25
  ret void

if.then:                                          ; preds = %for.inc25, %scalar.ph
  %indvars.iv56 = phi i64 [ %bc.resume.val, %scalar.ph ], [ %indvars.iv.next57, %for.inc25 ]
  %20 = mul nsw i64 %indvars.iv56, %1
  %arrayidx = getelementptr inbounds float, float* %tmp, i64 %20
  store float 0.000000e+00, float* %arrayidx, align 4, !tbaa !2, !llvm.access.group !6
  %21 = mul nsw i64 %indvars.iv56, %2
  br label %for.body9

for.body9:                                        ; preds = %for.body9, %if.then
  %indvars.iv = phi i64 [ 0, %if.then ], [ %indvars.iv.next, %for.body9 ]
  %22 = add nsw i64 %indvars.iv, %21
  %arrayidx13 = getelementptr inbounds float, float* %A, i64 %22
  %23 = load float, float* %arrayidx13, align 4, !tbaa !2, !llvm.access.group !6
  %mul14 = fmul float %23, %alpha
  %24 = mul nsw i64 %indvars.iv, %0
  %arrayidx18 = getelementptr inbounds float, float* %B, i64 %24
  %25 = load float, float* %arrayidx18, align 4, !tbaa !2, !llvm.access.group !6
  %mul19 = fmul float %mul14, %25
  %26 = load float, float* %arrayidx, align 4, !tbaa !2, !llvm.access.group !6
  %add24 = fadd float %26, %mul19
  store float %add24, float* %arrayidx, align 4, !tbaa !2, !llvm.access.group !6
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, 1024
  br i1 %exitcond.not, label %for.inc25, label %for.body9, !llvm.loop !11

for.inc25:                                        ; preds = %for.body9
  %indvars.iv.next57 = add nuw nsw i64 %indvars.iv56, 1
  %exitcond60.not = icmp eq i64 %indvars.iv.next57, 1024
  br i1 %exitcond60.not, label %for.cond.cleanup3, label %if.then, !llvm.loop !12
}

; Function Attrs: nounwind willreturn writeonly
declare void @llvm.masked.scatter.v8f32.v8p0f32(<8 x float>, <8 x float*>, i32 immarg, <8 x i1>) #1

; Function Attrs: nounwind readonly willreturn
declare <8 x float> @llvm.masked.gather.v8f32.v8p0f32(<8 x float*>, i32 immarg, <8 x i1>, <8 x float>) #2

attributes #0 = { nofree norecurse nounwind uwtable "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind willreturn writeonly }
attributes #2 = { nounwind readonly willreturn }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (git@github.com:llvm/llvm-project.git 86ef379800162e5d6bb0d478c5bfb4b56498a272)"}
!2 = !{!3, !3, i64 0}
!3 = !{!"float", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
!6 = distinct !{}
!7 = distinct !{!7, !8, !9, !10}
!8 = !{!"llvm.loop.parallel_accesses", !6}
!9 = !{!"llvm.loop.unroll.disable"}
!10 = !{!"llvm.loop.isvectorized", i32 1}
!11 = distinct !{!11, !9}
!12 = distinct !{!12, !8, !9, !10}
