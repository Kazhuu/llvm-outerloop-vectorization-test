; ModuleID = 'pocl_noif_atax_kernel1.ll'
source_filename = "parallel_bc"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare float @llvm.fmuladd.f32(float, float, float) #0

; Function Attrs: alwaysinline nofree norecurse nounwind
define void @_pocl_kernel_atax_kernel1(float* nocapture readonly %0, float* nocapture readonly %1, float* nocapture %2, i64 %3, i32 %4, { [3 x i64], [3 x i64], [3 x i64], i8*, i32*, i32, i32 }* nocapture readnone %5, i64 %6, i64 %7, i64 %8) local_unnamed_addr #1 !kernel_arg_addr_space !5 !kernel_arg_access_qual !6 !kernel_arg_type !7 !kernel_arg_base_type !8 !kernel_arg_type_qual !9 !kernel_arg_name !10 !pocl_generated !11 {
  %mul.i.i = shl i64 %6, 5
  %cmp14.i = icmp sgt i32 %4, 0, !llvm.access.group !12
  %wide.trip.count.i = zext i32 %4 to i64
  %.splatinsert6 = insertelement <8 x i32> undef, i32 %4, i32 0
  %.splat7 = shufflevector <8 x i32> %.splatinsert6, <8 x i32> undef, <8 x i32> zeroinitializer
  %.splatinsert14 = insertelement <8 x i64> undef, i64 %3, i32 0
  %.splat15 = shufflevector <8 x i64> %.splatinsert14, <8 x i64> undef, <8 x i32> zeroinitializer
  br label %pregion_for_entry.entry.i.vecg

pregion_for_entry.entry.iC:                       ; No predecessors!
  unreachable

for.body.lr.ph.iC:                                ; No predecessors!
  unreachable

for.body.iC:                                      ; No predecessors!
  unreachable

for.end.r_exit.i.loopexitC:                       ; No predecessors!
  unreachable

for.end.r_exit.iC:                                ; No predecessors!
  unreachable

pregion_for_entry.entry.i.vecg:                   ; preds = %9
  %exitcond.not.vecGuard = icmp slt i64 7, %3
  br i1 %exitcond.not.vecGuard, label %pregion_for_entry.entry.i.scag, label %pregion_for_entry.entry.iC.rv

pregion_for_entry.entry.i.scag:                   ; preds = %pregion_for_entry.entry.i.vec2scalar, %pregion_for_entry.entry.i.vecg
  %_local_id_x.0.scaGuard = phi i64 [ %.red, %pregion_for_entry.entry.i.vec2scalar ], [ 0, %pregion_for_entry.entry.i.vecg ]
  br label %pregion_for_entry.entry.i

pregion_for_entry.entry.i.vec2scalar:             ; preds = %for.end.r_exit.iC.rv
  %.red = add i64 %29, 7
  %exitcond.not.v2s = icmp slt i64 %.red, %3
  br i1 %exitcond.not.v2s, label %atax_kernel1.exit, label %pregion_for_entry.entry.i.scag

pregion_for_entry.entry.i:                        ; preds = %pregion_for_entry.entry.i.scag, %for.end.r_exit.i
  %_local_id_x.0 = phi i64 [ %_local_id_x.0.scaGuard, %pregion_for_entry.entry.i.scag ], [ %16, %for.end.r_exit.i ]
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
  %15 = call float @llvm.fmuladd.f32(float %13, float %14, float %11) #4, !llvm.access.group !12
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

atax_kernel1.exit:                                ; preds = %pregion_for_entry.entry.i.vec2scalar, %for.end.r_exit.i
  ret void

pregion_for_entry.entry.iC.rv:                    ; preds = %pregion_for_entry.entry.i.vecg, %for.end.r_exit.iC.rv
  %_local_id_x.0C1 = phi i64 [ 0, %pregion_for_entry.entry.i.vecg ], [ %30, %for.end.r_exit.iC.rv ]
  %add1.i.iC2 = add nuw nsw i64 %_local_id_x.0C1, %mul.i.i, !llvm.access.group !12
  %17 = add nuw nsw i64 %_local_id_x.0C1, 15
  %exitcond.not.vecExit3 = icmp slt i64 %17, %3
  %neg.cmp14.i4 = xor i1 %cmp14.i, true
  br i1 %cmp14.i, label %for.body.lr.ph.iC.rv, label %for.end.r_exit.iC.rv, !llvm.access.group !12

