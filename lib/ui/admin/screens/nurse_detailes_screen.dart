import 'package:flutter/material.dart';
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:admin_dashboard/ui/nurse/widgets/custom_text.dart';
import 'package:gap/gap.dart';
import '../../../data/nurse/model/admin/admin_patients_list_model.dart';
import '../../../data/nurse/model/admin/nurse_list_model.dart';
import '../bloc/admin_bloc.dart';
import 'pateint_list_toadd_nurse_screen.dart'; // import

class NurseDetailesScreen extends StatefulWidget {
  static const String path = '/nurse-details';
  final NursesList nurse;

  const NurseDetailesScreen({super.key, required this.nurse});

  @override
  State<NurseDetailesScreen> createState() => _NurseDetailesScreenState();
}

class _NurseDetailesScreenState extends State<NurseDetailesScreen> {
  List<Map<String, String>> assignedPatients = [];

  final AdminBloc _bloc = AdminBloc();

@override
  void initState() {
    super.initState();
    callApi();
  }

  callApi()async{
  await _bloc.getPatientsByNurseId(nurseId:widget.nurse.userId??"");
  }

  Widget _nurseDetailView(){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 70,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorName.primary,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: ColorName.white,
                child: Icon(Icons.person, color: ColorName.primary, size: 30),
              ),
              Gap(10),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   Text(
                      widget.nurse.userName??"",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: ColorName.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                       "Nurse ID: ${widget.nurse.userId}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: ColorName.white,
                        fontWeight: FontWeight.normal,
                      ),

                    ),
                  ],
                ),
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios, color: ColorName.white, size: 20),
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.nurse.userName??""

        ),
        backgroundColor: Colors.blue.shade700,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () async {
             final result = await Navigator.pushNamed(
                context,
                PatientListToAddNurse.path,
                arguments: widget.nurse.userId??""
              );
              if (result == true) {
                callApi();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _nurseDetailView(),
            CustomText(
              text: "Assigned Patients",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
        Expanded(
          child: StreamBuilder<List<AdminPatientsListModel>>(
            stream: _bloc.nurseAssignedPatientsListStream,
            builder: (context, snapshot) {
              switch(snapshot.connectionState){
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                case ConnectionState.active:
                case ConnectionState.done:
                  if(snapshot.hasError){
                    return Center(child: Text(snapshot.error.toString()),);
                  }
                  return snapshot.data?.isEmpty == true ? Center(child: Text("Currently No patients Are Available"),)
                      :ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data?.length??0,
                    itemBuilder: (context, index) {
                      final patient = snapshot.data?[index];
                      return Card(
                        child: ListTile(
                          title: Text(patient?.userName??""),
                          subtitle: Text('Dob: ${patient?.userDob??""}'),
                        ),
                      );
                    },
                  );
                default:
                  return Container();
              }
            }
            ),
        )
          ],
        ),
      ),
    );
  }
}
