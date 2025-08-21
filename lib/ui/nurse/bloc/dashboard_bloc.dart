// added same day , same week and current month check in this logic

import 'dart:async';
import 'package:admin_dashboard/data/nurse/model/nurse/patient_checkup_data_model.dart';
import 'package:admin_dashboard/data/nurse/repository/dashboard/dashboard_repo_impl.dart';
import 'package:admin_dashboard/data/nurse/model/nurse/search_user_model.dart';
import 'package:intl/intl.dart';

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
      final PatientCheckUpDataModel filteredData = _processDataNew(response);
      _patientDataController.add(filteredData);
    } catch (e) {
      _patientDataController.addError('Failed to fetch patient data: $e');
    }
  }

  Future getPatientCheckUpDataById() async {
    try {
      PatientCheckUpDataModel response =
          await _repo.fetchPatientCheckupDataById();
      final filteredData = _processDataNew(response);
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

  PatientCheckUpDataModel _processDataNew(PatientCheckUpDataModel response) {
    PatientCheckUpDataModel filteredData = PatientCheckUpDataModel(
      message: response.message,
      data:
          response.data != null
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
      if (response.data!.userDailyData != null &&
          response.data!.userDailyData!.isNotEmpty) {
        final sortedDailyData = List<UserDailyDatum>.from(
          response.data!.userDailyData!,
        )..sort(
          (a, b) => (a.createdAt ?? DateTime(0)).compareTo(
            b.createdAt ?? DateTime(0),
          ),
        );
        filteredData.data!.userDailyData = sortedDailyData;
      } else {
        filteredData.data!.userDailyData = [];
      }

      // Sort user_weekly_data by createdAt
      if (response.data!.userWeeklyData != null &&
          response.data!.userWeeklyData!.isNotEmpty) {
        final sortedWeeklyData = List<UserLyDatum>.from(
          response.data!.userWeeklyData!,
        )..sort(
          (a, b) => (a.createdAt ?? DateTime(0)).compareTo(
            b.createdAt ?? DateTime(0),
          ),
        );
        filteredData.data!.userWeeklyData = sortedWeeklyData;
      } else {
        filteredData.data!.userWeeklyData = [];
      }

      // Sort user_monthly_data by createdAt
      if (response.data!.userMonthlyData != null &&
          response.data!.userMonthlyData!.isNotEmpty) {
        final sortedMonthlyData = List<UserLyDatum>.from(
          response.data!.userMonthlyData!,
        )..sort(
          (a, b) => (a.createdAt ?? DateTime(0)).compareTo(
            b.createdAt ?? DateTime(0),
          ),
        );
        filteredData.data!.userMonthlyData = sortedMonthlyData;
      } else {
        filteredData.data!.userMonthlyData = [];
      }
    }

    return filteredData;
  }

  // Function to get ISO week number
  int getIsoWeekNumber(DateTime date) {
    // Adjust to the ISO week date system (week starts on Monday)
    DateTime adjustedDate = date.subtract(Duration(days: date.weekday - 1));
    DateTime firstDayOfYear = DateTime(date.year, 1, 1);
    int daysDifference = adjustedDate.difference(firstDayOfYear).inDays;
    int weekNumber =
        ((daysDifference + firstDayOfYear.weekday + 6) / 7).floor() + 1;
    // Handle edge case for week 53/1 crossover
    if (date.month == 12 && weekNumber == 53) {
      DateTime nextYearFirstDay = DateTime(date.year + 1, 1, 1);
      if (nextYearFirstDay.weekday <= 4) {
        return 1; // Belongs to week 1 of next year
      }
    }
    if (date.month == 1 && weekNumber > 50) {
      DateTime prevYearFirstDay = DateTime(date.year - 1, 1, 1);
      if (prevYearFirstDay.weekday > 4) {
        return weekNumber; // Belongs to last week of previous year
      }
    }
    return weekNumber;
  }

  String formatDateTime(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('MMM dd, yyyy, hh:mm a').format(dateTime.toLocal());
  }

  void dispose() {
    _searchController.close();
    _patientDataController.close();
  }
}
