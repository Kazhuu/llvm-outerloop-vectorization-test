; ModuleID = 'pocl_noif_2mm_kernel1.ll'
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
  %_local_id_y.0 = phi i64 [ 0, %13 ], [ %47, %pregion_for_end.i ]
  %add6.i.i = add nuw nsw i64 %_local_id_y.0, %mul3.i.i, !llvm.access.group !12
  %conv2.i = trunc i64 %add6.i.i to i32, !llvm.access.group !12
  %mul.i = mul nsw i32 %conv2.i, %4, !llvm.access.group !12
  %mul4.i = mul nsw i32 %conv2.i, %5
  %15 = sext i32 %mul4.i to i64
  br i1 false, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %pregion_for_entry.pregion_for_init.i
  %broadcast.splatinsert = insertelement <8 x i64> undef, i64 %mul.i.i, i32 0
  %broadcast.splat = shufflevector <8 x i64> %broadcast.splatinsert, <8 x i64> undef, <8 x i32> zeroinitializer
  %broadcast.splatinsert1 = insertelement <8 x i32> undef, i32 %mul.i, i32 0
  %broadcast.splat2 = shufflevector <8 x i32> %broadcast.splatinsert1, <8 x i32> undef, <8 x i32> zeroinitializer
  %broadcast.splatinsert3 = insertelement <8 x i1> undef, i1 %cmp32.i, i32 0
  %broadcast.splat4 = shufflevector <8 x i1> %broadcast.splatinsert3, <8 x i1> undef, <8 x i32> zeroinitializer
  %broadcast.splatinsert8 = insertelement <8 x i64> undef, i64 %15, i32 0
  %broadcast.splat9 = shufflevector <8 x i64> %broadcast.splatinsert8, <8 x i64> undef, <8 x i32> zeroinitializer
  %broadcast.splatinsert10 = insertelement <8 x float> undef, float %7, i32 0
  %broadcast.splat11 = shufflevector <8 x float> %broadcast.splatinsert10, <8 x float> undef, <8 x i32> zeroinitializer
  %broadcast.splatinsert12 = insertelement <8 x i64> undef, i64 %14, i32 0
  %broadcast.splat13 = shufflevector <8 x i64> %broadcast.splatinsert12, <8 x i64> undef, <8 x i32> zeroinitializer
  %broadcast.splatinsert15 = insertelement <8 x i64> undef, i64 %wide.trip.count.i, i32 0
  %broadcast.splat16 = shufflevector <8 x i64> %broadcast.splatinsert15, <8 x i64> undef, <8 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %for.end.r_exit.i18, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %for.end.r_exit.i18 ]
  %vec.ind = phi <8 x i64> [ <i64 0, i64 1, i64 2, i64 3, i64 4, i64 5, i64 6, i64 7>, %vector.ph ], [ %vec.ind.next, %for.end.r_exit.i18 ]
  %16 = add nuw nsw <8 x i64> %vec.ind, %broadcast.splat, !llvm.access.group !12
  %17 = trunc <8 x i64> %16 to <8 x i32>, !llvm.access.group !12
  %18 = add nsw <8 x i32> %broadcast.splat2, %17, !llvm.access.group !12
  %19 = sext <8 x i32> %18 to <8 x i64>, !llvm.access.group !12
  %20 = getelementptr inbounds float, float* %0, <8 x i64> %19, !llvm.access.group !12
  call void @llvm.masked.scatter.v8f32.v8p0f32(<8 x float> zeroinitializer, <8 x float*> %20, i32 4, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>), !tbaa !15, !llvm.access.group !12
  %21 = extractelement <8 x i1> %broadcast.splat4, i32 0
  br i1 %21, label %for.body.lr.ph.i5, label %for.end.r_exit.i18

for.body.lr.ph.i5:                                ; preds = %vector.body
  %22 = shl <8 x i64> %16, <i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32>, !llvm.access.group !12
  %23 = ashr exact <8 x i64> %22, <i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32>, !llvm.access.group !12
  br label %for.body.i6

