import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_app/routes/router.dart';
import 'package:life_app/themes/custom_theme.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Welcome to Life App',
                  style: textTheme.title.withColor(
                    colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                27.verticalSpace,
                Text(
                  "Explore your life using this app. It uses sound and vesualization to create perfect conditions for refreshing sleep.",
                  style: textTheme.body.withColor(colors.white),
                  textAlign: TextAlign.center,
                ),
                80.verticalSpace,
                Image.asset('assets/onboarding_illustration.png'),
              ],
            ),
            Positioned(
              bottom: 20.h,
              left: 0.w,
              right: 0.w,
              child: TextButton(
                onPressed: () {
                  context.pushRoute(const SigInRoute());
                },
                child: const Text("Start"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