for.body.lr.ph.iC.rv:                             ; preds = %pregion_for_entry.entry.iC.rv
  %conv.iC5 = trunc i64 %add1.i.iC2 to i32, !llvm.access.group !12
  %.splatinsert = insertelement <8 x i32> undef, i32 %conv.iC5, i32 0
  %.splat = shufflevector <8 x i32> %.splatinsert, <8 x i32> undef, <8 x i32> zeroinitializer
  %contiguous_add = add <8 x i32> %.splat, <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %mul.iC_SIMD = mul nsw <8 x i32> %contiguous_add, %.splat7, !llvm.access.group !12
  %sext.iC8 = shl i64 %add1.i.iC2, 32, !llvm.access.group !12
  %idxprom5.iC9 = ashr exact i64 %sext.iC8, 32, !llvm.access.group !12
  %18 = sext <8 x i32> %mul.iC_SIMD to <8 x i64>, !llvm.access.group !12
  %arrayidx6.iC10 = getelementptr inbounds float, float* %2, i64 %idxprom5.iC9
  %vec_cast = bitcast float* %arrayidx6.iC10 to <8 x float>*
  %cont_load = load <8 x float>, <8 x float>* %vec_cast, align 4
  br label %for.body.iC.rv, !llvm.access.group !12

for.body.iC.rv:                                   ; preds = %for.body.iC.rv, %for.body.lr.ph.iC.rv
  %indvars.iv.next.i2C16 = phi i64 [ %indvars.iv.next.iC45, %for.body.iC.rv ], [ 0, %for.body.lr.ph.iC.rv ]
  %_SIMD = phi <8 x float> [ %scalarized43, %for.body.iC.rv ], [ %cont_load, %for.body.lr.ph.iC.rv ]
  %extract42 = extractelement <8 x float> %_SIMD, i32 7
  %extract39 = extractelement <8 x float> %_SIMD, i32 6
  %extract36 = extractelement <8 x float> %_SIMD, i32 5
  %extract33 = extractelement <8 x float> %_SIMD, i32 4
  %extract30 = extractelement <8 x float> %_SIMD, i32 3
  %extract27 = extractelement <8 x float> %_SIMD, i32 2
  %extract24 = extractelement <8 x float> %_SIMD, i32 1
  %extract22 = extractelement <8 x float> %_SIMD, i32 0
  %.splatinsert17 = insertelement <8 x i64> undef, i64 %indvars.iv.next.i2C16, i32 0
  %.splat18 = shufflevector <8 x i64> %.splatinsert17, <8 x i64> undef, <8 x i32> zeroinitializer
  %19 = add nsw <8 x i64> %.splat18, %18, !llvm.access.group !12
  %arrayidx.iC19 = getelementptr inbounds float, float* %0, <8 x i64> %19
  %20 = call <8 x float> @llvm.masked.gather.v8f32.v8p0f32(<8 x float*> %arrayidx.iC19, i32 4, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x float> undef)
  %extract41 = extractelement <8 x float> %20, i32 7
  %extract38 = extractelement <8 x float> %20, i32 6
  %extract35 = extractelement <8 x float> %20, i32 5
  %extract32 = extractelement <8 x float> %20, i32 4
  %extract29 = extractelement <8 x float> %20, i32 3
  %extract26 = extractelement <8 x float> %20, i32 2
  %extract23 = extractelement <8 x float> %20, i32 1
  %extract = extractelement <8 x float> %20, i32 0
  %arrayidx3.iC20 = getelementptr inbounds float, float* %1, i64 %indvars.iv.next.i2C16
  %cont_load21 = load float, float* %arrayidx3.iC20, align 4
  %21 = call float @llvm.fmuladd.f32(float %extract, float %cont_load21, float %extract22) #4, !llvm.access.group !12
  %scalarized = insertelement <8 x float> undef, float %21, i64 0
  %22 = call float @llvm.fmuladd.f32(float %extract23, float %cont_load21, float %extract24) #4, !llvm.access.group !12
  %scalarized25 = insertelement <8 x float> %scalarized, float %22, i64 1
  %23 = call float @llvm.fmuladd.f32(float %extract26, float %cont_load21, float %extract27) #4, !llvm.access.group !12
  %scalarized28 = insertelement <8 x float> %scalarized25, float %23, i64 2
  %24 = call float @llvm.fmuladd.f32(float %extract29, float %cont_load21, float %extract30) #4, !llvm.access.group !12
  %scalarized31 = insertelement <8 x float> %scalarized28, float %24, i64 3
  %25 = call float @llvm.fmuladd.f32(float %extract32, float %cont_load21, float %extract33) #4, !llvm.access.group !12
  %scalarized34 = insertelement <8 x float> %scalarized31, float %25, i64 4
  %26 = call float @llvm.fmuladd.f32(float %extract35, float %cont_load21, float %extract36) #4, !llvm.access.group !12
  %scalarized37 = insertelement <8 x float> %scalarized34, float %26, i64 5
  %27 = call float @llvm.fmuladd.f32(float %extract38, float %cont_load21, float %extract39) #4, !llvm.access.group !12
  %scalarized40 = insertelement <8 x float> %scalarized37, float %27, i64 6
  %28 = call float @llvm.fmuladd.f32(float %extract41, float %cont_load21, float %extract42) #4, !llvm.access.group !12
  %scalarized43 = insertelement <8 x float> %scalarized40, float %28, i64 7
  %vec_cast44 = bitcast float* %arrayidx6.iC10 to <8 x float>*
  store <8 x float> %scalarized43, <8 x float>* %vec_cast44, align 4
  %indvars.iv.next.iC45 = add nuw nsw i64 %indvars.iv.next.i2C16, 1, !llvm.access.group !12
  %exitcond.not.iC46 = icmp eq i64 %indvars.iv.next.iC45, %wide.trip.count.i, !llvm.access.group !12
  br i1 %exitcond.not.iC46, label %for.end.r_exit.i.loopexitC.rv, label %for.body.iC.rv, !llvm.loop !18, !llvm.access.group !12

