import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:life_app/themes/custom_theme.dart';
import 'package:life_app/utils.dart';

import '../models/journal_model.dart';

class JournalCard extends ConsumerWidget {
  const JournalCard({super.key, required this.journal});

  final JournalModel journal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = context.textTheme;
    final colors = context.colors;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: ExpansionTile(
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        collapsedBackgroundColor: const Color(0xFF1F3757),
        backgroundColor: const Color(0xFF1F3757),
        tilePadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
        title: Row(
          children: [
            Text(
              journal.feeling.feeling,
              style: textTheme.title.copyWith(fontSize: 30.sp),
            ),
            10.horizontalSpace,
            Text(
              journal.title,
              style: textTheme.title.copyWith(
                color: colors.white,
                fontSize: 14.sp,
              ),
            )
          ],
        ),
        collapsedIconColor: colors.white,
        iconColor: colors.white,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                top: 10.h,
                bottom: 10.h,
                right: 10.w,
                left: 55.w,
              ),
              child: Text(
                textAlign: TextAlign.start,
                journal.body,
                style: textTheme.caption.withColor(colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
