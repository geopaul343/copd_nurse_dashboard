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



     final StreamController<PatientCheckUpDataModel> _patientDataController =
    StreamController<PatientCheckUpDataModel>();

    
  Stream<PatientCheckUpDataModel> get patientDataStream =>
      _patientDataController.stream;

   


  // Group by date toggle for weekly view
  final StreamController<bool> _groupByDateController =
      StreamController<bool>();
  Stream<bool> get groupByDateStream => _groupByDateController.stream;
  bool _groupByDate = true;
  bool get groupByDate => _groupByDate;

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
      final PatientCheckUpDataModel filteredData = _processDataNew(
        response,
      );
      _patientDataController.add(filteredData );
    } catch (e) {
      _patientDataController.addError('Failed to fetch patient data: $e');
    }
  }

  Future getPatientCheckUpDataById() async {
    try {
      PatientCheckUpDataModel response =
          await _repo.fetchPatientCheckupDataById();
      // final filteredData = _processData(response);
      print("ooooooooooooo");
      final filteredData = _processDataNew(response);
      print("qqqqq1133434324$filteredData");
      _patientDataController.add(filteredData);


      
    } catch (e) {
      _patientDataController.addError('Failed to fetch patient data: $e');
    }
  }

  // Set group by date value
  void setGroupByDate(bool value) {
    _groupByDate = value;
    _groupByDateController.add(_groupByDate);
  }

  // Update the method to return the data part directly
  // PatientCheckUpDataModel _processDataNew(
  //   PatientCheckUpDataModel response,
  // ) {
  //   PatientCheckUpDataModel patientCheckUpDatamodel = PatientCheckUpDataModel(
  //     message: response.message,
  //     data: PatientCheckUpDataModelData(
  //       userDailyData: [],
  //       userWeeklyData: [],
  //       userMonthlyData: [],
  //     ),
  //   );

  //   // Sort the data and return it directly
  //   final data = response.data!;

  //   // Sort user_daily_data by createdAt
  //   if (data.userDailyData != null && data.userDailyData!.isNotEmpty) {
  //     data.userDailyData!.sort(
  //       (a, b) =>
  //           (a.createdAt ?? DateTime(0)).compareTo(b.createdAt ?? DateTime(0)),
  //     );
  //   }

  //   // Sort user_weekly_data by createdAt
  //   if (data.userWeeklyData != null && data.userWeeklyData!.isNotEmpty) {
  //     data.userWeeklyData!.sort(
  //       (a, b) =>
  //           (a.createdAt ?? DateTime(0)).compareTo(b.createdAt ?? DateTime(0)),
  //     );
  //   }

  //   // Sort user_monthly_data by createdAt
  //   if (data.userMonthlyData != null && data.userMonthlyData!.isNotEmpty) {
  //     data.userMonthlyData!.sort(
  //       (a, b) =>
  //           (a.createdAt ?? DateTime(0)).compareTo(b.createdAt ?? DateTime(0)),
  //     );
  //   }

  //   // return patientCheckUpDatamodel;

  //    return patientCheckUpDatamodel;
    
  // }


  PatientCheckUpDataModel _processDataNew(PatientCheckUpDataModel response) {
  PatientCheckUpDataModel filteredData = PatientCheckUpDataModel(
    message: response.message,
    data: response.data != null
        ? PatientCheckUpDataModelData(
      userDailyData: [],
      userWeeklyData: [],
      userMonthlyData: [],
    )
        : null,
  );

  // Check if response.data is not null
  if (response.data != null) {
    // Sort user_daily_data by createdAt
    if (response.data!.userDailyData != null && response.data!.userDailyData!.isNotEmpty) {
      final sortedDailyData = List<UserDailyDatum>.from(response.data!.userDailyData!)
        ..sort((a, b) => (a.createdAt ?? DateTime(0)).compareTo(b.createdAt ?? DateTime(0)));
      filteredData.data!.userDailyData = sortedDailyData;
    } else {
      filteredData.data!.userDailyData = [];
    }

    // Sort user_weekly_data by createdAt
    if (response.data!.userWeeklyData != null && response.data!.userWeeklyData!.isNotEmpty) {
      final sortedWeeklyData = List<UserLyDatum>.from(response.data!.userWeeklyData!)
        ..sort((a, b) => (a.createdAt ?? DateTime(0)).compareTo(b.createdAt ?? DateTime(0)));
      filteredData.data!.userWeeklyData = sortedWeeklyData;
    } else {
      filteredData.data!.userWeeklyData = [];
    }

    // Sort user_monthly_data by createdAt
    if (response.data!.userMonthlyData != null && response.data!.userMonthlyData!.isNotEmpty) {
      final sortedMonthlyData = List<UserLyDatum>.from(response.data!.userMonthlyData!)
        ..sort((a, b) => (a.createdAt ?? DateTime(0)).compareTo(b.createdAt ?? DateTime(0)));
      filteredData.data!.userMonthlyData = sortedMonthlyData;
    } else {
      filteredData.data!.userMonthlyData = [];
    }
  }

  return filteredData;
}

  void dispose() {
    _searchController.close();
    _patientDataController.close();
  }
}