for.end.r_exit.i.loopexitC.rv:                    ; preds = %for.body.iC.rv
  br label %for.end.r_exit.iC.rv

for.end.r_exit.iC.rv:                             ; preds = %for.end.r_exit.i.loopexitC.rv, %pregion_for_entry.entry.iC.rv
  %29 = add nuw nsw i64 %_local_id_x.0C1, 1
  %30 = add nuw nsw i64 %_local_id_x.0C1, 8
  %.splatinsert11 = insertelement <8 x i64> undef, i64 %29, i32 0
  %.splat12 = shufflevector <8 x i64> %.splatinsert11, <8 x i64> undef, <8 x i32> zeroinitializer
  %contiguous_add13 = add <8 x i64> %.splat12, <i64 0, i64 1, i64 2, i64 3, i64 4, i64 5, i64 6, i64 7>
  %exitcond.notC_SIMD = icmp slt <8 x i64> %contiguous_add13, %.splat15
  br i1 %exitcond.not.vecExit3, label %pregion_for_entry.entry.i.vec2scalar, label %pregion_for_entry.entry.iC.rv, !llvm.loop !21
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
  %.splatinsert = insertelement <8 x i32> undef, i32 %20, i32 0
  %.splat = shufflevector <8 x i32> %.splatinsert, <8 x i32> undef, <8 x i32> zeroinitializer
  br label %pregion_for_entry.entry.i.i.vecg

pregion_for_entry.entry.i.iC:                     ; No predecessors!
  unreachable

for.body.lr.ph.i.iC:                              ; No predecessors!
  unreachable

for.body.i.iC:                                    ; No predecessors!
  unreachable

for.end.r_exit.i.i.loopexitC:                     ; No predecessors!
  unreachable

for.end.r_exit.i.iC:                              ; No predecessors!
  unreachable

pregion_for_entry.entry.i.i.vecg:                 ; preds = %5
  %exitcond.not.vecGuard = icmp sge i64 8, 32
  br i1 %exitcond.not.vecGuard, label %pregion_for_entry.entry.i.i.scag, label %pregion_for_entry.entry.i.iC.rv

pregion_for_entry.entry.i.i.scag:                 ; preds = %pregion_for_entry.entry.i.i.vec2scalar, %pregion_for_entry.entry.i.i.vecg
  %_local_id_x.i.0.scaGuard = phi i64 [ %.red, %pregion_for_entry.entry.i.i.vec2scalar ], [ 0, %pregion_for_entry.entry.i.i.vecg ]
  br label %pregion_for_entry.entry.i.i

pregion_for_entry.entry.i.i.vec2scalar:           ; preds = %for.end.r_exit.i.iC.rv
  %.red = add i64 %40, 7
  br i1 true, label %_pocl_kernel_atax_kernel1.exit, label %pregion_for_entry.entry.i.i.scag

