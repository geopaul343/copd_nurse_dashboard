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

  // Using helper methods from DashboardBloc instead of duplicating logic

  void _addWeekWidget(
    List<Widget> weekWidgets,
    UserLyDatum weekHeader,
    List<UserLyDatum> items,
    DateTime currentWeekStart,
  ) {
    if (weekHeader.createdAt == null) return;

    final bool isCurrent = _bloc.isSameWeek(
      weekHeader.createdAt,
      currentWeekStart,
    );

    // Group items by day for the toggle functionality
    final Map<DateTime, List<UserLyDatum>> dayToItems = {};
    for (final item in items) {
      if (item.createdAt == null) continue;
      final dayKey = DateTime(
        item.createdAt!.year,
        item.createdAt!.month,
        item.createdAt!.day,
      );
      dayToItems.putIfAbsent(dayKey, () => []);
      dayToItems[dayKey]!.add(item);
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
                )
                .toList(),
      );

      dayTiles.add(
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
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
                child: Text(weekHeader.userName ?? ''),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child:
                    _bloc.groupByDate
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
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              childrenPadding: EdgeInsets.only(bottom: 12, left: 8, right: 8),
              title: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(weekHeader.userName ?? ''),
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
                      _bloc.groupByDate
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
    _bloc.dispose();
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
    return StreamBuilder<bool>(
      stream: _bloc.groupByDateStream,
      initialData: _bloc.groupByDate,
      builder: (context, snapshot) {
        final groupByDate = snapshot.data ?? true;
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("Group by date"),
            Switch(
              value: groupByDate,
              onChanged: (v) {
                _audioController.playerStop();
                _bloc.setGroupByDate(v);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _monthlyAndWeeklyView(
    List<UserLyDatum>? userMonthlyData,
    MonthlyAndWeeklyType type,
  ) {
    if (userMonthlyData == null || userMonthlyData.isEmpty) {
      return Center(child: Text("No Details Found!"));
    }

    // Weekly: process data that's already grouped by the improved bloc
    if (type == MonthlyAndWeeklyType.week) {
      List<Widget> weekWidgets = [];
      List<UserLyDatum> currentWeekItems = [];
      UserLyDatum? currentWeekHeader;
      final DateTime currentWeekStart = _bloc.startOfWeek(DateTime.now());

      for (int i = 0; i < userMonthlyData.length; i++) {
        final item = userMonthlyData[i];

        if (item.userId == null) {
          // This is a week header - process previous week if any
          if (currentWeekHeader != null) {
            _addWeekWidget(
              weekWidgets,
              currentWeekHeader,
              currentWeekItems,
              currentWeekStart,
            );
          }
          // Start new week
          currentWeekHeader = item;
          currentWeekItems = [];
        } else {
          // This is a data item
          currentWeekItems.add(item);
        }
      }

      // Process the last week if any
      if (currentWeekHeader != null) {
        _addWeekWidget(
          weekWidgets,
          currentWeekHeader,
          currentWeekItems,
          currentWeekStart,
        );
      }

      return SingleChildScrollView(child: Column(children: weekWidgets));
    }

    // Monthly: group entries by date like daily view
    Widget buildMonthlyContent(UserLyDatum data) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Grade: ${data.grade ?? "N/A"}"),
          Text("User Name: ${data.userName ?? "N/A"}"),
          data.createdAt != null
              ? Text(
                "Date: ${DateConverter.isoStringToLocalDateOnly(data.createdAt!)}",
              )
              : SizedBox(),
        ],
      );
    }

    // Group data by date (day)
    final Map<DateTime, List<UserLyDatum>> dateToItems = {};
    for (final item in userMonthlyData) {
      if (item.createdAt == null) continue;
      final dayKey = DateTime(
        item.createdAt!.year,
        item.createdAt!.month,
        item.createdAt!.day,
      );
      dateToItems.putIfAbsent(dayKey, () => []);
      dateToItems[dayKey]!.add(item);
    }

    // Sort dates (newest first)
    final List<DateTime> sortedDates =
        dateToItems.keys.toList()..sort((a, b) => b.compareTo(a));

    List<Widget> children = [];
    for (final date in sortedDates) {
      final List<UserLyDatum> dayEntries =
          dateToItems[date]!..sort((a, b) {
            final da = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
            final db = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
            return db.compareTo(da);
          });

      final String dateLabel = DateConverter.isoStringToLocalDateOnly(date);
      final bool isCurrentMonth = _bloc.isInCurrentMonth(date);

      // Create list of all entries for this date
      Widget entriesList = Column(
        children:
            dayEntries
                .map(
                  (data) => Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: ColorName.primary.withValues(alpha: 0.70),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    margin: EdgeInsets.only(bottom: 10),
                    child: buildMonthlyContent(data),
                  ),
                )
                .toList(),
      );

      if (isCurrentMonth) {
        // Current month's data - always expanded
        children.add(
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
                  child: Row(
                    children: [
                      Expanded(child: Text(dateLabel)),
                      Text(
                        "${dayEntries.length} entr${dayEntries.length == 1 ? 'y' : 'ies'}",
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: entriesList,
                ),
              ],
            ),
          ),
        );
      } else {
        // Past months - collapsible
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
                childrenPadding: EdgeInsets.only(bottom: 12, left: 8, right: 8),
                title: Row(
                  children: [
                    Expanded(child: Text(dateLabel)),
                    Text(
                      "${dayEntries.length} entr${dayEntries.length == 1 ? 'y' : 'ies'}",
                    ),
                  ],
                ),
                children: [entriesList],
                onExpansionChanged: (_) => _audioController.playerStop(),
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

    // Group data by date (day)
    final Map<DateTime, List<UserDailyDatum>> dateToItems = {};
    for (final item in userData) {
      if (item.createdAt == null) continue;
      final dayKey = DateTime(
        item.createdAt!.year,
        item.createdAt!.month,
        item.createdAt!.day,
      );
      dateToItems.putIfAbsent(dayKey, () => []);
      dateToItems[dayKey]!.add(item);
    }

    // Sort dates (newest first)
    final List<DateTime> sortedDates =
        dateToItems.keys.toList()..sort((a, b) => b.compareTo(a));

    List<Widget> children = [];
    for (final date in sortedDates) {
      final List<UserDailyDatum> dayEntries =
          dateToItems[date]!..sort((a, b) {
            final da = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
            final db = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
            return db.compareTo(da);
          });

      final String dateLabel = DateConverter.isoStringToLocalDateOnly(date);
      final bool isToday = _bloc.isSameDay(date, DateTime.now());

      // Create list of all entries for this date
      Widget entriesList = Column(
        children:
            dayEntries
                .map(
                  (data) => Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: ColorName.primary.withValues(alpha: 0.70),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    margin: EdgeInsets.only(bottom: 10),
                    child: buildDailyContent(data),
                  ),
                )
                .toList(),
      );

      if (isToday) {
        // Today's data - always expanded
        children.add(
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
                  child: Row(
                    children: [
                      Expanded(child: Text(dateLabel)),
                      Text(
                        "${dayEntries.length} entr${dayEntries.length == 1 ? 'y' : 'ies'}",
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: entriesList,
                ),
              ],
            ),
          ),
        );
      } else {
        // Past dates - collapsible
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
                childrenPadding: EdgeInsets.only(bottom: 12, left: 8, right: 8),
                title: Row(
                  children: [
                    Expanded(child: Text(dateLabel)),
                    Text(
                      "${dayEntries.length} entr${dayEntries.length == 1 ? 'y' : 'ies'}",
                    ),
                  ],
                ),
                children: [entriesList],
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
    print("${data?.data?.toJson()}  +++++++ daily data");
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
          buildPatientPopupMenu(
            onSelected: (String value) {
              if (value == 'add_patient') {
                Navigator.pushNamed(context, Onboarding.path);
              } else if (value == 'view_patients') {
                Navigator.pushNamed(context, Onboarding.path);
                print('View Patients selected');
              }
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
