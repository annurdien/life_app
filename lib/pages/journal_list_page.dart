import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:life_app/core/provider/journal_provider.dart';
import 'package:life_app/models/journal_model.dart';
import 'package:life_app/themes/custom_theme.dart';

import '../widgets/journal_card.dart';

class JournalListPage extends HookConsumerWidget {
  const JournalListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = context.textTheme;
    final colors = context.colors;

    final journals = ref.watch(journalsProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Journal",
          style: textTheme.title.withColor(colors.snow),
        ),
      ),
      body: journals.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Text(
            "Error while fetching data",
            style: textTheme.caption.withColor(colors.snow),
          ),
        ),
        data: (data) {
          final groupedJournals = <String, List<JournalModel>>{};

          for (final journal in data) {
            final date = journal.created_at.toIso8601String();

            final year = date.substring(0, 4);
            final month = date.substring(5, 7);
            final day = date.substring(8, 10);

            final dateString = "$year-$month-$day";

            if (groupedJournals.containsKey(dateString)) {
              groupedJournals[dateString]!.add(journal);
            } else {
              groupedJournals[dateString] = [journal];
            }
          }

          return ListView(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
            children: [
              for (final date in groupedJournals.keys) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat(DateFormat.YEAR_MONTH_DAY).format(
                        DateTime.parse(date),
                      ),
                      style: textTheme.caption.withColor(colors.snow),
                    ),
                    10.verticalSpace,
                    for (final journal in groupedJournals[date]!) ...[
                      JournalCard(journal: journal),
                      10.verticalSpace,
                    ],
                  ],
                ),
                10.verticalSpace,
              ],
            ],
          );
        },
      ),
    );
  }
}