pregion_for_entry.entry.i.i:                      ; preds = %pregion_for_entry.entry.i.i.scag, %for.end.r_exit.i.i
  %_local_id_x.i.0 = phi i64 [ %_local_id_x.i.0.scaGuard, %pregion_for_entry.entry.i.i.scag ], [ %27, %for.end.r_exit.i.i ]
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
  %26 = call float @llvm.fmuladd.f32(float %24, float %25, float %22) #4, !llvm.access.group !12
  store float %26, float* %arrayidx6.i.i, align 4, !tbaa !14, !llvm.access.group !12
  %indvars.iv.next.i.i = add nuw nsw i64 %indvars.iv.next.i.i2, 1, !llvm.access.group !12
  %exitcond.not.i.i = icmp eq i64 %indvars.iv.next.i.i, %wide.trip.count.i.i, !llvm.access.group !12
  br i1 %exitcond.not.i.i, label %for.end.r_exit.i.i.loopexit, label %for.body.i.i, !llvm.loop !18, !llvm.access.group !12

for.end.r_exit.i.i.loopexit:                      ; preds = %for.body.i.i
  br label %for.end.r_exit.i.i

for.end.r_exit.i.i:                               ; preds = %for.end.r_exit.i.i.loopexit, %pregion_for_entry.entry.i.i
  %27 = add nuw nsw i64 %_local_id_x.i.0, 1
  %exitcond.not = icmp eq i64 %27, 32
  br i1 %exitcond.not, label %_pocl_kernel_atax_kernel1.exit, label %pregion_for_entry.entry.i.i, !llvm.loop !22

_pocl_kernel_atax_kernel1.exit:                   ; preds = %pregion_for_entry.entry.i.i.vec2scalar, %for.end.r_exit.i.i
  ret void

pregion_for_entry.entry.i.iC.rv:                  ; preds = %pregion_for_entry.entry.i.i.vecg, %for.end.r_exit.i.iC.rv
  %_local_id_x.i.0C1 = phi i64 [ 0, %pregion_for_entry.entry.i.i.vecg ], [ %41, %for.end.r_exit.i.iC.rv ]
  %add1.i.i.iC2 = add nuw nsw i64 %_local_id_x.i.0C1, %mul.i.i.i, !llvm.access.group !12
  %28 = add nuw nsw i64 %_local_id_x.i.0C1, 16
  %exitcond.not.vecExit3 = icmp sge i64 %28, 32
  %neg.cmp14.i.i4 = xor i1 %cmp14.i.i, true
  br i1 %cmp14.i.i, label %for.body.lr.ph.i.iC.rv, label %for.end.r_exit.i.iC.rv, !llvm.access.group !12

for.body.lr.ph.i.iC.rv:                           ; preds = %pregion_for_entry.entry.i.iC.rv
  %conv.i.iC5 = trunc i64 %add1.i.i.iC2 to i32, !llvm.access.group !12
  %.splatinsert6 = insertelement <8 x i32> undef, i32 %conv.i.iC5, i32 0
  %.splat7 = shufflevector <8 x i32> %.splatinsert6, <8 x i32> undef, <8 x i32> zeroinitializer
  %contiguous_add = add <8 x i32> %.splat7, <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %mul.i.iC_SIMD = mul nsw <8 x i32> %.splat, %contiguous_add, !llvm.access.group !12
  %sext.i.iC8 = shl i64 %add1.i.i.iC2, 32, !llvm.access.group !12
  %idxprom5.i.iC9 = ashr exact i64 %sext.i.iC8, 32, !llvm.access.group !12
  %29 = sext <8 x i32> %mul.i.iC_SIMD to <8 x i64>, !llvm.access.group !12
  %arrayidx6.i.iC10 = getelementptr inbounds float, float* %16, i64 %idxprom5.i.iC9
  %vec_cast = bitcast float* %arrayidx6.i.iC10 to <8 x float>*
  %cont_load = load <8 x float>, <8 x float>* %vec_cast, align 4
  br label %for.body.i.iC.rv, !llvm.access.group !12