for.body.i6:                                      ; preds = %for.body.i6, %for.body.lr.ph.i5
  %vec.phi = phi <8 x i64> [ %31, %for.body.i6 ], [ zeroinitializer, %for.body.lr.ph.i5 ]
  %vec.phi7 = phi <8 x float> [ %30, %for.body.i6 ], [ zeroinitializer, %for.body.lr.ph.i5 ]
  %24 = add nsw <8 x i64> %vec.phi, %broadcast.splat9, !llvm.access.group !12
  %25 = getelementptr inbounds float, float* %1, <8 x i64> %24, !llvm.access.group !12
  %wide.masked.gather = call <8 x float> @llvm.masked.gather.v8f32.v8p0f32(<8 x float*> %25, i32 4, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x float> undef), !tbaa !15, !llvm.access.group !12
  %26 = fmul <8 x float> %wide.masked.gather, %broadcast.splat11, !llvm.access.group !12
  %27 = mul nsw <8 x i64> %vec.phi, %broadcast.splat13, !llvm.access.group !12
  %28 = add nsw <8 x i64> %27, %23, !llvm.access.group !12
  %29 = getelementptr inbounds float, float* %2, <8 x i64> %28, !llvm.access.group !12
  %wide.masked.gather14 = call <8 x float> @llvm.masked.gather.v8f32.v8p0f32(<8 x float*> %29, i32 4, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x float> undef), !tbaa !15, !llvm.access.group !12
  %30 = call <8 x float> @llvm.fmuladd.v8f32(<8 x float> %26, <8 x float> %wide.masked.gather14, <8 x float> %vec.phi7), !llvm.access.group !12
  call void @llvm.masked.scatter.v8f32.v8p0f32(<8 x float> %30, <8 x float*> %20, i32 4, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>), !tbaa !15, !llvm.access.group !12
  %31 = add nuw nsw <8 x i64> %vec.phi, <i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1>, !llvm.access.group !12
  %32 = icmp eq <8 x i64> %31, %broadcast.splat16, !llvm.access.group !12
  %33 = extractelement <8 x i1> %32, i32 0
  br i1 %33, label %for.end.r_exit.i.loopexit17, label %for.body.i6

for.end.r_exit.i.loopexit17:                      ; preds = %for.body.i6
  br label %for.end.r_exit.i18

for.end.r_exit.i18:                               ; preds = %vector.body, %for.end.r_exit.i.loopexit17
  %34 = add nuw nsw <8 x i64> %vec.ind, <i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1>
  %35 = icmp eq <8 x i64> %34, <i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32>
  %36 = extractelement <8 x i1> %35, i32 0
  %index.next = add i64 %index, 8
  %vec.ind.next = add <8 x i64> %vec.ind, <i64 8, i64 8, i64 8, i64 8, i64 8, i64 8, i64 8, i64 8>
  %37 = icmp eq i64 %index.next, 32
  br i1 %37, label %middle.block, label %vector.body, !llvm.loop !19

middle.block:                                     ; preds = %for.end.r_exit.i18
  %cmp.n = icmp eq i64 32, 32
  br i1 %cmp.n, label %pregion_for_end.i, label %scalar.ph

scalar.ph:                                        ; preds = %middle.block, %pregion_for_entry.pregion_for_init.i
  %bc.resume.val = phi i64 [ 32, %middle.block ], [ 0, %pregion_for_entry.pregion_for_init.i ]
  br label %pregion_for_entry.entry.i

pregion_for_entry.entry.i:                        ; preds = %for.end.r_exit.i, %scalar.ph
  %_local_id_x.0 = phi i64 [ %bc.resume.val, %scalar.ph ], [ %46, %for.end.r_exit.i ]
  %add1.i.i = add nuw nsw i64 %_local_id_x.0, %mul.i.i, !llvm.access.group !12
  %conv.i = trunc i64 %add1.i.i to i32, !llvm.access.group !12
  %add.i = add nsw i32 %mul.i, %conv.i, !llvm.access.group !12
  %idxprom.i = sext i32 %add.i to i64, !llvm.access.group !12
  %arrayidx.i = getelementptr inbounds float, float* %0, i64 %idxprom.i, !llvm.access.group !12
  store float 0.000000e+00, float* %arrayidx.i, align 4, !tbaa !15, !llvm.access.group !12
  br i1 %cmp32.i, label %for.body.lr.ph.i, label %for.end.r_exit.i, !llvm.access.group !12

for.body.lr.ph.i:                                 ; preds = %pregion_for_entry.entry.i
  %sext.i = shl i64 %add1.i.i, 32, !llvm.access.group !12
  %38 = ashr exact i64 %sext.i, 32, !llvm.access.group !12
  br label %for.body.i, !llvm.access.group !12

