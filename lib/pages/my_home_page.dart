import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:life_app/themes/custom_theme.dart';

import 'home_page.dart';
import 'profile_page.dart';
import 'relief_page.dart';

class MyHomePage extends StatefulHookConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final pagecontroller = usePageController(
      initialPage: 0,
    );

    final activeIndex = useState<int>(0);

    final colors = context.colors;
    final textTheme = context.textTheme;

    return Scaffold(
      body: PageView(
        controller: pagecontroller,
        children: const [
          HomePage(),
          ReliefPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: ConvexAppBar(
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
          pagecontroller.jumpToPage(index);
          activeIndex.value = index;
        },
      ),
    );
  }
}