for.body.i.iC.rv:                                 ; preds = %for.body.i.iC.rv, %for.body.lr.ph.i.iC.rv
  %indvars.iv.next.i.i2C14 = phi i64 [ %indvars.iv.next.i.iC43, %for.body.i.iC.rv ], [ 0, %for.body.lr.ph.i.iC.rv ]
  %_SIMD = phi <8 x float> [ %scalarized41, %for.body.i.iC.rv ], [ %cont_load, %for.body.lr.ph.i.iC.rv ]
  %extract40 = extractelement <8 x float> %_SIMD, i32 7
  %extract37 = extractelement <8 x float> %_SIMD, i32 6
  %extract34 = extractelement <8 x float> %_SIMD, i32 5
  %extract31 = extractelement <8 x float> %_SIMD, i32 4
  %extract28 = extractelement <8 x float> %_SIMD, i32 3
  %extract25 = extractelement <8 x float> %_SIMD, i32 2
  %extract22 = extractelement <8 x float> %_SIMD, i32 1
  %extract20 = extractelement <8 x float> %_SIMD, i32 0
  %.splatinsert15 = insertelement <8 x i64> undef, i64 %indvars.iv.next.i.i2C14, i32 0
  %.splat16 = shufflevector <8 x i64> %.splatinsert15, <8 x i64> undef, <8 x i32> zeroinitializer
  %30 = add nsw <8 x i64> %.splat16, %29, !llvm.access.group !12
  %arrayidx.i.iC17 = getelementptr inbounds float, float* %8, <8 x i64> %30
  %31 = call <8 x float> @llvm.masked.gather.v8f32.v8p0f32(<8 x float*> %arrayidx.i.iC17, i32 4, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x float> undef)
  %extract39 = extractelement <8 x float> %31, i32 7
  %extract36 = extractelement <8 x float> %31, i32 6
  %extract33 = extractelement <8 x float> %31, i32 5
  %extract30 = extractelement <8 x float> %31, i32 4
  %extract27 = extractelement <8 x float> %31, i32 3
  %extract24 = extractelement <8 x float> %31, i32 2
  %extract21 = extractelement <8 x float> %31, i32 1
  %extract = extractelement <8 x float> %31, i32 0
  %arrayidx3.i.iC18 = getelementptr inbounds float, float* %12, i64 %indvars.iv.next.i.i2C14
  %cont_load19 = load float, float* %arrayidx3.i.iC18, align 4
  %32 = call float @llvm.fmuladd.f32(float %extract, float %cont_load19, float %extract20) #4, !llvm.access.group !12
  %scalarized = insertelement <8 x float> undef, float %32, i64 0
  %33 = call float @llvm.fmuladd.f32(float %extract21, float %cont_load19, float %extract22) #4, !llvm.access.group !12
  %scalarized23 = insertelement <8 x float> %scalarized, float %33, i64 1
  %34 = call float @llvm.fmuladd.f32(float %extract24, float %cont_load19, float %extract25) #4, !llvm.access.group !12
  %scalarized26 = insertelement <8 x float> %scalarized23, float %34, i64 2
  %35 = call float @llvm.fmuladd.f32(float %extract27, float %cont_load19, float %extract28) #4, !llvm.access.group !12
  %scalarized29 = insertelement <8 x float> %scalarized26, float %35, i64 3
  %36 = call float @llvm.fmuladd.f32(float %extract30, float %cont_load19, float %extract31) #4, !llvm.access.group !12
  %scalarized32 = insertelement <8 x float> %scalarized29, float %36, i64 4
  %37 = call float @llvm.fmuladd.f32(float %extract33, float %cont_load19, float %extract34) #4, !llvm.access.group !12
  %scalarized35 = insertelement <8 x float> %scalarized32, float %37, i64 5
  %38 = call float @llvm.fmuladd.f32(float %extract36, float %cont_load19, float %extract37) #4, !llvm.access.group !12
  %scalarized38 = insertelement <8 x float> %scalarized35, float %38, i64 6
  %39 = call float @llvm.fmuladd.f32(float %extract39, float %cont_load19, float %extract40) #4, !llvm.access.group !12
  %scalarized41 = insertelement <8 x float> %scalarized38, float %39, i64 7
  %vec_cast42 = bitcast float* %arrayidx6.i.iC10 to <8 x float>*
  store <8 x float> %scalarized41, <8 x float>* %vec_cast42, align 4
  %indvars.iv.next.i.iC43 = add nuw nsw i64 %indvars.iv.next.i.i2C14, 1, !llvm.access.group !12
  %exitcond.not.i.iC44 = icmp eq i64 %indvars.iv.next.i.iC43, %wide.trip.count.i.i, !llvm.access.group !12
  br i1 %exitcond.not.i.iC44, label %for.end.r_exit.i.i.loopexitC.rv, label %for.body.i.iC.rv, !llvm.loop !18, !llvm.access.group !12

for.end.r_exit.i.i.loopexitC.rv:                  ; preds = %for.body.i.iC.rv
  br label %for.end.r_exit.i.iC.rv

