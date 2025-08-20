import 'package:admin_dashboard/app/helper/date_helper.dart';
import 'package:admin_dashboard/data/nurse/model/nurse/patient_checkup_data_model.dart';

import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:admin_dashboard/ui/nurse/bloc/dashboard_bloc.dart';
import 'package:admin_dashboard/ui/nurse/screens/patient/widget/daily_view.dart';
import 'package:admin_dashboard/ui/nurse/screens/patient/widget/monthly_and_weekly_view.dart';
import 'package:admin_dashboard/ui/screens/onBoarding/onBoarding.dart';

import 'package:admin_dashboard/ui/widgets/custom_audio_player.dart';
import 'package:admin_dashboard/ui/widgets/custom_popup.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

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

  Widget _tabBarContentView(PatientCheckUpDataModel? data) {
    return TabBarView(
      controller: _tabController,
      children: [
        DailyViewWidget(userDailyData: data?.data?.userDailyData??[],
        audioController: _audioController,),
        // Content for Weekly Tab
        MonthlyAndWeeklyViewWidget(
         userMonthlyData: data?.data?.userWeeklyData,
         type: MonthlyAndWeeklyType.week,
        ),
        MonthlyAndWeeklyViewWidget(
          userMonthlyData: data?.data?.userMonthlyData,
          type:MonthlyAndWeeklyType.month,
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