for.body.i:                                       ; preds = %for.body.i, %for.body.lr.ph.i
  %indvars.iv.next.i2 = phi i64 [ %indvars.iv.next.i, %for.body.i ], [ 0, %for.body.lr.ph.i ]
  %39 = phi float [ %45, %for.body.i ], [ 0.000000e+00, %for.body.lr.ph.i ]
  %40 = add nsw i64 %indvars.iv.next.i2, %15, !llvm.access.group !12
  %arrayidx7.i = getelementptr inbounds float, float* %1, i64 %40, !llvm.access.group !12
  %41 = load float, float* %arrayidx7.i, align 4, !tbaa !15, !llvm.access.group !12
  %mul8.i = fmul float %41, %7, !llvm.access.group !12
  %42 = mul nsw i64 %indvars.iv.next.i2, %14, !llvm.access.group !12
  %43 = add nsw i64 %42, %38, !llvm.access.group !12
  %arrayidx12.i = getelementptr inbounds float, float* %2, i64 %43, !llvm.access.group !12
  %44 = load float, float* %arrayidx12.i, align 4, !tbaa !15, !llvm.access.group !12
  %45 = call float @llvm.fmuladd.f32(float %mul8.i, float %44, float %39) #5, !llvm.access.group !12
  store float %45, float* %arrayidx.i, align 4, !tbaa !15, !llvm.access.group !12
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.next.i2, 1, !llvm.access.group !12
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, %wide.trip.count.i, !llvm.access.group !12
  br i1 %exitcond.not.i, label %for.end.r_exit.i.loopexit, label %for.body.i, !llvm.loop !22, !llvm.access.group !12

for.end.r_exit.i.loopexit:                        ; preds = %for.body.i
  br label %for.end.r_exit.i

for.end.r_exit.i:                                 ; preds = %for.end.r_exit.i.loopexit, %pregion_for_entry.entry.i
  %46 = add nuw nsw i64 %_local_id_x.0, 1
  %exitcond.not = icmp eq i64 %46, 32
  br i1 %exitcond.not, label %pregion_for_end.i, label %pregion_for_entry.entry.i, !llvm.loop !24

pregion_for_end.i:                                ; preds = %middle.block, %for.end.r_exit.i
  %47 = add nuw nsw i64 %_local_id_y.0, 1
  %exitcond3.not = icmp eq i64 %47, 8
  br i1 %exitcond3.not, label %mm2_kernel1.exit, label %pregion_for_entry.pregion_for_init.i, !llvm.loop !25

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
  %_local_id_y.i.0 = phi i64 [ 0, %5 ], [ %62, %pregion_for_end.i.i ]
  %add6.i.i.i = add nuw nsw i64 %_local_id_y.i.0, %mul3.i.i.i, !llvm.access.group !12
  %conv2.i.i = trunc i64 %add6.i.i.i to i32, !llvm.access.group !12
  %mul.i.i = mul nsw i32 %20, %conv2.i.i, !llvm.access.group !12
  %mul4.i.i = mul nsw i32 %24, %conv2.i.i
  %30 = sext i32 %mul4.i.i to i64
  br i1 false, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %pregion_for_entry.pregion_for_init.i.i
  %broadcast.splatinsert = insertelement <4 x i64> undef, i64 %mul.i.i.i, i32 0
  %broadcast.splat = shufflevector <4 x i64> %broadcast.splatinsert, <4 x i64> undef, <4 x i32> zeroinitializer
  %broadcast.splatinsert1 = insertelement <4 x i32> undef, i32 %mul.i.i, i32 0
  %broadcast.splat2 = shufflevector <4 x i32> %broadcast.splatinsert1, <4 x i32> undef, <4 x i32> zeroinitializer
  %broadcast.splatinsert3 = insertelement <4 x i1> undef, i1 %cmp32.i.i, i32 0
  %broadcast.splat4 = shufflevector <4 x i1> %broadcast.splatinsert3, <4 x i1> undef, <4 x i32> zeroinitializer
  %broadcast.splatinsert8 = insertelement <4 x i64> undef, i64 %30, i32 0
  %broadcast.splat9 = shufflevector <4 x i64> %broadcast.splatinsert8, <4 x i64> undef, <4 x i32> zeroinitializer
  %broadcast.splatinsert10 = insertelement <4 x float> undef, float %28, i32 0
  %broadcast.splat11 = shufflevector <4 x float> %broadcast.splatinsert10, <4 x float> undef, <4 x i32> zeroinitializer
  %broadcast.splatinsert12 = insertelement <4 x i64> undef, i64 %29, i32 0
  %broadcast.splat13 = shufflevector <4 x i64> %broadcast.splatinsert12, <4 x i64> undef, <4 x i32> zeroinitializer
  %broadcast.splatinsert15 = insertelement <4 x i64> undef, i64 %wide.trip.count.i.i, i32 0
  %broadcast.splat16 = shufflevector <4 x i64> %broadcast.splatinsert15, <4 x i64> undef, <4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %for.end.r_exit.i.i18, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %for.end.r_exit.i.i18 ]
  %vec.ind = phi <4 x i64> [ <i64 0, i64 1, i64 2, i64 3>, %vector.ph ], [ %vec.ind.next, %for.end.r_exit.i.i18 ]
  %31 = add nuw nsw <4 x i64> %vec.ind, %broadcast.splat, !llvm.access.group !12
  %32 = trunc <4 x i64> %31 to <4 x i32>, !llvm.access.group !12
  %33 = add nsw <4 x i32> %broadcast.splat2, %32, !llvm.access.group !12
  %34 = sext <4 x i32> %33 to <4 x i64>, !llvm.access.group !12
  %35 = getelementptr inbounds float, float* %8, <4 x i64> %34, !llvm.access.group !12
  call void @llvm.masked.scatter.v4f32.v4p0f32(<4 x float> zeroinitializer, <4 x float*> %35, i32 4, <4 x i1> <i1 true, i1 true, i1 true, i1 true>), !tbaa !15, !llvm.access.group !12
  %36 = extractelement <4 x i1> %broadcast.splat4, i32 0
  br i1 %36, label %for.body.lr.ph.i.i5, label %for.end.r_exit.i.i18

