import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:life_app/models/relief_model.dart';
import 'package:life_app/themes/custom_theme.dart';

import '../core/provider/music_provider.dart';

class MusicPlayerPage extends HookConsumerWidget {
  const MusicPlayerPage({
    Key? key,
    required this.relief,
  }) : super(key: key);

  final ReliefModel relief;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    final player = ref.read(
      audioPlayerControllerProvider(relief.url).notifier,
    );

    return Scaffold(
      backgroundColor: const Color(0xFF9D5661),
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80.h,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Container(
          decoration: BoxDecoration(
            color: colors.white,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(
              Icons.close,
              color: Color(0xFFC13349),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
            child: Column(
              children: [
                Image.network(
                  fit: BoxFit.contain,
                  relief.image,
                  height: 200.h,
                  width: 192.h,
                ),
                40.verticalSpace,
                Text(
                  relief.title,
                  style: textTheme.title.withColor(colors.snow),
                ),
                12.verticalSpace,
                Text(
                  relief.type.toUpperCase(),
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFC1C1C1),
                  ),
                ),
                40.verticalSpace,
                Consumer(
                  builder: (context, ref, child) {
                    final controller = ref.watch(
                      audioPlayerControllerProvider(relief.url),
                    );
                    final current = ref.watch(currentMusicDurationProvider);

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Ink(
                          child: InkWell(
                            child: SvgPicture.asset(
                              'assets/back_15.svg',
                              height: 40.w,
                              width: 40.w,
                            ),
                            onTap: () => {
                              player.seek(
                                current - const Duration(seconds: 15),
                              ),
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: controller.maybeWhen(
                            orElse: () => null,
                            playing: () => player.pause,
                            ready: () => player.play,
                            idle: () => player.play,
                          ),
                          child: Container(
                            height: 110.h,
                            width: 110.h,
                            padding: EdgeInsets.all(10.h),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: colors.snow,
                                shape: BoxShape.circle,
                              ),
                              child: controller.when(
                                idle: () => Icon(
                                  Icons.play_arrow,
                                  size: 40.sp,
                                  color: const Color(0xFFF68092),
                                ),
                                loading: () => loading(),
                                buffering: () => loading(),
                                ready: () => play(),
                                completed: () => play(),
                                error: (error) => errorWidget(),
                                playing: () => pause(),
                              ),
                            ),
                          ),
                        ),
                        Ink(
                          child: InkWell(
                            child: SvgPicture.asset(
                              'assets/forward_15.svg',
                              height: 40.w,
                              width: 40.w,
                            ),
                            onTap: () => {
                              player.seek(
                                current + const Duration(seconds: 15),
                              ),
                            },
                          ),
                        )
                      ],
                    );
                  },
                ),

                50.verticalSpace,

                // TODO connect to state management
                Consumer(
                  builder: (context, ref, child) {
                    final current = ref.watch(currentMusicDurationProvider);
                    final buffered = ref.watch(bufferedMusicDurationProvider);
                    final total = ref.watch(totalMusicDurationProvider);

                    return ProgressBar(
                      progress: current,
                      total: total,
                      buffered: buffered,
                      onSeek: (duration) {
                        player.seek(duration);
                      },
                      thumbColor: const Color(0xFFF68092),
                      baseBarColor: const Color(0xC7E6E7F2),
                      progressBarColor: const Color(0xFFE6E7F2),
                      timeLabelPadding: 10,
                      timeLabelTextStyle: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFF68092),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget loading() {
  return const CircularProgressIndicator();
}

Widget play() {
  return Icon(
    Icons.play_arrow,
    size: 40.sp,
    color: const Color(0xFFF68092),
  );
}

Widget pause() {
  return Icon(
    Icons.pause,
    size: 40.sp,
    color: const Color(0xFFF68092),
  );
}

Widget errorWidget() {
  return Icon(
    Icons.error,
    size: 40.sp,
    color: const Color(0xFFF68092),
  );
}
