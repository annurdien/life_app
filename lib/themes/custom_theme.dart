import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme extends InheritedWidget {
  const CustomTheme({
    super.key,
    required super.child,
    required this.textTheme,
    required this.colorTheme,
  });

  final AppTextStyles textTheme;
  final AppColors colorTheme;

  static CustomTheme? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CustomTheme>();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}

extension CustomThemeExtension on BuildContext {
  CustomTheme get themes {
    final theme = CustomTheme.of(this);
    assert(theme != null);
    return theme!;
  }

  AppTextStyles get textTheme {
    final theme = CustomTheme.of(this);
    assert(theme != null);
    return theme!.textTheme;
  }

  AppColors get colors {
    final theme = CustomTheme.of(this);
    assert(theme != null);
    return theme!.colorTheme;
  }
}

class AppColors {
  AppColors(
    this.hippieBlue,
    this.deepAqua,
    this.nileBlue,
    this.blueWhale,
    this.lipstickPink,
    this.sienna,
    this.gold,
    this.purple,
    this.white,
    this.snow,
    this.peach,
    this.black,
  );

  static AppColors of(BuildContext context) {
    final inheritedWidget =
        context.dependOnInheritedWidgetOfExactType<CustomTheme>();
    assert(inheritedWidget != null);
    return inheritedWidget!.colorTheme;
  }

  factory AppColors.lifeApp() {
    const Color hippieBlue = Color(0xFF4F9FA8);
    const Color deepAqua = Color(0xFF196E82);
    const Color nileBlue = Color(0xFF1F3757);
    const Color blueWhale = Color(0xFF062249);
    const Color lipstickPink = Color(0xFFC9828D);
    const Color sienna = Color(0xFF9E512C);
    const Color gold = Color(0xFFD3982D);
    const Color purple = Color(0xFFA991D3);
    const Color white = Color(0xFFFFFFFF);
    const Color snow = Color(0xFFF9F9F9);
    const Color peach = Color(0xFFEDEDED);
    const Color black = Color(0xFF0A0A24);

    return AppColors(
      hippieBlue,
      deepAqua,
      nileBlue,
      blueWhale,
      lipstickPink,
      sienna,
      gold,
      purple,
      white,
      snow,
      peach,
      black,
    );
  }

  final Color hippieBlue;
  final Color deepAqua;
  final Color nileBlue;
  final Color blueWhale;
  final Color lipstickPink;
  final Color sienna;
  final Color gold;
  final Color purple;
  final Color white;
  final Color snow;
  final Color peach;
  final Color black;
}

class AppTextStyles {
  AppTextStyles(
    this.heading1,
    this.heading2,
    this.heading3,
    this.title,
    this.body,
    this.caption,
    this.button,
  );

  factory AppTextStyles.lifeApp() {
    TextStyle heading1 = GoogleFonts.lora(
      fontWeight: FontWeight.w700,
      fontSize: 64.sp,
    );

    TextStyle heading2 = GoogleFonts.lora(
      fontWeight: FontWeight.w700,
      fontSize: 36.sp,
    );
    TextStyle heading3 = GoogleFonts.inter(
      fontWeight: FontWeight.w700,
      fontSize: 36.sp,
    );

    TextStyle title = GoogleFonts.lora(
      fontWeight: FontWeight.w700,
      fontSize: 24.sp,
    );

    TextStyle body = GoogleFonts.inter(
      fontWeight: FontWeight.w400,
      fontSize: 16.sp,
    );

    TextStyle caption = GoogleFonts.inter(
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
    );

    TextStyle button = GoogleFonts.inter(
      fontWeight: FontWeight.w700,
      fontSize: 20.sp,
    );

    return AppTextStyles(
      heading1,
      heading2,
      heading3,
      title,
      body,
      caption,
      button,
    );
  }

  static AppTextStyles? of(BuildContext context) {
    final inheritedWidget =
        context.dependOnInheritedWidgetOfExactType<CustomTheme>();
    assert(inheritedWidget != null);
    return inheritedWidget!.textTheme;
  }

  final TextStyle heading1;
  final TextStyle heading2;
  final TextStyle heading3;
  final TextStyle title;
  final TextStyle body;
  final TextStyle caption;
  final TextStyle button;
}

extension ColorsX on TextStyle {
  TextStyle withColor(Color color) {
    return copyWith(color: color);
  }
}