for.body.lr.ph.i.i5:                              ; preds = %vector.body
  %37 = shl <4 x i64> %31, <i64 32, i64 32, i64 32, i64 32>, !llvm.access.group !12
  %38 = ashr exact <4 x i64> %37, <i64 32, i64 32, i64 32, i64 32>, !llvm.access.group !12
  br label %for.body.i.i6

for.body.i.i6:                                    ; preds = %for.body.i.i6, %for.body.lr.ph.i.i5
  %vec.phi = phi <4 x i64> [ %46, %for.body.i.i6 ], [ zeroinitializer, %for.body.lr.ph.i.i5 ]
  %vec.phi7 = phi <4 x float> [ %45, %for.body.i.i6 ], [ zeroinitializer, %for.body.lr.ph.i.i5 ]
  %39 = add nsw <4 x i64> %vec.phi, %broadcast.splat9, !llvm.access.group !12
  %40 = getelementptr inbounds float, float* %12, <4 x i64> %39, !llvm.access.group !12
  %wide.masked.gather = call <4 x float> @llvm.masked.gather.v4f32.v4p0f32(<4 x float*> %40, i32 4, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, <4 x float> undef), !tbaa !15, !llvm.access.group !12
  %41 = fmul <4 x float> %broadcast.splat11, %wide.masked.gather, !llvm.access.group !12
  %42 = mul nsw <4 x i64> %vec.phi, %broadcast.splat13, !llvm.access.group !12
  %43 = add nsw <4 x i64> %42, %38, !llvm.access.group !12
  %44 = getelementptr inbounds float, float* %16, <4 x i64> %43, !llvm.access.group !12
  %wide.masked.gather14 = call <4 x float> @llvm.masked.gather.v4f32.v4p0f32(<4 x float*> %44, i32 4, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, <4 x float> undef), !tbaa !15, !llvm.access.group !12
  %45 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %41, <4 x float> %wide.masked.gather14, <4 x float> %vec.phi7), !llvm.access.group !12
  call void @llvm.masked.scatter.v4f32.v4p0f32(<4 x float> %45, <4 x float*> %35, i32 4, <4 x i1> <i1 true, i1 true, i1 true, i1 true>), !tbaa !15, !llvm.access.group !12
  %46 = add nuw nsw <4 x i64> %vec.phi, <i64 1, i64 1, i64 1, i64 1>, !llvm.access.group !12
  %47 = icmp eq <4 x i64> %46, %broadcast.splat16, !llvm.access.group !12
  %48 = extractelement <4 x i1> %47, i32 0
  br i1 %48, label %for.end.r_exit.i.i.loopexit17, label %for.body.i.i6

for.end.r_exit.i.i.loopexit17:                    ; preds = %for.body.i.i6
  br label %for.end.r_exit.i.i18

for.end.r_exit.i.i18:                             ; preds = %vector.body, %for.end.r_exit.i.i.loopexit17
  %49 = add nuw nsw <4 x i64> %vec.ind, <i64 1, i64 1, i64 1, i64 1>
  %50 = icmp eq <4 x i64> %49, <i64 32, i64 32, i64 32, i64 32>
  %51 = extractelement <4 x i1> %50, i32 0
  %index.next = add i64 %index, 4
  %vec.ind.next = add <4 x i64> %vec.ind, <i64 4, i64 4, i64 4, i64 4>
  %52 = icmp eq i64 %index.next, 32
  br i1 %52, label %middle.block, label %vector.body, !llvm.loop !27

middle.block:                                     ; preds = %for.end.r_exit.i.i18
  %cmp.n = icmp eq i64 32, 32
  br i1 %cmp.n, label %pregion_for_end.i.i, label %scalar.ph