for.end.r_exit.i.iC.rv:                           ; preds = %for.end.r_exit.i.i.loopexitC.rv, %pregion_for_entry.entry.i.iC.rv
  %40 = add nuw nsw i64 %_local_id_x.i.0C1, 1
  %41 = add nuw nsw i64 %_local_id_x.i.0C1, 8
  %.splatinsert11 = insertelement <8 x i64> undef, i64 %40, i32 0
  %.splat12 = shufflevector <8 x i64> %.splatinsert11, <8 x i64> undef, <8 x i32> zeroinitializer
  %contiguous_add13 = add <8 x i64> %.splat12, <i64 0, i64 1, i64 2, i64 3, i64 4, i64 5, i64 6, i64 7>
  %exitcond.notC_SIMD = icmp eq <8 x i64> %contiguous_add13, <i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32>
  br i1 %exitcond.not.vecExit3, label %pregion_for_entry.entry.i.i.vec2scalar, label %pregion_for_entry.entry.i.iC.rv, !llvm.loop !23
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
  %.splatinsert = insertelement <8 x i32> undef, i32 %17, i32 0
  %.splat = shufflevector <8 x i32> %.splatinsert, <8 x i32> undef, <8 x i32> zeroinitializer
  br label %pregion_for_entry.entry.i.i.vecg

pregion_for_entry.entry.i.iC:                     ; No predecessors!
  unreachable

for.body.lr.ph.i.iC:                              ; No predecessors!
  unreachable

for.body.i.iC:                                    ; No predecessors!
  unreachable

for.end.r_exit.i.i.loopexitC:                     ; No predecessors!
  unreachable

for.end.r_exit.i.iC:                              ; No predecessors!
  unreachable

pregion_for_entry.entry.i.i.vecg:                 ; preds = %5
  %exitcond.not.vecGuard = icmp sge i64 8, 32
  br i1 %exitcond.not.vecGuard, label %pregion_for_entry.entry.i.i.scag, label %pregion_for_entry.entry.i.iC.rv

pregion_for_entry.entry.i.i.scag:                 ; preds = %pregion_for_entry.entry.i.i.vec2scalar, %pregion_for_entry.entry.i.i.vecg
  %_local_id_x.i.0.scaGuard = phi i64 [ %.red, %pregion_for_entry.entry.i.i.vec2scalar ], [ 0, %pregion_for_entry.entry.i.i.vecg ]
  br label %pregion_for_entry.entry.i.i

pregion_for_entry.entry.i.i.vec2scalar:           ; preds = %for.end.r_exit.i.iC.rv
  %.red = add i64 %37, 7
  br i1 true, label %_pocl_kernel_atax_kernel1.exit, label %pregion_for_entry.entry.i.i.scag

pregion_for_entry.entry.i.i:                      ; preds = %pregion_for_entry.entry.i.i.scag, %for.end.r_exit.i.i
  %_local_id_x.i.0 = phi i64 [ %_local_id_x.i.0.scaGuard, %pregion_for_entry.entry.i.i.scag ], [ %24, %for.end.r_exit.i.i ]
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
  %23 = call float @llvm.fmuladd.f32(float %21, float %22, float %19) #4, !llvm.access.group !12
  store float %23, float* %arrayidx6.i.i, align 4, !tbaa !14, !llvm.access.group !12
  %indvars.iv.next.i.i = add nuw nsw i64 %indvars.iv.next.i.i2, 1, !llvm.access.group !12
  %exitcond.not.i.i = icmp eq i64 %indvars.iv.next.i.i, %wide.trip.count.i.i, !llvm.access.group !12
  br i1 %exitcond.not.i.i, label %for.end.r_exit.i.i.loopexit, label %for.body.i.i, !llvm.loop !18, !llvm.access.group !12

for.end.r_exit.i.i.loopexit:                      ; preds = %for.body.i.i
  br label %for.end.r_exit.i.i

for.end.r_exit.i.i:                               ; preds = %for.end.r_exit.i.i.loopexit, %pregion_for_entry.entry.i.i
  %24 = add nuw nsw i64 %_local_id_x.i.0, 1
  %exitcond.not = icmp eq i64 %24, 32
  br i1 %exitcond.not, label %_pocl_kernel_atax_kernel1.exit, label %pregion_for_entry.entry.i.i, !llvm.loop !24

_pocl_kernel_atax_kernel1.exit:                   ; preds = %pregion_for_entry.entry.i.i.vec2scalar, %for.end.r_exit.i.i
  ret void

