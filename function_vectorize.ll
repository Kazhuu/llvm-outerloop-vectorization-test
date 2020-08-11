; ModuleID = 'function_vectorize.c'
source_filename = "function_vectorize.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nofree norecurse nounwind sspstrong uwtable
define dso_local void @foo_vectorize(double* noalias nocapture readonly %0, double* noalias nocapture readonly %1, double* noalias nocapture %2) local_unnamed_addr #0 {
  br label %5

4:                                                ; preds = %11
  ret void

5:                                                ; preds = %11, %3
  %6 = phi i64 [ 0, %3 ], [ %13, %11 ]
  %7 = getelementptr inbounds double, double* %0, i64 %6
  %8 = load double, double* %7, align 8, !tbaa !4
  %9 = getelementptr inbounds double, double* %1, i64 %6
  %10 = load double, double* %9, align 8, !tbaa !4
  br label %15

11:                                               ; preds = %15
  %12 = getelementptr inbounds double, double* %2, i64 %6
  store double %18, double* %12, align 8, !tbaa !4
  %13 = add nuw nsw i64 %6, 1
  %14 = icmp eq i64 %13, 1000
  br i1 %14, label %4, label %5, !llvm.loop !8

15:                                               ; preds = %15, %5
  %16 = phi i32 [ 0, %5 ], [ %19, %15 ]
  %17 = phi double [ %8, %5 ], [ %18, %15 ]
  %18 = fadd double %10, %17
  %19 = add nuw nsw i32 %16, 1
  %20 = icmp eq i32 %19, 10000
  br i1 %20, label %11, label %15
}

attributes #0 = { nofree norecurse nounwind sspstrong uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

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
!9 = !{!"llvm.loop.vectorize.enable", i1 true}
