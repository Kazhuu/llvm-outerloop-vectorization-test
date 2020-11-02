; ModuleID = '2mm.c'
source_filename = "2mm.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nofree norecurse nounwind uwtable
define dso_local void @mm2_kernel1(float* nocapture %tmp, float* nocapture readonly %A, float* nocapture readonly %B, i32 %ni, i32 %nj, i32 %nk, i32 %nl, float %alpha, float %beta) local_unnamed_addr #0 {
entry:
  %0 = sext i32 %nj to i64
  %1 = sext i32 %nj to i64
  %2 = sext i32 %nk to i64
  br label %if.then

for.cond.cleanup3:                                ; preds = %for.inc25
  ret void

if.then:                                          ; preds = %entry, %for.inc25
  %indvars.iv56 = phi i64 [ 0, %entry ], [ %indvars.iv.next57, %for.inc25 ]
  %3 = mul nsw i64 %indvars.iv56, %1
  %arrayidx = getelementptr inbounds float, float* %tmp, i64 %3
  store float 0.000000e+00, float* %arrayidx, align 4, !tbaa !2, !llvm.access.group !6
  %4 = mul nsw i64 %indvars.iv56, %2
  br label %for.body9

for.body9:                                        ; preds = %if.then, %for.body9
  %indvars.iv = phi i64 [ 0, %if.then ], [ %indvars.iv.next, %for.body9 ]
  %5 = add nsw i64 %indvars.iv, %4
  %arrayidx13 = getelementptr inbounds float, float* %A, i64 %5
  %6 = load float, float* %arrayidx13, align 4, !tbaa !2, !llvm.access.group !6
  %mul14 = fmul float %6, %alpha
  %7 = mul nsw i64 %indvars.iv, %0
  %arrayidx18 = getelementptr inbounds float, float* %B, i64 %7
  %8 = load float, float* %arrayidx18, align 4, !tbaa !2, !llvm.access.group !6
  %mul19 = fmul float %mul14, %8
  %9 = load float, float* %arrayidx, align 4, !tbaa !2, !llvm.access.group !6
  %add24 = fadd float %9, %mul19
  store float %add24, float* %arrayidx, align 4, !tbaa !2, !llvm.access.group !6
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, 1024
  br i1 %exitcond.not, label %for.inc25, label %for.body9, !llvm.loop !7

for.inc25:                                        ; preds = %for.body9
  %indvars.iv.next57 = add nuw nsw i64 %indvars.iv56, 1
  %exitcond60.not = icmp eq i64 %indvars.iv.next57, 1024
  br i1 %exitcond60.not, label %for.cond.cleanup3, label %if.then, !llvm.loop !9
}

attributes #0 = { nofree norecurse nounwind uwtable "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (git@github.com:llvm/llvm-project.git 86ef379800162e5d6bb0d478c5bfb4b56498a272)"}
!2 = !{!3, !3, i64 0}
!3 = !{!"float", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
!6 = distinct !{}
!7 = distinct !{!7, !8}
!8 = !{!"llvm.loop.unroll.disable"}
!9 = distinct !{!9, !10, !8, !11, !12}
!10 = !{!"llvm.loop.parallel_accesses", !6}
!11 = !{!"llvm.loop.vectorize.width", i32 8}
!12 = !{!"llvm.loop.vectorize.enable", i1 true}