pregion_for_entry.entry.i.iC.rv:                  ; preds = %pregion_for_entry.entry.i.i.vecg, %for.end.r_exit.i.iC.rv
  %_local_id_x.i.0C1 = phi i64 [ 0, %pregion_for_entry.entry.i.i.vecg ], [ %38, %for.end.r_exit.i.iC.rv ]
  %add1.i.i.iC2 = add nuw nsw i64 %_local_id_x.i.0C1, %mul.i.i.i, !llvm.access.group !12
  %25 = add nuw nsw i64 %_local_id_x.i.0C1, 16
  %exitcond.not.vecExit3 = icmp sge i64 %25, 32
  %neg.cmp14.i.i4 = xor i1 %cmp14.i.i, true
  br i1 %cmp14.i.i, label %for.body.lr.ph.i.iC.rv, label %for.end.r_exit.i.iC.rv, !llvm.access.group !12

for.body.lr.ph.i.iC.rv:                           ; preds = %pregion_for_entry.entry.i.iC.rv
  %conv.i.iC5 = trunc i64 %add1.i.i.iC2 to i32, !llvm.access.group !12
  %.splatinsert6 = insertelement <8 x i32> undef, i32 %conv.i.iC5, i32 0
  %.splat7 = shufflevector <8 x i32> %.splatinsert6, <8 x i32> undef, <8 x i32> zeroinitializer
  %contiguous_add = add <8 x i32> %.splat7, <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %mul.i.iC_SIMD = mul nsw <8 x i32> %.splat, %contiguous_add, !llvm.access.group !12
  %sext.i.iC8 = shl i64 %add1.i.i.iC2, 32, !llvm.access.group !12
  %idxprom5.i.iC9 = ashr exact i64 %sext.i.iC8, 32, !llvm.access.group !12
  %26 = sext <8 x i32> %mul.i.iC_SIMD to <8 x i64>, !llvm.access.group !12
  %arrayidx6.i.iC10 = getelementptr inbounds float, float* %13, i64 %idxprom5.i.iC9
  %vec_cast = bitcast float* %arrayidx6.i.iC10 to <8 x float>*
  %cont_load = load <8 x float>, <8 x float>* %vec_cast, align 4
  br label %for.body.i.iC.rv, !llvm.access.group !12