scalar.ph:                                        ; preds = %middle.block, %pregion_for_entry.pregion_for_init.i.i
  %bc.resume.val = phi i64 [ 32, %middle.block ], [ 0, %pregion_for_entry.pregion_for_init.i.i ]
  br label %pregion_for_entry.entry.i.i

pregion_for_entry.entry.i.i:                      ; preds = %for.end.r_exit.i.i, %scalar.ph
  %_local_id_x.i.0 = phi i64 [ %bc.resume.val, %scalar.ph ], [ %61, %for.end.r_exit.i.i ]
  %add1.i.i.i = add nuw nsw i64 %_local_id_x.i.0, %mul.i.i.i, !llvm.access.group !12
  %conv.i.i = trunc i64 %add1.i.i.i to i32, !llvm.access.group !12
  %add.i.i = add nsw i32 %mul.i.i, %conv.i.i, !llvm.access.group !12
  %idxprom.i.i = sext i32 %add.i.i to i64, !llvm.access.group !12
  %arrayidx.i.i = getelementptr inbounds float, float* %8, i64 %idxprom.i.i, !llvm.access.group !12
  store float 0.000000e+00, float* %arrayidx.i.i, align 4, !tbaa !15, !llvm.access.group !12
  br i1 %cmp32.i.i, label %for.body.lr.ph.i.i, label %for.end.r_exit.i.i, !llvm.access.group !12

for.body.lr.ph.i.i:                               ; preds = %pregion_for_entry.entry.i.i
  %sext.i.i = shl i64 %add1.i.i.i, 32, !llvm.access.group !12
  %53 = ashr exact i64 %sext.i.i, 32, !llvm.access.group !12
  br label %for.body.i.i, !llvm.access.group !12

for.body.i.i:                                     ; preds = %for.body.i.i, %for.body.lr.ph.i.i
  %indvars.iv.next.i.i2 = phi i64 [ %indvars.iv.next.i.i, %for.body.i.i ], [ 0, %for.body.lr.ph.i.i ]
  %54 = phi float [ %60, %for.body.i.i ], [ 0.000000e+00, %for.body.lr.ph.i.i ]
  %55 = add nsw i64 %indvars.iv.next.i.i2, %30, !llvm.access.group !12
  %arrayidx7.i.i = getelementptr inbounds float, float* %12, i64 %55, !llvm.access.group !12
  %56 = load float, float* %arrayidx7.i.i, align 4, !tbaa !15, !llvm.access.group !12
  %mul8.i.i = fmul float %28, %56, !llvm.access.group !12
  %57 = mul nsw i64 %indvars.iv.next.i.i2, %29, !llvm.access.group !12
  %58 = add nsw i64 %57, %53, !llvm.access.group !12
  %arrayidx12.i.i = getelementptr inbounds float, float* %16, i64 %58, !llvm.access.group !12
  %59 = load float, float* %arrayidx12.i.i, align 4, !tbaa !15, !llvm.access.group !12
  %60 = call float @llvm.fmuladd.f32(float %mul8.i.i, float %59, float %54) #5, !llvm.access.group !12
  store float %60, float* %arrayidx.i.i, align 4, !tbaa !15, !llvm.access.group !12
  %indvars.iv.next.i.i = add nuw nsw i64 %indvars.iv.next.i.i2, 1, !llvm.access.group !12
  %exitcond.not.i.i = icmp eq i64 %indvars.iv.next.i.i, %wide.trip.count.i.i, !llvm.access.group !12
  br i1 %exitcond.not.i.i, label %for.end.r_exit.i.i.loopexit, label %for.body.i.i, !llvm.loop !22, !llvm.access.group !12

for.end.r_exit.i.i.loopexit:                      ; preds = %for.body.i.i
  br label %for.end.r_exit.i.i

for.end.r_exit.i.i:                               ; preds = %for.end.r_exit.i.i.loopexit, %pregion_for_entry.entry.i.i
  %61 = add nuw nsw i64 %_local_id_x.i.0, 1
  %exitcond.not = icmp eq i64 %61, 32
  br i1 %exitcond.not, label %pregion_for_end.i.i, label %pregion_for_entry.entry.i.i, !llvm.loop !28

