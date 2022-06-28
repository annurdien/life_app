import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:life_app/models/relief_model.dart';
import 'package:life_app/themes/custom_theme.dart';

import '../utils.dart';

class MusicCard extends ConsumerWidget {
  const MusicCard({
    super.key,
    required this.relief,
    this.onTap,
  });

  final ReliefModel relief;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: getRandomColor(),
              borderRadius: BorderRadius.circular(10.w),
            ),
            width: 145.w,
            height: 123.h,
            child: Image.network(relief.image),
          ),
          5.verticalSpace,
          Text(
            relief.title,
            style: context.textTheme.title.copyWith(
              fontSize: 14.sp,
              color: colors.snow,
            ),
          ),
          5.verticalSpace,
          Text(
            "${secondsToMinutes(relief.length)} MIN . ${relief.type.toUpperCase()}",
            style: textTheme.caption
                .withColor(colors.snow.withOpacity(0.5))
                .copyWith(fontSize: 12.sp),
          )
        ],
      ),
    );
  }
}

Color getRandomColor() => colors[Random().nextInt(3)];

List<Color> colors = [
  const Color(0xFFC9828D),
  const Color(0xFF9E512C),
  const Color(0xFFD3982D),
  const Color(0xFFA991D3),
];
