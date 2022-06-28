import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_app/themes/custom_theme.dart';
import 'package:life_app/utils.dart';

class FeelingButton extends StatelessWidget {
  const FeelingButton({
    Key? key,
    this.onTap,
    required this.feeling,
    this.isSelected = false,
  }) : super(key: key);

  final int feeling;
  final VoidCallback? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52.w,
        height: 73.h,
        padding: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.w),
          color:
              !isSelected ? const Color(0xFF1F3757) : const Color(0xFF14B786),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              feeling.feeling,
              style: textTheme.title,
            ),
            Text(
              feeling.feelingText,
              style: textTheme.title.copyWith(
                color: colors.snow,
                fontSize: 10.sp,
              ),
            )
          ],
        ),
      ),
    );
  }
}