pregion_for_end.i.i:                              ; preds = %middle.block, %for.end.r_exit.i.i
  %62 = add nuw nsw i64 %_local_id_y.i.0, 1
  %exitcond3.not = icmp eq i64 %62, 8
  br i1 %exitcond3.not, label %_pocl_kernel_mm2_kernel1.exit, label %pregion_for_entry.pregion_for_init.i.i, !llvm.loop !25

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
  %_local_id_y.i.0 = phi i64 [ 0, %5 ], [ %59, %pregion_for_end.i.i ]
  %add6.i.i.i = add nuw nsw i64 %_local_id_y.i.0, %mul3.i.i.i, !llvm.access.group !12
  %conv2.i.i = trunc i64 %add6.i.i.i to i32, !llvm.access.group !12
  %mul.i.i = mul nsw i32 %17, %conv2.i.i, !llvm.access.group !12
  %mul4.i.i = mul nsw i32 %21, %conv2.i.i
  %27 = sext i32 %mul4.i.i to i64
  br i1 false, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %pregion_for_entry.pregion_for_init.i.i
  %broadcast.splatinsert = insertelement <4 x i64> undef, i64 %mul.i.i.i, i32 0
  %broadcast.splat = shufflevector <4 x i64> %broadcast.splatinsert, <4 x i64> undef, <4 x i32> zeroinitializer
  %broadcast.splatinsert1 = insertelement <4 x i32> undef, i32 %mul.i.i, i32 0
  %broadcast.splat2 = shufflevector <4 x i32> %broadcast.splatinsert1, <4 x i32> undef, <4 x i32> zeroinitializer
  %broadcast.splatinsert3 = insertelement <4 x i1> undef, i1 %cmp32.i.i, i32 0
  %broadcast.splat4 = shufflevector <4 x i1> %broadcast.splatinsert3, <4 x i1> undef, <4 x i32> zeroinitializer
  %broadcast.splatinsert8 = insertelement <4 x i64> undef, i64 %27, i32 0
  %broadcast.splat9 = shufflevector <4 x i64> %broadcast.splatinsert8, <4 x i64> undef, <4 x i32> zeroinitializer
  %broadcast.splatinsert10 = insertelement <4 x float> undef, float %25, i32 0
  %broadcast.splat11 = shufflevector <4 x float> %broadcast.splatinsert10, <4 x float> undef, <4 x i32> zeroinitializer
  %broadcast.splatinsert12 = insertelement <4 x i64> undef, i64 %26, i32 0
  %broadcast.splat13 = shufflevector <4 x i64> %broadcast.splatinsert12, <4 x i64> undef, <4 x i32> zeroinitializer
  %broadcast.splatinsert15 = insertelement <4 x i64> undef, i64 %wide.trip.count.i.i, i32 0
  %broadcast.splat16 = shufflevector <4 x i64> %broadcast.splatinsert15, <4 x i64> undef, <4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %for.end.r_exit.i.i18, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %for.end.r_exit.i.i18 ]
  %vec.ind = phi <4 x i64> [ <i64 0, i64 1, i64 2, i64 3>, %vector.ph ], [ %vec.ind.next, %for.end.r_exit.i.i18 ]
  %28 = add nuw nsw <4 x i64> %vec.ind, %broadcast.splat, !llvm.access.group !12
  %29 = trunc <4 x i64> %28 to <4 x i32>, !llvm.access.group !12
  %30 = add nsw <4 x i32> %broadcast.splat2, %29, !llvm.access.group !12
  %31 = sext <4 x i32> %30 to <4 x i64>, !llvm.access.group !12
  %32 = getelementptr inbounds float, float* %7, <4 x i64> %31, !llvm.access.group !12
  call void @llvm.masked.scatter.v4f32.v4p0f32(<4 x float> zeroinitializer, <4 x float*> %32, i32 4, <4 x i1> <i1 true, i1 true, i1 true, i1 true>), !tbaa !15, !llvm.access.group !12
  %33 = extractelement <4 x i1> %broadcast.splat4, i32 0
  br i1 %33, label %for.body.lr.ph.i.i5, label %for.end.r_exit.i.i18

for.body.lr.ph.i.i5:                              ; preds = %vector.body
  %34 = shl <4 x i64> %28, <i64 32, i64 32, i64 32, i64 32>, !llvm.access.group !12
  %35 = ashr exact <4 x i64> %34, <i64 32, i64 32, i64 32, i64 32>, !llvm.access.group !12
  br label %for.body.i.i6

