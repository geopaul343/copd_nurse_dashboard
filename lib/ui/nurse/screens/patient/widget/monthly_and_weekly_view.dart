import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../data/nurse/model/nurse/patient_checkup_data_model.dart';
import '../../../bloc/dashboard_bloc.dart';

enum MonthlyAndWeeklyType { week, month }

class MonthlyAndWeeklyViewWidget extends StatelessWidget {
  final List<UserLyDatum>? userMonthlyData;
  final MonthlyAndWeeklyType type;
  final DashboardBloc _bloc =
      DashboardBloc(); // Replace with your actual Bloc instance

  MonthlyAndWeeklyViewWidget({
    Key? key,
    required this.userMonthlyData,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _monthlyAndWeeklyView(userMonthlyData, type);
  }

  Widget _monthlyAndWeeklyView(
    List<UserLyDatum>? userMonthlyData,
    MonthlyAndWeeklyType type,
  ) {
    // Group entries by week or month
    Map<String, List<UserLyDatum>> entriesByPeriod = {};
    for (var entry in userMonthlyData ?? []) {
      DateTime createdAt = DateTime.parse(entry.createdAt.toString());
      String periodKey;

      if (type == MonthlyAndWeeklyType.week) {
        int weekNumber = _bloc.getIsoWeekNumber(createdAt);
        periodKey = '${createdAt.year}-W$weekNumber';
      } else {
        periodKey =
            '${createdAt.year}-M${createdAt.month.toString().padLeft(2, '0')}';
      }

      entriesByPeriod.putIfAbsent(periodKey, () => []);
      entriesByPeriod[periodKey]!.add(entry);
    }

    // Sort periods (most recent first)
    var sortedPeriods =
        entriesByPeriod.keys.toList()..sort((a, b) => b.compareTo(a));

    if (userMonthlyData == null || userMonthlyData.isEmpty) {
      return const Center(child: Text("No Details Found!"));
    }

    return ListView.builder(
      itemCount: sortedPeriods.length,
      itemBuilder: (context, index) {
        String periodKey = sortedPeriods[index];
        List<UserLyDatum> periodEntries = entriesByPeriod[periodKey]!;

        // Title
        String title;
        if (type == MonthlyAndWeeklyType.week) {
          title =
              '${_formatWeekLabel(periodKey)} (${periodEntries.length} entries)';
        } else {
          final yearMonth = periodKey.split('-M');
          final year = yearMonth[0];
          final monthNum = int.parse(yearMonth[1]);
          final monthName = DateFormat.MMMM().format(
            DateTime(int.parse(year), monthNum),
          );
          title = '$monthName $year (${periodEntries.length} entries)';
        }

        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: ExpansionTileTheme(
            data: ExpansionTileThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              collapsedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: ColorName.primary.withValues(alpha: 0.1),
              collapsedBackgroundColor: ColorName.lightBackgroundColor,
              iconColor: ColorName.primary,
              collapsedIconColor: ColorName.grey500,
              tilePadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              childrenPadding: const EdgeInsets.all(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: ExpansionTile(
                title: Text(title),
                subtitle: const Text('Tap to view Patient details'),
                children:
                    periodEntries.map((entry) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          title: Text(
                            'Date: ${_bloc.formatDateTime(entry.createdAt.toString())}',
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Grade: ${entry.grade}'),
                              Text('Submitted: ${entry.isWeeklySubmitted}'),
                              Text('User ID: ${entry.userId}'),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  // Converts an ISO period key like '2025-W34' to a human-friendly range
  // such as 'August 18 to 24'. Uses ISO week (Mon-Sun).
  String _formatWeekLabel(String periodKey) {
    try {
      final parts = periodKey.split('-W');
      final int year = int.parse(parts[0]);
      final int weekNumber = int.parse(parts[1]);

      final DateTime start = _isoWeekStartDate(year, weekNumber);
      final DateTime end = start.add(const Duration(days: 6));

      final bool sameMonth = start.month == end.month && start.year == end.year;
      if (sameMonth) {
        final String monthName = DateFormat.MMMM().format(start);
        return '$monthName ${start.day} to ${end.day}';
      } else {
        final String startLabel =
            '${DateFormat.MMM().format(start)} ${start.day}';
        final String endLabel = '${DateFormat.MMM().format(end)} ${end.day}';
        return '$startLabel to $endLabel';
      }
    } catch (_) {
      return periodKey; // Fallback to original
    }
  }

  // Returns the Monday of the given ISO week in the given year
  DateTime _isoWeekStartDate(int year, int weekNumber) {
    final DateTime jan4 = DateTime(year, 1, 4);
    final DateTime week1Monday = jan4.subtract(
      Duration(days: jan4.weekday - DateTime.monday),
    );
    return week1Monday.add(Duration(days: (weekNumber - 1) * 7));
  }
}
