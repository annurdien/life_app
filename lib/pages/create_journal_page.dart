import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:life_app/models/journal_model.dart';
import 'package:life_app/themes/custom_theme.dart';
import 'package:life_app/widgets/custom_text_field.dart';
import 'package:life_app/widgets/emotion_chip.dart';

import '../core/provider/journal_provider.dart';
import '../widgets/feeling_button.dart';
import '../widgets/multi_line_text_field.dart';

const List<String> emoList = [
  "Gratefull",
  "Relaxed",
  "Happy",
  "Excited",
  "Proud",
  "Relieved",
  "Inspired"
];

class CreateJournalPage extends HookConsumerWidget {
  const CreateJournalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = context.textTheme;
    final colors = context.colors;

    final feeling = useState<int>(0);
    final emotions = useState<List<String>>([]);

    final storyController = useTextEditingController();
    final titleController = useTextEditingController();

    // Listener
    ref.listen<JournalState>(
      journalControllerProvider,
      ((previous, next) {
        next.maybeMap(
          orElse: () => {},
          error: (error) {
            EasyLoading.showError("Error while submiting data");
          },
          success: (success) {
            EasyLoading.showSuccess("Data submitted successfully");
          },
        );
      }),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              children: [
                Text(
                  "Give it a title",
                  style: textTheme.title.withColor(colors.snow),
                ),
                5.verticalSpace,
                CustomTextInput(
                  controller: titleController,
                  dense: true,
                ),
                20.verticalSpace,
                Text(
                  "How are you feeling today?",
                  style: textTheme.title.withColor(colors.snow),
                ),
                5.verticalSpace,
                Text(
                  "Which Emoji describe how are you feeling now?",
                  style: context.textTheme.caption.withColor(colors.snow),
                ),
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (final f in [0, 1, 2, 3, 4]) ...[
                      FeelingButton(
                        onTap: () {
                          feeling.value = f;
                        },
                        feeling: f,
                        isSelected: f == feeling.value,
                      ),
                    ],
                  ],
                ),
                20.verticalSpace,
                Text(
                  "Which Emotions describe your feeling?",
                  style: textTheme.title.withColor(colors.snow),
                ),
                10.verticalSpace,
                Wrap(
                  spacing: 10.w,
                  runSpacing: 10.w,
                  children: [
                    for (final e in emoList) ...[
                      EmotionChip(
                        title: e,
                        onTap: () {
                          if (emotions.value.contains(e)) {
                            emotions.value = emotions.value.toList()..remove(e);
                          } else {
                            emotions.value = emotions.value.toList()..add(e);
                          }
                        },
                        isActive: emotions.value.contains(e),
                      ),
                    ],
                  ],
                ),
                20.verticalSpace,
                Text(
                  "What going on today?",
                  style: textTheme.title.withColor(colors.snow),
                ),
                10.verticalSpace,
                MultiLineTextField(
                  controller: storyController,
                  hintText: "T",
                ),
                100.verticalSpace,
              ],
            ),
            Consumer(
              builder: (context, ref, child) {
                final state = ref.watch(journalControllerProvider);
                final notifier = ref.watch(journalControllerProvider.notifier);

                return Positioned(
                  bottom: 15.h,
                  left: 20.w,
                  right: 20.w,
                  child: TextButton(
                    onPressed: () {
                      final payload = JournalDto(
                        title: titleController.text,
                        body: storyController.text,
                        feeling: feeling.value,
                        emotion: emotions.value,
                      );

                      notifier.addJournal(payload);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF14B786),
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                    ),
                    child: state.maybeWhen(
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      error: ((error) => const Text("Try Again")),
                      orElse: () => const Text("Submit"),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