for.body.i.i6:                                    ; preds = %for.body.i.i6, %for.body.lr.ph.i.i5
  %vec.phi = phi <4 x i64> [ %43, %for.body.i.i6 ], [ zeroinitializer, %for.body.lr.ph.i.i5 ]
  %vec.phi7 = phi <4 x float> [ %42, %for.body.i.i6 ], [ zeroinitializer, %for.body.lr.ph.i.i5 ]
  %36 = add nsw <4 x i64> %vec.phi, %broadcast.splat9, !llvm.access.group !12
  %37 = getelementptr inbounds float, float* %10, <4 x i64> %36, !llvm.access.group !12
  %wide.masked.gather = call <4 x float> @llvm.masked.gather.v4f32.v4p0f32(<4 x float*> %37, i32 4, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, <4 x float> undef), !tbaa !15, !llvm.access.group !12
  %38 = fmul <4 x float> %broadcast.splat11, %wide.masked.gather, !llvm.access.group !12
  %39 = mul nsw <4 x i64> %vec.phi, %broadcast.splat13, !llvm.access.group !12
  %40 = add nsw <4 x i64> %39, %35, !llvm.access.group !12
  %41 = getelementptr inbounds float, float* %13, <4 x i64> %40, !llvm.access.group !12
  %wide.masked.gather14 = call <4 x float> @llvm.masked.gather.v4f32.v4p0f32(<4 x float*> %41, i32 4, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, <4 x float> undef), !tbaa !15, !llvm.access.group !12
  %42 = call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %38, <4 x float> %wide.masked.gather14, <4 x float> %vec.phi7), !llvm.access.group !12
  call void @llvm.masked.scatter.v4f32.v4p0f32(<4 x float> %42, <4 x float*> %32, i32 4, <4 x i1> <i1 true, i1 true, i1 true, i1 true>), !tbaa !15, !llvm.access.group !12
  %43 = add nuw nsw <4 x i64> %vec.phi, <i64 1, i64 1, i64 1, i64 1>, !llvm.access.group !12
  %44 = icmp eq <4 x i64> %43, %broadcast.splat16, !llvm.access.group !12
  %45 = extractelement <4 x i1> %44, i32 0
  br i1 %45, label %for.end.r_exit.i.i.loopexit17, label %for.body.i.i6

for.end.r_exit.i.i.loopexit17:                    ; preds = %for.body.i.i6
  br label %for.end.r_exit.i.i18

for.end.r_exit.i.i18:                             ; preds = %vector.body, %for.end.r_exit.i.i.loopexit17
  %46 = add nuw nsw <4 x i64> %vec.ind, <i64 1, i64 1, i64 1, i64 1>
  %47 = icmp eq <4 x i64> %46, <i64 32, i64 32, i64 32, i64 32>
  %48 = extractelement <4 x i1> %47, i32 0
  %index.next = add i64 %index, 4
  %vec.ind.next = add <4 x i64> %vec.ind, <i64 4, i64 4, i64 4, i64 4>
  %49 = icmp eq i64 %index.next, 32
  br i1 %49, label %middle.block, label %vector.body, !llvm.loop !29

middle.block:                                     ; preds = %for.end.r_exit.i.i18
  %cmp.n = icmp eq i64 32, 32
  br i1 %cmp.n, label %pregion_for_end.i.i, label %scalar.ph

scalar.ph:                                        ; preds = %middle.block, %pregion_for_entry.pregion_for_init.i.i
  %bc.resume.val = phi i64 [ 32, %middle.block ], [ 0, %pregion_for_entry.pregion_for_init.i.i ]
  br label %pregion_for_entry.entry.i.i

pregion_for_entry.entry.i.i:                      ; preds = %for.end.r_exit.i.i, %scalar.ph
  %_local_id_x.i.0 = phi i64 [ %bc.resume.val, %scalar.ph ], [ %58, %for.end.r_exit.i.i ]
  %add1.i.i.i = add nuw nsw i64 %_local_id_x.i.0, %mul.i.i.i, !llvm.access.group !12
  %conv.i.i = trunc i64 %add1.i.i.i to i32, !llvm.access.group !12
  %add.i.i = add nsw i32 %mul.i.i, %conv.i.i, !llvm.access.group !12
  %idxprom.i.i = sext i32 %add.i.i to i64, !llvm.access.group !12
  %arrayidx.i.i = getelementptr inbounds float, float* %7, i64 %idxprom.i.i, !llvm.access.group !12
  store float 0.000000e+00, float* %arrayidx.i.i, align 4, !tbaa !15, !llvm.access.group !12
  br i1 %cmp32.i.i, label %for.body.lr.ph.i.i, label %for.end.r_exit.i.i, !llvm.access.group !12

for.body.lr.ph.i.i:                               ; preds = %pregion_for_entry.entry.i.i
  %sext.i.i = shl i64 %add1.i.i.i, 32, !llvm.access.group !12
  %50 = ashr exact i64 %sext.i.i, 32, !llvm.access.group !12
  br label %for.body.i.i, !llvm.access.group !12

