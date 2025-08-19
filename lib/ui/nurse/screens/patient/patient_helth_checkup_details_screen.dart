import 'package:admin_dashboard/app/helper/date_helper.dart';
import 'package:admin_dashboard/data/nurse/model/nurse/patient_checkup_data_model.dart';

import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:admin_dashboard/ui/nurse/bloc/dashboard_bloc.dart';
import 'package:admin_dashboard/ui/screens/onBoarding/onBoarding.dart';

import 'package:admin_dashboard/ui/widgets/custom_audio_player.dart';
import 'package:admin_dashboard/ui/widgets/custom_popup.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../app/helper/audio_helper.dart';

class PatientHealthCheckupDetailsScreen extends StatefulWidget {
  static const String path = '/patient-health-checkup';
  final String patientId;
  const PatientHealthCheckupDetailsScreen({super.key, required this.patientId});

  @override
  State<PatientHealthCheckupDetailsScreen> createState() =>
      _PatientHealthCheckupDetailsScreenState();
}

class _PatientHealthCheckupDetailsScreenState
    extends State<PatientHealthCheckupDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final DashboardBloc _bloc = DashboardBloc();
  final AudioPlayerController _audioController = AudioPlayerController();
  bool _groupByDate = true;

  bool _isSameDay(DateTime? a, DateTime b) {
    if (a == null) return false;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  DateTime _startOfWeek(DateTime date) {
    // Assuming week starts on Monday
    final normalized = DateTime(date.year, date.month, date.day);
    final int daysToSubtract = normalized.weekday - 1;
    return normalized.subtract(Duration(days: daysToSubtract));
  }

  DateTime _endOfWeek(DateTime date) {
    final start = _startOfWeek(date);
    return start.add(const Duration(days: 6));
  }

  // Note: current-week detection is done using weekStart comparison where needed

  bool _isInCurrentMonth(DateTime? date) {
    if (date == null) return false;
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    callPatientDetailApi();
  }

  callPatientDetailApi() async {
    // _bloc.getPatientCheckUpData(patientId: widget.patientId);
    _bloc.getPatientCheckUpDataById();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _tabBarView() {
    return TabBar(
      controller: _tabController,
      onTap: (_) => _audioController.playerStop(),
      dividerColor: ColorName.primary,
      indicatorColor: ColorName.primary,
      tabs: [
        Tab(icon: Icon(Icons.today), text: 'Daily'),
        Tab(icon: Icon(Icons.weekend), text: 'Weekly'),
        Tab(icon: Icon(Icons.calendar_month), text: 'Monthly'),
      ],
      labelColor: ColorName.primary,
    );
  }

  Widget _weeklyGroupingToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text("Group by date"),
        Switch(
          value: _groupByDate,
          onChanged: (v) {
            _audioController.playerStop();
            setState(() {
              _groupByDate = v;
            });
          },
        ),
      ],
    );
  }

  Widget _monthlyAndWeeklyView(
    List<UserLyDatum>? userMonthlyData,
    MonthlyAndWeeklyType type,
  ) {
    if (userMonthlyData == null || userMonthlyData.isEmpty) {
      return Center(child: Text("No Details Found!"));
    }

    // Weekly: group by week (Mon-Sun) into one widget per week
    if (type == MonthlyAndWeeklyType.week) {
      final Map<DateTime, List<UserLyDatum>> weekStartToItems = {};
      for (final item in userMonthlyData) {
        if (item.createdAt == null) continue;
        final DateTime weekStart = _startOfWeek(item.createdAt!);
        weekStartToItems.putIfAbsent(weekStart, () => []);
        weekStartToItems[weekStart]!.add(item);
      }

      final List<DateTime> sortedWeekStarts =
          weekStartToItems.keys.toList()..sort((a, b) => b.compareTo(a));
      final DateTime currentWeekStart = _startOfWeek(DateTime.now());

      List<Widget> weekWidgets = [];
      for (final weekStart in sortedWeekStarts) {
        final DateTime weekEnd = _endOfWeek(weekStart);
        final List<UserLyDatum> items =
            weekStartToItems[weekStart]!..sort((a, b) {
              final da = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
              final db = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
              return db.compareTo(da);
            });

        final bool isCurrent =
            weekStart.year == currentWeekStart.year &&
            weekStart.month == currentWeekStart.month &&
            weekStart.day == currentWeekStart.day;

        // Group inside week by day
        final Map<DateTime, List<UserLyDatum>> dayToItems = {};
        for (final it in items) {
          if (it.createdAt == null) continue;
          final dayKey = DateTime(
            it.createdAt!.year,
            it.createdAt!.month,
            it.createdAt!.day,
          );
          dayToItems.putIfAbsent(dayKey, () => []);
          dayToItems[dayKey]!.add(it);
        }
        final List<DateTime> sortedDays =
            dayToItems.keys.toList()..sort((a, b) => b.compareTo(a));

        List<Widget> dayTiles = [];
        for (final day in sortedDays) {
          final List<UserLyDatum> dayEntries =
              dayToItems[day]!..sort(
                (a, b) => (b.createdAt ?? DateTime(0)).compareTo(
                  a.createdAt ?? DateTime(0),
                ),
              );

          final String dayLabel = DateConverter.isoStringToLocalDateOnly(day);

          Widget usersList = Column(
            children:
                dayEntries
                    .map(
                      (data) => Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: ColorName.primary.withValues(alpha: 0.70),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Grade: ${data.grade}"),
                                Text("User Name: ${data.userName}"),
                              ],
                            ),
                            Spacer(),
                            data.createdAt != null
                                ? Text(
                                  "Date: ${DateConverter.isoStringToLocalDateOnly(data.createdAt!)}",
                                )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    )
                    .toList(),
          );

          dayTiles.add(
            Theme(
              data: Theme.of(
                context,
              ).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                tilePadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                childrenPadding: EdgeInsets.only(bottom: 8, left: 4, right: 4),
                title: Row(
                  children: [
                    Expanded(child: Text(dayLabel)),
                    Text(
                      "${dayEntries.length} entr${dayEntries.length == 1 ? 'y' : 'ies'}",
                    ),
                  ],
                ),
                children: [usersList],
                onExpansionChanged: (_) => _audioController.playerStop(),
              ),
            ),
          );
        }

        // Flat users list for the entire week (no day separation)
        Widget usersListFlat = Column(
          children:
              items
                  .map(
                    (data) => Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: ColorName.primary.withValues(alpha: 0.70),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 20,
                      ),
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Grade: ${data.grade}"),
                              Text("User Name: ${data.userName}"),
                            ],
                          ),
                          Spacer(),
                          data.createdAt != null
                              ? Text(
                                "Date: ${DateConverter.isoStringToLocalDateOnly(data.createdAt!)}",
                              )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  )
                  .toList(),
        );

        if (isCurrent) {
          weekWidgets.add(
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: ColorName.primary.withValues(alpha: 0.20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 20,
                    ),
                    child: Text(
                      "Week of ${DateConverter.isoStringToLocalDateOnly(weekStart)} - ${DateConverter.isoStringToLocalDateOnly(weekEnd)}",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child:
                        _groupByDate
                            ? Column(children: dayTiles)
                            : usersListFlat,
                  ),
                ],
              ),
            ),
          );
        } else {
          weekWidgets.add(
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: ColorName.primary.withValues(alpha: 0.20),
              ),
              child: Theme(
                data: Theme.of(
                  context,
                ).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  childrenPadding: EdgeInsets.only(
                    bottom: 12,
                    left: 8,
                    right: 8,
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Week of ${DateConverter.isoStringToLocalDateOnly(weekStart)} - ${DateConverter.isoStringToLocalDateOnly(weekEnd)}",
                            ),
                            Text(
                              "${items.length} entr${items.length == 1 ? 'y' : 'ies'}",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child:
                          _groupByDate
                              ? Column(children: dayTiles)
                              : usersListFlat,
                    ),
                  ],
                  onExpansionChanged: (_) => _audioController.playerStop(),
                ),
              ),
            ),
          );
        }
      }

      return SingleChildScrollView(child: Column(children: weekWidgets));
    }

    // Monthly: keep previous per-item behavior
    List<Widget> children = [];
    for (final data in userMonthlyData) {
      final bool isCurrent = _isInCurrentMonth(data.createdAt);

      if (isCurrent) {
        children.add(
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ColorName.primary.withValues(alpha: 0.70),
            ),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Grade: ${data.grade}"),
                    Text("User Name: ${data.userName}"),
                  ],
                ),
                Spacer(),
                data.createdAt != null
                    ? Text(
                      "Date: ${DateConverter.isoStringToLocalDateOnly(data.createdAt!)}",
                    )
                    : SizedBox(),
              ],
            ),
          ),
        );
      } else {
        children.add(
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ColorName.primary.withValues(alpha: 0.20),
            ),
            child: Theme(
              data: Theme.of(
                context,
              ).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                tilePadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                childrenPadding: EdgeInsets.only(
                  bottom: 12,
                  left: 16,
                  right: 16,
                ),
                title: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Month Summary"),
                          Text("Grade: ${data.grade ?? "N/A"}"),
                        ],
                      ),
                    ),
                    data.createdAt != null
                        ? Text(
                          DateConverter.isoStringToLocalDateOnly(
                            data.createdAt!,
                          ),
                        )
                        : SizedBox(),
                  ],
                ),
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: ColorName.primary.withValues(alpha: 0.70),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Grade: ${data.grade}"),
                            Text("User Name: ${data.userName}"),
                          ],
                        ),
                        Spacer(),
                        data.createdAt != null
                            ? Text(
                              "Date: ${DateConverter.isoStringToLocalDateOnly(data.createdAt!)}",
                            )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }

    return SingleChildScrollView(child: Column(children: children));
  }

  Widget _dailyView(List<UserDailyDatum>? userData) {
    if (userData == null || userData.isEmpty) {
      return Center(child: Text("No Details Found!"));
    }

    Widget buildDailyContent(UserDailyDatum data) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("UserName: ${data.userName ?? "N/A"}"),
          Text("Breathing: ${data.data?.breathing ?? "N/A"}"),
          Text(
            "DidShortWalk: ${data.data?.didShortWalk == true ? "Available" : "Not Available"}",
          ),
          Text(
            "HasInhalerStock: ${data.data?.hasInhalerStock == true ? "Available" : "Not Available"}",
          ),
          Text("PhlegmChange: ${data.data?.phlegmChange ?? "N/A"}"),
          Text("PhlegmColor: ${data.data?.phlegmColor ?? "N/A"}"),
          Text("RelieverPuffs: ${data.data?.relieverPuffs ?? "N/A"}"),
          Text("spo2: ${data.data?.spo2 ?? "N/A"}"),
          Text(
            "TookRegularInhaler: ${data.data?.tookRegularInhaler == true ? "Available" : "Not Available"}",
          ),
          Text(
            "UsedOxygenAsPrescribed: ${data.data?.usedOxygenAsPrescribed == true ? "Available" : "Not Available"}",
          ),
          data.createdAt != null
              ? Text(
                "Date: ${DateConverter.isoStringToLocalDateOnly(data.createdAt!)}",
              )
              : SizedBox(),
          if (data.data?.lungSoundRecordings != null ||
              data.data?.lungSoundRecordings?.isNotEmpty == true) ...[
            Text("Audios "),
            Row(
              children:
                  data.data!.lungSoundRecordings!
                      .map(
                        (audio) => Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: AudioWidget(
                            url: audio.fileUri ?? "",
                            controller: _audioController,
                          ),
                        ),
                      )
                      .toList(),
            ),
          ],
        ],
      );
    }

    List<Widget> children = [];
    for (final data in userData) {
      final bool isToday = _isSameDay(data.createdAt, DateTime.now());
      if (isToday) {
        children.add(
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ColorName.primary.withValues(alpha: 0.50),
            ),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            margin: EdgeInsets.only(bottom: 10),
            child: buildDailyContent(data),
          ),
        );
      } else {
        children.add(
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ColorName.primary.withValues(alpha: 0.20),
            ),
            child: Theme(
              data: Theme.of(
                context,
              ).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                tilePadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                childrenPadding: EdgeInsets.only(
                  bottom: 12,
                  left: 16,
                  right: 16,
                ),
                title: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${data.userName ?? "N/A"}"),
                          Text(
                            data.createdAt != null
                                ? DateConverter.isoStringToLocalDateOnly(
                                  data.createdAt!,
                                )
                                : "",
                          ),
                        ],
                      ),
                    ),
                    if (data.data?.spo2 != null)
                      Text("SpO2: ${data.data!.spo2}"),
                  ],
                ),
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: ColorName.primary.withValues(alpha: 0.50),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: buildDailyContent(data),
                  ),
                ],
                onExpansionChanged: (_) => _audioController.playerStop(),
              ),
            ),
          ),
        );
      }
    }

    return SingleChildScrollView(child: Column(children: children));
  }

  Widget _tabBarContentView(PatientCheckUpDataModel? data) {
    return TabBarView(
      controller: _tabController,
      children: [
        // Content for Daily Tab
        _dailyView(data?.data?.userDailyData),
        // Content for Weekly Tab
        Column(
          children: [
            _weeklyGroupingToggle(),
            Expanded(
              child: _monthlyAndWeeklyView(
                data?.data?.userWeeklyData,
                MonthlyAndWeeklyType.week,
              ),
            ),
          ],
        ),
        // Content for Monthly Tab
        _monthlyAndWeeklyView(
          data?.data?.userMonthlyData,
          MonthlyAndWeeklyType.month,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Health data"),
        backgroundColor: ColorName.primary.withValues(alpha: 0.50),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () async {
              buildPatientPopupMenu(
                onSelected: (String value) {
                  if (value == 'add_patient') {
                    Navigator.pushNamed(context, Onboarding.path);
                  } else if (value == 'view_patients') {
                    // Logic to view patients
                    print('View Patients selected');
                  }
                },
              );

              //  Navigator.pushNamed(
              //                       context,
              //                       Onboarding.path,

              //                     );

              //  showExitDialog(context);
            },
          ),
        ],
      ),
      body: StreamBuilder<PatientCheckUpDataModel>(
        stream: _bloc.patientDataStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Gap(20),
                  _tabBarView(),
                  Gap(10),
                  Expanded(child: _tabBarContentView(snapshot.data)),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

enum MonthlyAndWeeklyType { week, month }
