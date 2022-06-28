import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:life_app/themes/custom_theme.dart';

import 'home_page.dart';
import 'profile_page.dart';
import 'relief_page.dart';

final pageNumberProvider = StateProvider<int>((ref) => 0);

class MyHomePage extends StatefulHookConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final activeIndex = useState<int>(0);

    final pageController = usePageController(
      initialPage: 0,
    );

    final bottomNavBarConttoller = useTabController(initialLength: 3);

    final colors = context.colors;

    ref.listen<int>(pageNumberProvider, (prev, next) {
      bottomNavBarConttoller.animateTo(next);
      pageController.jumpToPage(next);
    });

    return Scaffold(
      body: PageView(
        controller: pageController,
        children: const [
          HomePage(),
          ReliefPage(),
          ProfilePage(),
        ],
        onPageChanged: (index) {
          bottomNavBarConttoller.animateTo(index);
          ref.read(pageNumberProvider.notifier).update((state) => index);
        },
      ),
      bottomNavigationBar: ConvexAppBar(
        controller: bottomNavBarConttoller,
        initialActiveIndex: activeIndex.value,
        backgroundColor: const Color(0xFF2F4767),
        color: colors.snow.withOpacity(0.5),
        activeColor: colors.snow,
        style: TabStyle.react,
        items: const [
          TabItem(
            title: 'Home',
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
          ),
          TabItem(
            title: 'Sound',
            icon: Icons.hearing,
          ),
          TabItem(
            title: 'Profile',
            icon: Icons.person_outline,
            activeIcon: Icons.person,
          ),
        ],
        onTap: (index) {
          pageController.jumpToPage(index);
          activeIndex.value = index;
          ref.read(pageNumberProvider.notifier).update((state) => index);
        },
      ),
    );
  }
}
