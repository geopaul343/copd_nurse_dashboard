import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../data/nurse/model/admin/admin_patients_list_model.dart';
import '../bloc/admin_bloc.dart';

class PatientListToAddNurse extends StatefulWidget {
  static const String path = '/patient-list-to-add-nurse';
  final String? nurseId;
  const PatientListToAddNurse({super.key,this.nurseId});

  @override
  State<PatientListToAddNurse> createState() => _PatientListToAddNurseState();
}

class _PatientListToAddNurseState extends State<PatientListToAddNurse> {


  final AdminBloc _bloc = AdminBloc();

    bool isLoading = false;

  @override
  void initState() {
    super.initState();
    callApi();
  }

  callApi()async{
    await _bloc.getAllPatients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Patients")),

      body: StreamBuilder<List<AdminPatientsListModel>>(
        stream: _bloc.nursePatientsListStream,
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              if(snapshot.hasError){
                return Center(child: Text(snapshot.error.toString()),);
              }
              return ListView.builder(
                itemCount: snapshot.data?.length??0,
                itemBuilder: (context, index) {
                  final patient = snapshot.data?[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(patient?.userName??""),
                              Text('Dob: ${patient?.userDob??""}')
                            ],
                          ),
                          Spacer(),
                          patient?.nurseId == null?Checkbox(
                            value: patient?.isSelect,
                            onChanged: (bool? value) {
                              setState(() {
                                patient!.isSelect = !patient.isSelect;
                              });
                            },
                          ):Container(),
                        ],
                      ),
                    )
                  );
                },
              );
            default:
              return Container();
          }
        }
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GestureDetector(
          onTap: ()async{
            final selectedUsers = _bloc.patientListByNurseId
                .where((patient) => patient.isSelect && patient.userId != null)
                .map((patient) => patient.userId!)
                .toList();
            if(_bloc.isSetPatientToNurse(userIds: selectedUsers)){
              isLoading = true;
              setState(() {});
              await _bloc.setPatientToNurse(nurseId: widget.nurseId??"", userIds:selectedUsers);
              isLoading = false;
              setState(() {});
            }
          },
            child: Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.blue
              ),
              child: isLoading ? Center(child: CircularProgressIndicator(color: Colors.white,)) :Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Text(
                    "Add Selected Patients (${_bloc.patientListByNurseId.where((test) => test.isSelect??false).length})",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ))
      ),
    );
  }
}
