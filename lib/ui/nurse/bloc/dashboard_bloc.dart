// import 'dart:async';
// import 'package:admin_dashboard/data/nurse/model/nurse/patient_checkup_data_model.dart';
// import 'package:admin_dashboard/data/nurse/repository/dashboard/dashboard_repo_impl.dart';
// import '../../../data/nurse/model/nurse/search_user_model.dart';

// class DashboardBloc {

//   final DashBoardRepoImpl _repo = DashBoardRepoImpl();
//   final StreamController<List<PatientUser>> _searchController =
//       StreamController<List<PatientUser>>();
//   Stream<List<PatientUser>> get searchStream => _searchController.stream;

//   final StreamController<PatientCheckUpDataModel> _patientDataController =
//       StreamController<PatientCheckUpDataModel>();
//   Stream<PatientCheckUpDataModel> get patientDataStream =>
//       _patientDataController.stream;

//   Future searchUser({required String name}) async {
//     try {
//       SearchResponse response = await _repo.searchUser(name: name);
//       if (response.users.isNotEmpty) {
//         _searchController.sink.add(response.users);
//       } else {
//         _searchController.addError('No users found');
//       }
//     } catch (e) {
//       _searchController.addError('something went wrong');
//     }
//   }

//   Future getPatientCheckUpData({required String patientId}) async {
//     try {
//       PatientCheckUpDataModel response = await _repo.fetchPatientCheckupData(
//         patientId: patientId,
//       );
//       _patientDataController.add(response);
//     } catch (e) {
//       _patientDataController.addError(e.toString());
//     }
//   }

//   Future getPatientCheckUpDataById() async {

//     try{
//       PatientCheckUpDataModel response = await _repo.fetchPatientCheckupDataById();

//       _patientDataController.add(response);
//     }catch (e){
//       _patientDataController.addError(e.toString());
//     }
//   }
// }

// working code but ui is not ready yet

// import 'dart:async';
// import 'package:admin_dashboard/app/helper/date_helper.dart';
// import 'package:admin_dashboard/data/nurse/model/nurse/patient_checkup_data_model.dart';
// import 'package:admin_dashboard/data/nurse/repository/dashboard/dashboard_repo_impl.dart';
// import 'package:admin_dashboard/data/nurse/model/nurse/search_user_model.dart';

// class DashboardBloc {
//   final DashBoardRepoImpl _repo = DashBoardRepoImpl();
//   final StreamController<List<PatientUser>> _searchController =
//       StreamController<List<PatientUser>>();
//   Stream<List<PatientUser>> get searchStream => _searchController.stream;

//   final StreamController<Map<String, List<dynamic>>> _patientDataController =
//       StreamController<Map<String, List<dynamic>>>();
//   Stream<Map<String, List<dynamic>>> get patientDataStream =>
//       _patientDataController.stream;

//   // Helper method to calculate the start of the week (Monday)
//   DateTime _startOfWeek(DateTime date) {
//     final normalized = DateTime(date.year, date.month, date.day);
//     final int daysToSubtract = normalized.weekday - 1;
//     return normalized.subtract(Duration(days: daysToSubtract));
//   }

//   // Helper method to calculate the end of the week (Sunday)
//   DateTime _endOfWeek(DateTime date) {
//     final start = _startOfWeek(date);
//     return start.add(const Duration(days: 6));
//   }

//   Future searchUser({required String name}) async {
//     try {
//       SearchResponse response = await _repo.searchUser(name: name);
//       if (response.users.isNotEmpty) {
//         _searchController.sink.add(response.users);
//       } else {
//         _searchController.addError('No users found');
//       }
//     } catch (e) {
//       _searchController.addError('Something went wrong: $e');
//     }
//   }

//   Future getPatientCheckUpData({required String patientId}) async {
//     try {
//       PatientCheckUpDataModel response = await _repo.fetchPatientCheckupData(
//         patientId: patientId,
//       );
//       final filteredData = _processData(response);
//       _patientDataController.add(filteredData);
//     } catch (e) {
//       _patientDataController.addError('Failed to fetch patient data: $e');
//     }
//   }

//   Future getPatientCheckUpDataById() async {
//     try {
//       PatientCheckUpDataModel response = await _repo.fetchPatientCheckupDataById();
//       final filteredData = _processData(response);

//       print("+++++++++++++++++++++++++++++++");
//       print(filteredData);

//       _patientDataController.add(filteredData);
//     } catch (e) {
//       _patientDataController.addError('Failed to fetch patient data: $e');
//     }
//   }

//   Map<String, List<dynamic>> _processData(PatientCheckUpDataModel response) {
//     final Map<String, List<dynamic>> filteredData = {
//       'filtered_days': <UserDailyDatum>[],
//       'filtered_weeks': <UserLyDatum>[],
//       'filtered_months': <UserLyDatum>[],
//     };