for.body.i.i:                                     ; preds = %for.body.i.i, %for.body.lr.ph.i.i
  %indvars.iv.next.i.i2 = phi i64 [ %indvars.iv.next.i.i, %for.body.i.i ], [ 0, %for.body.lr.ph.i.i ]
  %51 = phi float [ %57, %for.body.i.i ], [ 0.000000e+00, %for.body.lr.ph.i.i ]
  %52 = add nsw i64 %indvars.iv.next.i.i2, %27, !llvm.access.group !12
  %arrayidx7.i.i = getelementptr inbounds float, float* %10, i64 %52, !llvm.access.group !12
  %53 = load float, float* %arrayidx7.i.i, align 4, !tbaa !15, !llvm.access.group !12
  %mul8.i.i = fmul float %25, %53, !llvm.access.group !12
  %54 = mul nsw i64 %indvars.iv.next.i.i2, %26, !llvm.access.group !12
  %55 = add nsw i64 %54, %50, !llvm.access.group !12
  %arrayidx12.i.i = getelementptr inbounds float, float* %13, i64 %55, !llvm.access.group !12
  %56 = load float, float* %arrayidx12.i.i, align 4, !tbaa !15, !llvm.access.group !12
  %57 = call float @llvm.fmuladd.f32(float %mul8.i.i, float %56, float %51) #5, !llvm.access.group !12
  store float %57, float* %arrayidx.i.i, align 4, !tbaa !15, !llvm.access.group !12
  %indvars.iv.next.i.i = add nuw nsw i64 %indvars.iv.next.i.i2, 1, !llvm.access.group !12
  %exitcond.not.i.i = icmp eq i64 %indvars.iv.next.i.i, %wide.trip.count.i.i, !llvm.access.group !12
  br i1 %exitcond.not.i.i, label %for.end.r_exit.i.i.loopexit, label %for.body.i.i, !llvm.loop !22, !llvm.access.group !12

for.end.r_exit.i.i.loopexit:                      ; preds = %for.body.i.i
  br label %for.end.r_exit.i.i

for.end.r_exit.i.i:                               ; preds = %for.end.r_exit.i.i.loopexit, %pregion_for_entry.entry.i.i
  %58 = add nuw nsw i64 %_local_id_x.i.0, 1
  %exitcond.not = icmp eq i64 %58, 32
  br i1 %exitcond.not, label %pregion_for_end.i.i, label %pregion_for_entry.entry.i.i, !llvm.loop !30

pregion_for_end.i.i:                              ; preds = %middle.block, %for.end.r_exit.i.i
  %59 = add nuw nsw i64 %_local_id_y.i.0, 1
  %exitcond3.not = icmp eq i64 %59, 8
  br i1 %exitcond3.not, label %_pocl_kernel_mm2_kernel1.exit, label %pregion_for_entry.pregion_for_init.i.i, !llvm.loop !25

_pocl_kernel_mm2_kernel1.exit:                    ; preds = %pregion_for_end.i.i
  ret void
}

; Function Attrs: nounwind willreturn
declare void @llvm.masked.scatter.v8f32.v8p0f32(<8 x float>, <8 x float*>, i32 immarg, <8 x i1>) #3

; Function Attrs: nounwind readonly willreturn
declare <8 x float> @llvm.masked.gather.v8f32.v8p0f32(<8 x float*>, i32 immarg, <8 x i1>, <8 x float>) #4

; Function Attrs: nounwind readnone speculatable willreturn
declare <8 x float> @llvm.fmuladd.v8f32(<8 x float>, <8 x float>, <8 x float>) #0

; Function Attrs: nounwind willreturn
declare void @llvm.masked.scatter.v4f32.v4p0f32(<4 x float>, <4 x float*>, i32 immarg, <4 x i1>) #3

; Function Attrs: nounwind readonly willreturn
declare <4 x float> @llvm.masked.gather.v4f32.v4p0f32(<4 x float*>, i32 immarg, <4 x i1>, <4 x float>) #4

; Function Attrs: nounwind readnone speculatable willreturn
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #0

attributes #0 = { nounwind readnone speculatable willreturn }
attributes #1 = { alwaysinline nofree norecurse nounwind "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "stackrealign" "target-cpu"="skylake" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+invpcid,+lzcnt,+mmx,+movbe,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+sahf,+sgx,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves" "uniform-work-group-size"="true" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nofree nounwind }
attributes #3 = { nounwind willreturn }
attributes #4 = { nounwind readonly willreturn }
attributes #5 = { nounwind }

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
!19 = distinct !{!19, !20, !21}
!20 = !{!"llvm.loop.parallel_accesses", !13}
!21 = !{!"llvm.loop.isvectorized", i32 1}
!22 = distinct !{!22, !23}
!23 = !{!"llvm.loop.unroll.disable"}
!24 = distinct !{!24, !20, !21}
!25 = distinct !{!25, !26}
!26 = !{!"llvm.loop.parallel_accesses", !14}
!27 = distinct !{!27, !20, !21}
!28 = distinct !{!28, !20, !21}
!29 = distinct !{!29, !20, !21}
!30 = distinct !{!30, !20, !21}
