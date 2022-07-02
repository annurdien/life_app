import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:life_app/models/relief_model.dart';

import '../app.dart';
import '../pages/create_journal_page.dart';
import '../pages/intro_page.dart';
import '../pages/journal_list_page.dart';
import '../pages/music_player_page.dart';
import '../pages/my_home_page.dart';
import '../pages/sign_in_page.dart';
import '../pages/sign_up_page.dart';

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
    CustomRoute(
      page: SigInPage,
      transitionsBuilder: TransitionsBuilders.zoomIn,
    ),
    CustomRoute(
      page: SignUpPage,
      transitionsBuilder: TransitionsBuilders.zoomIn,
    ),
    CustomRoute(
      page: CreateJournalPage,
      transitionsBuilder: TransitionsBuilders.zoomIn,
    ),
    CustomRoute(
      page: JournalListPage,
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
    ),
    CustomRoute(
      page: MusicPlayerPage,
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
    ),
  ],
)
class AppRouter extends _$AppRouter {}