//     // Process daily data: sort newest to oldest
//     if (response.data?.userDailyData != null) {
//       filteredData['filtered_days'] = List<UserDailyDatum>.from(response.data!.userDailyData!)
//         ..sort((a, b) {
//           final da = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
//           final db = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
//           return db.compareTo(da);
//         });
//     }

//     // Process weekly data: group by week, sort newest to oldest
//     if (response.data?.userWeeklyData != null) {
//       final Map<DateTime, List<UserLyDatum>> weekStartToItems = {};
//       for (final item in response.data!.userWeeklyData!) {
//         if (item.createdAt == null) continue;
//         final DateTime weekStart = startOfWeek(item.createdAt!);
//         weekStartToItems.putIfAbsent(weekStart, () => []);
//         weekStartToItems[weekStart]!.add(item);
//       }

//       final List<DateTime> sortedWeekStarts = weekStartToItems.keys.toList()
//         ..sort((a, b) => b.compareTo(a));
//       final DateTime currentWeekStart = startOfWeek(DateTime.now());

//       List<UserLyDatum> sortedWeeklyData = [];
//       for (final weekStart in sortedWeekStarts) {
//         final DateTime weekEnd = endOfWeek(weekStart);
//         final bool isCurrentWeek =
//             weekStart.year == currentWeekStart.year &&
//             weekStart.month == currentWeekStart.month &&
//             weekStart.day == currentWeekStart.day;

//         // Add week header
//         sortedWeeklyData.add(UserLyDatum(
//           userId: null, // Marker for week header
//           userName: "Week of ${DateConverter.isoStringToLocalDateOnly(weekStart)} - ${DateConverter.isoStringToLocalDateOnly(weekEnd)}",
//           createdAt: weekStart,
//           isWeeklySubmitted: isCurrentWeek ? 'current' : 'past',
//         ));

//         // Sort entries within the week (newest to oldest)
//         final List<UserLyDatum> items = weekStartToItems[weekStart]!
//           ..sort((a, b) {
//             final da = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
//             final db = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
//             return db.compareTo(da);
//           });

//         sortedWeeklyData.addAll(items);
//       }
//       filteredData['filtered_weeks'] = sortedWeeklyData;
//     }

//     // Process monthly data: sort newest to oldest
//     if (response.data?.userMonthlyData != null) {
//       filteredData['filtered_months'] = List<UserLyDatum>.from(response.data!.userMonthlyData!)
//         ..sort((a, b) {
//           final da = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
//           final db = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
//           return db.compareTo(da);
//         });
//     }

//     return filteredData;
//   }

//   void dispose() {
//     _searchController.close();
//     _patientDataController.close();
//   }
// }

//  not added same day , same week and current month check in this logic

// import 'dart:async';
// import 'package:admin_dashboard/app/helper/date_helper.dart';
// import 'package:admin_dashboard/data/nurse/model/nurse/patient_checkup_data_model.dart';
// import 'package:admin_dashboard/data/nurse/repository/dashboard/dashboard_repo_impl.dart';
// import 'package:admin_dashboard/data/nurse/model/nurse/search_user_model.dart';

// class DashboardBloc {
//   final DashBoardRepoImpl _repo = DashBoardRepoImpl();
//   final StreamController<List<PatientUser>> _searchController =
//       StreamController<List<PatientUser>>();
//   Stream<List<PatientUser>> get searchStream => _searchController.stream;

//   final StreamController<Map<String, List<dynamic>>> _patientDataController =
//       StreamController<Map<String, List<dynamic>>>();
//   Stream<Map<String, List<dynamic>>> get patientDataStream =>
//       _patientDataController.stream;

//   // Helper method to calculate the start of the week (Monday)
//   DateTime _startOfWeek(DateTime date) {
//     final normalized = DateTime(date.year, date.month, date.day);
//     final int daysToSubtract = normalized.weekday - 1;
//     return normalized.subtract(Duration(days: daysToSubtract));
//   }

//   // Helper method to calculate the end of the week (Sunday)
//   DateTime _endOfWeek(DateTime date) {
//     final start = _startOfWeek(date);
//     return start.add(const Duration(days: 6));
//   }

//   Future searchUser({required String name}) async {
//     try {
//       SearchResponse response = await _repo.searchUser(name: name);
//       if (response.users.isNotEmpty) {
//         _searchController.sink.add(response.users);
//       } else {
//         _searchController.addError('No users found');
//       }
//     } catch (e) {
//       _searchController.addError('Something went wrong: $e');
//     }
//   }

