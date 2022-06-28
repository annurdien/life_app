import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:life_app/core/provider/journal_provider.dart';
import 'package:life_app/core/provider/music_provider.dart';
import 'package:life_app/pages/my_home_page.dart';
import 'package:life_app/routes/router.dart';
import 'package:life_app/themes/custom_theme.dart';

import '../utils.dart';
import '../widgets/journal_card.dart';
import '../widgets/music_card.dart';

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    final journal = ref.watch(journalsProvider);
    final musics = ref.watch(musicsProvider);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20.w),
          children: [
            Text(
              "Hi There",
              style: textTheme.title.withColor(colors.snow),
            ),
            20.verticalSpace,
            const _StaticBanner(),
            44.verticalSpace,
            _HeadingWithButton(
              title: "Journaling",
              onPressed: () {
                context.pushRoute(const JournalListRoute());
              },
            ),
            5.verticalSpace,
            journal.when(
              data: (data) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat(DateFormat.YEAR_MONTH_DAY)
                          .format(data.first.created_at),
                      style: textTheme.caption.withColor(colors.snow),
                    ),
                    8.verticalSpace,
                    JournalCard(
                      journal: data.first,
                    ),
                  ],
                );
              },
              error: (_, __) {
                logger.e(__);
                return const Center(child: Text("Error"));
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            44.verticalSpace,
            _HeadingWithButton(
              title: "Self Care",
              onPressed: () {
                ref.read(pageNumberProvider.notifier).update((state) => 1);
              },
            ),
            musics.when(
              data: (data) => Wrap(
                spacing: 15.w,
                runSpacing: 10.h,
                children: [
                  for (final relief in data) ...[
                    MusicCard(
                      relief: relief,
                      onTap: () {
                        context.pushRoute(const MusicPlayerRoute());
                      },
                    ),
                  ],
                ],
              ),
              error: (_, __) {
                logger.i(__);
                return const Center(
                  child: Text("Error"),
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushRoute(const CreateJournalRoute());
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.w),
        ),
        backgroundColor: const Color(0xFF1BC290),
        child: SvgPicture.asset("assets/quill_pen.svg"),
      ),
    );
  }
}

class _StaticBanner extends StatelessWidget {
  const _StaticBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;
    return Container(
      clipBehavior: Clip.antiAlias,
      height: 123.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.w),
        color: const Color(0xFFD3982D),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 10.w,
            top: 5.h,
            bottom: 5.h,
            child: Image.asset('assets/banner_logo.png'),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 60.h,
              decoration: BoxDecoration(
                color: const Color(0xFF825C17).withOpacity(0.7),
              ),
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Relax your mind",
                      style: textTheme.caption.withColor(colors.snow).copyWith(
                          fontWeight: FontWeight.bold, fontSize: 12.sp),
                    ),
                    2.verticalSpace,
                    Text(
                      "Train your breath, control your emosion",
                      style: textTheme.caption
                          .withColor(colors.snow)
                          .copyWith(fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeadingWithButton extends StatelessWidget {
  const _HeadingWithButton({
    required this.title,
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textTheme.title.withColor(colors.snow),
        ),
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            Icons.arrow_forward,
            color: colors.snow,
          ),
        )
      ],
    );
  }
}
