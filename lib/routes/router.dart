import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:life_app/pages/intro_page.dart';

import '../app.dart';
import '../pages/my_home_page.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashScreenPage, initial: true),
    CustomRoute(
      page: IntroPage,
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
    ),
    CustomRoute(
      page: MyHomePage,
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
    ),
  ],
)
class AppRouter extends _$AppRouter {}
