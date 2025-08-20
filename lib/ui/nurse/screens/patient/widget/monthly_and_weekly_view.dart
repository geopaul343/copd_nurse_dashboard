import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../data/nurse/model/nurse/patient_checkup_data_model.dart';
import '../../../bloc/dashboard_bloc.dart';

enum MonthlyAndWeeklyType { week, month }


class MonthlyAndWeeklyViewWidget extends StatelessWidget {
  final List<UserLyDatum>? userMonthlyData;
  final MonthlyAndWeeklyType type;
  final DashboardBloc _bloc = DashboardBloc(); // Replace with your actual Bloc instance

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
    // Group entries by week or month based on type
    Map<String, List<UserLyDatum>> entriesByPeriod = {};
    for (var entry in userMonthlyData ?? []) {
      DateTime createdAt = DateTime.parse(entry.createdAt.toString());
      String periodKey;

      if (type == MonthlyAndWeeklyType.week) {
        // Weekly grouping (same as your original code)
        int weekNumber = _bloc.getIsoWeekNumber(createdAt);
        periodKey = '${createdAt.year}-W$weekNumber';
      } else {
        // Monthly grouping
        periodKey = '${createdAt.year}-M${createdAt.month.toString().padLeft(2, '0')}';
      }

      if (!entriesByPeriod.containsKey(periodKey)) {
        entriesByPeriod[periodKey] = [];
      }
      entriesByPeriod[periodKey]!.add(entry);
    }

    // Sort periods in descending order (most recent first)
    var sortedPeriods = entriesByPeriod.keys.toList()..sort((a, b) => b.compareTo(a));

    return userMonthlyData == null || userMonthlyData.isEmpty
        ? const Center(child: Text("No Details Found!"))
        : ListView.builder(
      itemCount: sortedPeriods.length,
      itemBuilder: (context, index) {
        String periodKey = sortedPeriods[index];
        List<UserLyDatum> periodEntries = entriesByPeriod[periodKey]!;

        // Format title based on type
        String title;
        if (type == MonthlyAndWeeklyType.week) {
          title = 'Week $periodKey (${periodEntries.length} entries)';
        } else {
          // Convert M08 to August, etc.
          final yearMonth = periodKey.split('-M');
          final year = yearMonth[0];
          final monthNum = int.parse(yearMonth[1]);
          final monthName = DateFormat.MMMM().format(DateTime(int.parse(year), monthNum));
          title = '$monthName $year (${periodEntries.length} entries)';
        }

        return ExpansionTile(
          title: Text(title),
          subtitle: const Text('Tap to view details'),
          children: periodEntries.map((entry) {
            return ListTile(
              title: Text('User: ${entry.userName}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date: ${_bloc.formatDateTime(entry.createdAt.toString())}'),
                  Text('Grade: ${entry.grade}'),
                  Text('Submitted: ${entry.isWeeklySubmitted}'), // Fixed to use isWeeklySubmitted
                  Text('User ID: ${entry.userId}'), // Fixed to use userId
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}