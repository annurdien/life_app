import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:life_app/providers.dart';
import 'package:life_app/routes/router.dart';
import 'package:life_app/themes/custom_theme.dart';

import 'core/provider/authentication_provider.dart';

class LifeApp extends ConsumerWidget {
  const LifeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => CustomTheme(
        textTheme: AppTextStyles.lifeApp(),
        colorTheme: AppColors.lifeApp(),
        child: Builder(
          builder: (context) {
            return MaterialApp.router(
              title: 'Life App',
              theme: ThemeData(),
              routerDelegate: router.delegate(
                navigatorObservers: () => [
                  FirebaseAnalyticsObserver(
                    analytics: FirebaseAnalytics.instance,
                    routeFilter: (Route? route) {
                      const skippedRoutes = [
                        SplashScreenRoute.name,
                      ];
                      return !skippedRoutes.contains(route?.settings.name);
                    },
                  )
                ],
              ),
              routeInformationParser: router.defaultRouteParser(),
              builder: (context, child) {
                return FlutterEasyLoading(
                  child: child,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class SplashScreenPage extends StatefulHookConsumerWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SplashScreenPageState();
}

class _SplashScreenPageState extends ConsumerState<SplashScreenPage> {
  bool done = false;

  void _navigate() {
    if (!done) return;

    final authentication = ref.read(authenticationProvider);

    authentication.maybeWhen(
      unauthenticated: () => context.replaceRoute(const IntroRoute()),
      authenticated: (_) => context.replaceRoute(const MyHomeRoute()),
      orElse: () => {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final authentication = ref.watch(authenticationProvider);

    ref.listen(
      authenticationProvider,
      (prev, curr) {
        _navigate();
      },
    );

    return SplashScreen(
      onFinished: () {
        setState(() {
          done = true;
        });
        _navigate();
      },
      child: authentication.maybeWhen(
        uninitialized: () => const Center(
          child: CircularProgressIndicator(),
        ),
        orElse: () => Center(
          child: Column(
            children: const [],
          ),
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
    required this.child,
    required this.onFinished,
  }) : super(key: key);

  final Widget child;
  final void Function() onFinished;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Completer _completer;

  @override
  void initState() {
    super.initState();
    _completer = Completer();
  }

  @override
  void dispose() {
    if (!_completer.isCompleted) {
      _completer.complete();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _completer.future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return GestureDetector(
            onTap: widget.onFinished,
            child: SplashScreenStatic(
              onFinished: widget.onFinished,
              splashCompleter: _completer,
            ),
          );
        }
        return widget.child;
      },
    );
  }
}

class SplashScreenStatic extends StatefulWidget {
  const SplashScreenStatic({
    Key? key,
    required this.onFinished,
    required this.splashCompleter,
  }) : super(key: key);
  final void Function() onFinished;
  final Completer splashCompleter;

  @override
  State<SplashScreenStatic> createState() => _SplashScreenStaticState();
}

class _SplashScreenStaticState extends State<SplashScreenStatic> {
  @override
  void initState() {
    final completer = widget.splashCompleter;

    Future.delayed(const Duration(seconds: 2), () {
      if (!completer.isCompleted) {
        widget.splashCompleter.complete();
        widget.onFinished();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.white,
      child: Center(
        child: Text("SPLASH"),
      ),
    );
  }
}
