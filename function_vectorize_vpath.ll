; ModuleID = '/home/kazooie/programming/loop-vectorize-llvm/function_vectorize.ll'
source_filename = "function_vectorize.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nofree norecurse nounwind sspstrong uwtable
define dso_local void @foo_vectorize(double* noalias nocapture readonly %0, double* noalias nocapture readonly %1, double* noalias nocapture %2) local_unnamed_addr #0 {
  br i1 false, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %3
  br label %vector.body

vector.body:                                      ; preds = %vector.body.latch, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body.latch ]
  %vec.ind = phi <2 x i64> [ <i64 0, i64 1>, %vector.ph ], [ %vec.ind.next, %vector.body.latch ]
  %4 = getelementptr inbounds double, double* %0, <2 x i64> %vec.ind
  %wide.masked.gather = call <2 x double> @llvm.masked.gather.v2f64.v2p0f64(<2 x double*> %4, i32 8, <2 x i1> <i1 true, i1 true>, <2 x double> undef), !tbaa !4
  %5 = getelementptr inbounds double, double* %1, <2 x i64> %vec.ind
  %wide.masked.gather1 = call <2 x double> @llvm.masked.gather.v2f64.v2p0f64(<2 x double*> %5, i32 8, <2 x i1> <i1 true, i1 true>, <2 x double> undef), !tbaa !4
  br label %6

6:                                                ; preds = %6, %vector.body
  %vec.phi = phi <2 x i32> [ %8, %6 ], [ zeroinitializer, %vector.body ]
  %vec.phi2 = phi <2 x double> [ %7, %6 ], [ %wide.masked.gather, %vector.body ]
  %7 = fadd <2 x double> %wide.masked.gather1, %vec.phi2
  %8 = add nuw nsw <2 x i32> %vec.phi, <i32 1, i32 1>
  %9 = icmp eq <2 x i32> %8, <i32 10000, i32 10000>
  %10 = extractelement <2 x i1> %9, i32 0
  br i1 %10, label %vector.body.latch, label %6

vector.body.latch:                                ; preds = %6
  %vec.phi3 = phi <2 x double> [ %7, %6 ]
  %11 = getelementptr inbounds double, double* %2, <2 x i64> %vec.ind
  call void @llvm.masked.scatter.v2f64.v2p0f64(<2 x double> %vec.phi3, <2 x double*> %11, i32 8, <2 x i1> <i1 true, i1 true>), !tbaa !4
  %12 = add nuw nsw <2 x i64> %vec.ind, <i64 1, i64 1>
  %13 = icmp eq <2 x i64> %12, <i64 1000, i64 1000>
  %14 = extractelement <2 x i1> %13, i32 0
  %index.next = add i64 %index, 2
  %vec.ind.next = add <2 x i64> %vec.ind, <i64 2, i64 2>
  %15 = icmp eq i64 %index.next, 1000
  br i1 %15, label %middle.block, label %vector.body, !llvm.loop !8

middle.block:                                     ; preds = %vector.body.latch
  %cmp.n = icmp eq i64 1000, 1000
  br i1 %cmp.n, label %16, label %scalar.ph

scalar.ph:                                        ; preds = %middle.block, %3
  %bc.resume.val = phi i64 [ 1000, %middle.block ], [ 0, %3 ]
  br label %17

16:                                               ; preds = %middle.block, %23
  ret void

17:                                               ; preds = %23, %scalar.ph
  %18 = phi i64 [ %bc.resume.val, %scalar.ph ], [ %25, %23 ]
  %19 = getelementptr inbounds double, double* %0, i64 %18
  %20 = load double, double* %19, align 8, !tbaa !4
  %21 = getelementptr inbounds double, double* %1, i64 %18
  %22 = load double, double* %21, align 8, !tbaa !4
  br label %27

23:                                               ; preds = %27
  %.lcssa = phi double [ %30, %27 ]
  %24 = getelementptr inbounds double, double* %2, i64 %18
  store double %.lcssa, double* %24, align 8, !tbaa !4
  %25 = add nuw nsw i64 %18, 1
  %26 = icmp eq i64 %25, 1000
  br i1 %26, label %16, label %17, !llvm.loop !10

27:                                               ; preds = %27, %17
  %28 = phi i32 [ 0, %17 ], [ %31, %27 ]
  %29 = phi double [ %20, %17 ], [ %30, %27 ]
  %30 = fadd double %22, %29
  %31 = add nuw nsw i32 %28, 1
  %32 = icmp eq i32 %31, 10000
  br i1 %32, label %23, label %27
}

; Function Attrs: nounwind readonly willreturn
declare <2 x double> @llvm.masked.gather.v2f64.v2p0f64(<2 x double*>, i32 immarg, <2 x i1>, <2 x double>) #1

; Function Attrs: nounwind willreturn
declare void @llvm.masked.scatter.v2f64.v2p0f64(<2 x double>, <2 x double*>, i32 immarg, <2 x i1>) #2

attributes #0 = { nofree norecurse nounwind sspstrong uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly willreturn }
attributes #2 = { nounwind willreturn }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{!"clang version 10.0.0 "}
!4 = !{!5, !5, i64 0}
!5 = !{!"double", !6, i64 0}
!6 = !{!"omnipotent char", !7, i64 0}
!7 = !{!"Simple C/C++ TBAA"}
!8 = distinct !{!8, !9}
!9 = !{!"llvm.loop.isvectorized", i32 1}
!10 = distinct !{!10, !9}