//   Future getPatientCheckUpData({required String patientId}) async {
//     try {
//       PatientCheckUpDataModel response = await _repo.fetchPatientCheckupData(
//         patientId: patientId,
//       );
//       final filteredData = _processData(response);
//       _patientDataController.add(filteredData);
//     } catch (e) {
//       _patientDataController.addError('Failed to fetch patient data: $e');
//     }
//   }

//   Future getPatientCheckUpDataById() async {
//     try {
//       PatientCheckUpDataModel response = await _repo.fetchPatientCheckupDataById();
//       final filteredData = _processData(response);

//       print("+++++++++++++++++++++++++++++++");
//       print(filteredData);

//       _patientDataController.add(filteredData);
//     } catch (e) {
//       _patientDataController.addError('Failed to fetch patient data: $e');
//     }
//   }

//   Map<String, List<dynamic>> _processData(PatientCheckUpDataModel response) {
//     final Map<String, List<dynamic>> filteredData = {
//       'filtered_days': <UserDailyDatum>[],
//       'filtered_weeks': <UserLyDatum>[],
//       'filtered_months': <UserLyDatum>[],
//     };

//     // Process daily data: sort newest to oldest
//     if (response.data?.userDailyData != null) {
//       filteredData['filtered_days'] = List<UserDailyDatum>.from(response.data!.userDailyData!)
//         ..sort((a, b) {
//           final da = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
//           final db = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
//           return db.compareTo(da);
//         });
//     }

//     // Process weekly data: group by week, sort newest to oldest
//     if (response.data?.userWeeklyData != null) {
//       final Map<DateTime, List<UserLyDatum>> weekStartToItems = {};
//       for (final item in response.data!.userWeeklyData!) {
//         if (item.createdAt == null) continue;
//         final DateTime weekStart = startOfWeek(item.createdAt!);
//         weekStartToItems.putIfAbsent(weekStart, () => []);
//         weekStartToItems[weekStart]!.add(item);
//       }

//       final List<DateTime> sortedWeekStarts = weekStartToItems.keys.toList()
//         ..sort((a, b) => b.compareTo(a));
//       final DateTime currentWeekStart = startOfWeek(DateTime.now());

//       List<UserLyDatum> sortedWeeklyData = [];
//       for (final weekStart in sortedWeekStarts) {
//         final DateTime weekEnd = endOfWeek(weekStart);
//         final bool isCurrentWeek =
//             weekStart.year == currentWeekStart.year &&
//             weekStart.month == currentWeekStart.month &&
//             weekStart.day == currentWeekStart.day;

//         // Add week header
//         sortedWeeklyData.add(UserLyDatum(
//           userId: null, // Marker for week header
//           userName: "Week of ${DateConverter.isoStringToLocalDateOnly(weekStart)} - ${DateConverter.isoStringToLocalDateOnly(weekEnd)}",
//           createdAt: weekStart,
//           isWeeklySubmitted: isCurrentWeek ? 'current' : 'past',
//         ));

//         // Sort entries within the week (newest to oldest)
//         final List<UserLyDatum> items = weekStartToItems[weekStart]!
//           ..sort((a, b) {
//             final da = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
//             final db = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
//             return db.compareTo(da);
//           });

//         sortedWeeklyData.addAll(items);
//       }
//       filteredData['filtered_weeks'] = sortedWeeklyData;
//     }

//     // Process monthly data: sort newest to oldest
//     if (response.data?.userMonthlyData != null) {
//       filteredData['filtered_months'] = List<UserLyDatum>.from(response.data!.userMonthlyData!)
//         ..sort((a, b) {
//           final da = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
//           final db = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
//           return db.compareTo(da);
//         });
//     }

//     return filteredData;
//   }

//   void dispose() {
//     _searchController.close();
//     _patientDataController.close();
//   }
// }

// added same day , same week and current month check in this logic

import 'dart:async';
import 'package:admin_dashboard/app/helper/date_helper.dart';
import 'package:admin_dashboard/data/nurse/model/nurse/patient_checkup_data_model.dart';
import 'package:admin_dashboard/data/nurse/repository/dashboard/dashboard_repo_impl.dart';
import 'package:admin_dashboard/data/nurse/model/nurse/search_user_model.dart';

class DashboardBloc {
  final DashBoardRepoImpl _repo = DashBoardRepoImpl();
  final StreamController<List<PatientUser>> _searchController =
      StreamController<List<PatientUser>>();
  Stream<List<PatientUser>> get searchStream => _searchController.stream;

  final StreamController<Map<String, List<dynamic>>> _patientDataController =
      StreamController<Map<String, List<dynamic>>>();
  Stream<Map<String, List<dynamic>>> get patientDataStream =>
      _patientDataController.stream;