for.body.i.iC.rv:                                 ; preds = %for.body.i.iC.rv, %for.body.lr.ph.i.iC.rv
  %indvars.iv.next.i.i2C14 = phi i64 [ %indvars.iv.next.i.iC43, %for.body.i.iC.rv ], [ 0, %for.body.lr.ph.i.iC.rv ]
  %_SIMD = phi <8 x float> [ %scalarized41, %for.body.i.iC.rv ], [ %cont_load, %for.body.lr.ph.i.iC.rv ]
  %extract40 = extractelement <8 x float> %_SIMD, i32 7
  %extract37 = extractelement <8 x float> %_SIMD, i32 6
  %extract34 = extractelement <8 x float> %_SIMD, i32 5
  %extract31 = extractelement <8 x float> %_SIMD, i32 4
  %extract28 = extractelement <8 x float> %_SIMD, i32 3
  %extract25 = extractelement <8 x float> %_SIMD, i32 2
  %extract22 = extractelement <8 x float> %_SIMD, i32 1
  %extract20 = extractelement <8 x float> %_SIMD, i32 0
  %.splatinsert15 = insertelement <8 x i64> undef, i64 %indvars.iv.next.i.i2C14, i32 0
  %.splat16 = shufflevector <8 x i64> %.splatinsert15, <8 x i64> undef, <8 x i32> zeroinitializer
  %27 = add nsw <8 x i64> %.splat16, %26, !llvm.access.group !12
  %arrayidx.i.iC17 = getelementptr inbounds float, float* %7, <8 x i64> %27
  %28 = call <8 x float> @llvm.masked.gather.v8f32.v8p0f32(<8 x float*> %arrayidx.i.iC17, i32 4, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x float> undef)
  %extract39 = extractelement <8 x float> %28, i32 7
  %extract36 = extractelement <8 x float> %28, i32 6
  %extract33 = extractelement <8 x float> %28, i32 5
  %extract30 = extractelement <8 x float> %28, i32 4
  %extract27 = extractelement <8 x float> %28, i32 3
  %extract24 = extractelement <8 x float> %28, i32 2
  %extract21 = extractelement <8 x float> %28, i32 1
  %extract = extractelement <8 x float> %28, i32 0
  %arrayidx3.i.iC18 = getelementptr inbounds float, float* %10, i64 %indvars.iv.next.i.i2C14
  %cont_load19 = load float, float* %arrayidx3.i.iC18, align 4
  %29 = call float @llvm.fmuladd.f32(float %extract, float %cont_load19, float %extract20) #4, !llvm.access.group !12
  %scalarized = insertelement <8 x float> undef, float %29, i64 0
  %30 = call float @llvm.fmuladd.f32(float %extract21, float %cont_load19, float %extract22) #4, !llvm.access.group !12
  %scalarized23 = insertelement <8 x float> %scalarized, float %30, i64 1
  %31 = call float @llvm.fmuladd.f32(float %extract24, float %cont_load19, float %extract25) #4, !llvm.access.group !12
  %scalarized26 = insertelement <8 x float> %scalarized23, float %31, i64 2
  %32 = call float @llvm.fmuladd.f32(float %extract27, float %cont_load19, float %extract28) #4, !llvm.access.group !12
  %scalarized29 = insertelement <8 x float> %scalarized26, float %32, i64 3
  %33 = call float @llvm.fmuladd.f32(float %extract30, float %cont_load19, float %extract31) #4, !llvm.access.group !12
  %scalarized32 = insertelement <8 x float> %scalarized29, float %33, i64 4
  %34 = call float @llvm.fmuladd.f32(float %extract33, float %cont_load19, float %extract34) #4, !llvm.access.group !12
  %scalarized35 = insertelement <8 x float> %scalarized32, float %34, i64 5
  %35 = call float @llvm.fmuladd.f32(float %extract36, float %cont_load19, float %extract37) #4, !llvm.access.group !12
  %scalarized38 = insertelement <8 x float> %scalarized35, float %35, i64 6
  %36 = call float @llvm.fmuladd.f32(float %extract39, float %cont_load19, float %extract40) #4, !llvm.access.group !12
  %scalarized41 = insertelement <8 x float> %scalarized38, float %36, i64 7
  %vec_cast42 = bitcast float* %arrayidx6.i.iC10 to <8 x float>*
  store <8 x float> %scalarized41, <8 x float>* %vec_cast42, align 4
  %indvars.iv.next.i.iC43 = add nuw nsw i64 %indvars.iv.next.i.i2C14, 1, !llvm.access.group !12
  %exitcond.not.i.iC44 = icmp eq i64 %indvars.iv.next.i.iC43, %wide.trip.count.i.i, !llvm.access.group !12
  br i1 %exitcond.not.i.iC44, label %for.end.r_exit.i.i.loopexitC.rv, label %for.body.i.iC.rv, !llvm.loop !18, !llvm.access.group !12

for.end.r_exit.i.i.loopexitC.rv:                  ; preds = %for.body.i.iC.rv
  br label %for.end.r_exit.i.iC.rv

for.end.r_exit.i.iC.rv:                           ; preds = %for.end.r_exit.i.i.loopexitC.rv, %pregion_for_entry.entry.i.iC.rv
  %37 = add nuw nsw i64 %_local_id_x.i.0C1, 1
  %38 = add nuw nsw i64 %_local_id_x.i.0C1, 8
  %.splatinsert11 = insertelement <8 x i64> undef, i64 %37, i32 0
  %.splat12 = shufflevector <8 x i64> %.splatinsert11, <8 x i64> undef, <8 x i32> zeroinitializer
  %contiguous_add13 = add <8 x i64> %.splat12, <i64 0, i64 1, i64 2, i64 3, i64 4, i64 5, i64 6, i64 7>
  %exitcond.notC_SIMD = icmp eq <8 x i64> %contiguous_add13, <i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32>
  br i1 %exitcond.not.vecExit3, label %pregion_for_entry.entry.i.i.vec2scalar, label %pregion_for_entry.entry.i.iC.rv, !llvm.loop !25
}

; Function Attrs: nofree nosync nounwind readonly willreturn
declare <8 x float> @llvm.masked.gather.v8f32.v8p0f32(<8 x float*>, i32 immarg, <8 x i1>, <8 x float>) #3

attributes #0 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #1 = { alwaysinline nofree norecurse nounwind "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "stackrealign" "target-cpu"="skylake" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+invpcid,+lzcnt,+mmx,+movbe,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+sahf,+sgx,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves" "uniform-work-group-size"="true" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nofree nounwind }
attributes #3 = { nofree nosync nounwind readonly willreturn }
attributes #4 = { nounwind }

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
!20 = distinct !{!20}
!21 = distinct !{!21}
!22 = distinct !{!22}
!23 = distinct !{!23}
!24 = distinct !{!24}
!25 = distinct !{!25}
