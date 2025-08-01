import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../data/model/patient_checkup_data_model.dart';
import '../../bloc/dashboard_bloc.dart';

class PatientHealthCheckupDetailsScreen extends StatefulWidget {
  static const String path = '/patient-health-checkup';
  final String patientId;
  const PatientHealthCheckupDetailsScreen({super.key, required this.patientId});

  @override
  State<PatientHealthCheckupDetailsScreen> createState() => _PatientHealthCheckupDetailsScreenState();
}

class _PatientHealthCheckupDetailsScreenState extends State<PatientHealthCheckupDetailsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final DashboardBloc _bloc = DashboardBloc();


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    callPatientDetailApi();
  }

  callPatientDetailApi()async{
    _bloc.getPatientCheckUpData(patientId: widget.patientId);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _tabBarView(){
    return TabBar(
      controller: _tabController,
      tabs: [
        Tab(icon: Icon(Icons.today), text: 'Daily'),
        Tab(icon: Icon(Icons.weekend), text: 'Weekly'),
        Tab(icon: Icon(Icons.calendar_month), text: 'Monthly'),
      ],
      indicator: BoxDecoration(
        color: Colors.blue.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8.0),
      ),
      labelPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
    );
  }


  Widget _monthlyAndWeeklyView(List<UserLyDatum>? userMonthlyData){
    return userMonthlyData == null ? Center(child: Text("No Details Found!"),):SingleChildScrollView(
      child: Column(children: userMonthlyData.map((data) =>
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ColorName.primary.withValues(alpha: 0.70)
        ),
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Text("Grade ${data.grade}")
          ],
        ),
      )).toList(),),
    );
  }

  Widget _dailyView(List<UserDailyDatum>? userData){
    return userData == null ? Center(child: Text("No Details Found!"),):SingleChildScrollView(
      child: Column(children: userData.map((data) =>
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: ColorName.primary.withValues(alpha: 0.70)
            ),
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
            margin: EdgeInsets.only(bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Breathing: ${data.data?.breathing}"),
                Text("DidShortWalk ${data.data?.didShortWalk == true ? "Available" : "Not Available"}"),
                Text("HasInhalerStock ${data.data?.hasInhalerStock== true ? "Available" : "Not Available"}"),
                Text("PhlegmChange ${data.data?.phlegmChange}"),
                Text("PhlegmColor ${data.data?.phlegmColor}"),
                Text("RelieverPuffs ${data.data?.relieverPuffs}"),
                Text("spo2 ${data.data?.spo2}"),
                Text("TookRegularInhaler ${data.data?.tookRegularInhaler == true ? "Available" : "Not Available"}"),
                Text("UsedOxygenAsPrescribed ${data.data?.usedOxygenAsPrescribed == true ? "Available" : "Not Available"}"),
                if(data.data?.lungSoundFiles != null) ...[
                Text("Audios "),

                Row(
                    children:
                    data.data!.lungSoundFiles!.map((audio) =>
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: ColorName.white,
                      ),
                    )).toList()
                )
                ]
              ],
            ),
          )).toList(),),
    );
  }


  Widget _tabBarContentView(PatientCheckUpDataModel? data){
    return TabBarView(
    controller: _tabController,
    children: [
      // Content for Daily Tab
      _dailyView(data?.data?.userDailyData),
      // Content for Weekly Tab
      _monthlyAndWeeklyView(data?.data?.userWeeklyData),
      // Content for Monthly Tab
      _monthlyAndWeeklyView(data?.data?.userMonthlyData),
    ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Health data"),),
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
                Expanded(child:
                _tabBarContentView(snapshot.data)
                )
              ],
            )
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