  // Helper method to check if two dates are the same day
  bool isSameDay(DateTime? a, DateTime b) {
    if (a == null) return false;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  // Helper method to check if two dates are in the same week
  bool isSameWeek(DateTime? a, DateTime? b) {
    if (a == null || b == null) return false;
    final weekStartA = DateTime(
      a.year,
      a.month,
      a.day,
    ).subtract(Duration(days: a.weekday - 1));
    final weekStartB = DateTime(
      b.year,
      b.month,
      b.day,
    ).subtract(Duration(days: b.weekday - 1));
    return weekStartA.year == weekStartB.year &&
        weekStartA.month == weekStartB.month &&
        weekStartA.day == weekStartB.day;
  }

  // Helper method to check if a date is in the current month
  bool isInCurrentMonth(DateTime? date) {
    if (date == null) return false;
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }

  // Helper method to calculate the start of the week (Monday)
  DateTime startOfWeek(DateTime date) {
    final normalized = DateTime(date.year, date.month, date.day);
    final int daysToSubtract = normalized.weekday - 1;
    return normalized.subtract(Duration(days: daysToSubtract));
  }

  // Helper method to calculate the end of the week (Sunday)
  DateTime endOfWeek(DateTime date) {
    final start = startOfWeek(date);
    return start.add(const Duration(days: 6));
  }


  Future searchUser({required String name}) async {
    try {
      SearchResponse response = await _repo.searchUser(name: name);
      if (response.users.isNotEmpty) {
        _searchController.sink.add(response.users);
      } else {
        _searchController.addError('No users found');
      }
    } catch (e) {
      _searchController.addError('Something went wrong: $e');
    }
  }

  Future getPatientCheckUpData({required String patientId}) async {
    try {
      PatientCheckUpDataModel response = await _repo.fetchPatientCheckupData(
        patientId: patientId,
      );
      final filteredData = _processData(response);
      _patientDataController.add(filteredData);
    } catch (e) {
      _patientDataController.addError('Failed to fetch patient data: $e');
    }
  }

  Future getPatientCheckUpDataById() async {
    try {
      PatientCheckUpDataModel response =
          await _repo.fetchPatientCheckupDataById();
      final filteredData = _processData(response);
      _patientDataController.add(filteredData);
    } catch (e) {
      _patientDataController.addError('Failed to fetch patient data: $e');
    }
  }

  Map<String, List<dynamic>> _processData(PatientCheckUpDataModel response) {
    final Map<String, List<dynamic>> filteredData = {
      'filtered_days': <UserDailyDatum>[],
      'filtered_weeks': <UserLyDatum>[],
      'filtered_months': <UserLyDatum>[],
    };

    // Process daily data: sort newest to oldest
    if (response.data?.userDailyData != null) {
      filteredData['filtered_days'] = List<UserDailyDatum>.from(
        response.data!.userDailyData!,
      )..sort((a, b) {
        final da = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        final db = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        return db.compareTo(da);
      });
    }

    // Process weekly data: group by week, sort newest to oldest
    if (response.data?.userWeeklyData != null) {
      final Map<DateTime, List<UserLyDatum>> weekStartToItems = {};
      for (final item in response.data!.userWeeklyData!) {
        if (item.createdAt == null) continue;
        final DateTime weekStart = startOfWeek(item.createdAt!);
        weekStartToItems.putIfAbsent(weekStart, () => []);
        weekStartToItems[weekStart]!.add(item);
      }

      final List<DateTime> sortedWeekStarts =
          weekStartToItems.keys.toList()..sort((a, b) => b.compareTo(a));

      List<UserLyDatum> sortedWeeklyData = [];
      for (final weekStart in sortedWeekStarts) {
        final DateTime weekEnd = endOfWeek(weekStart);

        // Count entries for this week
        final entryCount = weekStartToItems[weekStart]!.length;

        // Add week header
        sortedWeeklyData.add(
          UserLyDatum(
            userId: null, // Marker for week header
            userName:
                "Week of ${DateConverter.isoStringToLocalDateOnly(weekStart)} - ${DateConverter.isoStringToLocalDateOnly(weekEnd)}",
            createdAt: weekStart,
            isWeeklySubmitted: entryCount.toString(), // Store entry count
          ),
        );

        // Sort entries within the week (newest to oldest)
        final List<UserLyDatum> items =
            weekStartToItems[weekStart]!..sort((a, b) {
              final da = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
              final db = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
              return db.compareTo(da);
            });

        sortedWeeklyData.addAll(items);
      }
      filteredData['filtered_weeks'] = sortedWeeklyData;
    }

    // Process monthly data: sort newest to oldest
    if (response.data?.userMonthlyData != null) {
      filteredData['filtered_months'] = List<UserLyDatum>.from(
        response.data!.userMonthlyData!,
      )..sort((a, b) {
        final da = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        final db = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        return db.compareTo(da);
      });
    }

    return filteredData;
  }

  void dispose() {
    _searchController.close();
    _patientDataController.close();
  }
}
