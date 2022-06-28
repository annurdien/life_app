import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:life_app/themes/custom_theme.dart';

import '../core/provider/music_provider.dart';
import '../utils.dart';
import '../widgets/music_card.dart';

class ReliefPage extends StatefulHookConsumerWidget {
  const ReliefPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReliefPageState();
}

class _ReliefPageState extends ConsumerState<ReliefPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colors = context.colors;

    final musics = ref.watch(musicsProvider);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 15.h,
          ),
          children: [
            Text(
              "Relief",
              style: textTheme.title.withColor(colors.snow),
              textAlign: TextAlign.center,
            ),
            30.verticalSpace,
            musics.when(
              data: (data) => Wrap(
                spacing: 30.w,
                runSpacing: 10.h,
                children: [
                  for (final relief in data) ...[
                    MusicCard(relief: relief),
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
    );
  }
}
