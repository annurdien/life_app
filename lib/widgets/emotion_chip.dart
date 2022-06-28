import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EmotionChip extends StatelessWidget {
  const EmotionChip({
    super.key,
    required this.title,
    this.isActive = false,
    this.onTap,
  });

  final String title;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 6.h,
          horizontal: 10.w,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.w),
          color: isActive ? const Color(0xFF1BC290) : const Color(0xFF1F3757),
        ),
        child: Text(
          title,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: const Color(0xFFE0E0E0),
          ),
        ),
      ),
    );
  }
}
