
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:admin_dashboard/ui/nurse/screens/patient/patient_health_checkup_details_screen.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../data/nurse/model/nurse/search_user_model.dart';


class PatientDetailScreen extends StatefulWidget {
  static const String path = '/patients-detail';
  final PatientUser userDetail;
  const PatientDetailScreen({super.key, required this.userDetail});

  @override
  State<PatientDetailScreen> createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen> {

  @override
  void initState() {
    super.initState();
    print(widget.userDetail.name);
  }

  Widget _buildProfessionalHeader() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade700, Colors.blue.shade500],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Patient Avatar with Medical Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios)),
                Gap(MediaQuery.of(context).size.width / 3.5),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(Icons.person, size: 40, color: Colors.blue.shade700),
                ),
              ],
            ),
      Gap(16),

            // Patient Name
            Text(
              widget.userDetail.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Gap(8),

            // Patient ID
            Text(
              'Patient ID: ${widget.userDetail.id}',
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
            Gap(8),

            // Status Badge
            if (widget.userDetail.isUserActive != null)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color:
                      widget.userDetail.isUserActive!
                          ? Colors.green.withOpacity(0.2)
                          : Colors.orange.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color:
                        widget.userDetail.isUserActive!
                            ? Colors.green
                            : Colors.orange,
                    width: 1,
                  ),
                ),
                child: Text(
                  widget.userDetail.isUserActive! ? 'Active Patient' : 'Inactive',
                  style: TextStyle(
                    fontSize: 12,
                    color:
                        widget.userDetail.isUserActive!
                            ? Colors.green.shade100
                            : Colors.orange.shade100,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }



//
  Widget _buildQuickStatsSection() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Overview',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              widget.userDetail.hospitalAdmissionsLast12m == null ? SizedBox():   Expanded(
                child: _buildStatCard(
                  'Hospital Admissions',
                  '${widget.userDetail.hospitalAdmissionsLast12m ?? 0}',
                  'Last 12 months',
                  Icons.local_hospital,
                  Colors.red.shade100,
                  Colors.red.shade700,
                ),
              ),
              SizedBox(width: 12),
              widget.userDetail.copdDiagnosed ==  null? SizedBox(): Expanded(
                child: _buildStatCard(
                  'COPD Stage',
                  "${widget.userDetail.copdDiagnosed?["copdStage"] ?? "N/A"}",
                  'Current Stage',
                  Icons.medical_services,
                  Colors.orange.shade100,
                  Colors.orange.shade700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
//
  Widget _buildStatCard(
    String title,
    String value,
    String subtitle,
    IconData icon,
    Color bgColor,
    Color textColor,
  ) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: textColor.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: textColor, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Gap(8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(fontSize: 10, color: textColor.withOpacity(0.7)),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientDemographicsSection() {
    return _buildSection('Patient Demographics', Icons.person, [
      if (widget.userDetail.dateOfBirth != null)
        _buildInfoRow('Date of Birth', widget.userDetail.dateOfBirth??"N/A"),
      if (widget.userDetail.gender != null)
        _buildInfoRow('Gender', widget.userDetail.gender??"N/A"),
      if (widget.userDetail.email != null)
        _buildInfoRow('Email', widget.userDetail.email??"N/A"),
      if (widget.userDetail.phone != null)
        _buildInfoRow('Phone', widget.userDetail.phone??"N/A"),
      if (widget.userDetail.address != null)
        _buildInfoRow('Address', widget.userDetail.address??"N/A"),
    ]);
  }
//
  Widget _buildCOPDAssessmentSection() {
    List<Widget> assessmentItems = [];
    if (widget.userDetail.copdDiagnosed != null) {
      assessmentItems.add(_buildInfoRow('COPD Diagnosed', widget.userDetail.copdDiagnosed?["hasCOPD"].toString()??"N/A"));
    }
    if (widget.userDetail.copdDiagnosed?["copdStage"] != null) {
      assessmentItems.add(_buildInfoRow('COPD Stage', widget.userDetail.copdDiagnosed?["copdStage"]));
    }
    if (widget.userDetail.copdActionPlan?['hasCOPDActionPlan'] != null) {
      assessmentItems.add(_buildInfoRow('Action Plan', widget.userDetail.copdActionPlan?['hasCOPDActionPlan'] == true ? "Available" : "Not Available"));
    }

    if (assessmentItems.isEmpty) {
      return SizedBox.shrink();
    }

    return _buildSection(
      'COPD Assessment',
      Icons.medical_services,
      assessmentItems,
    );
  }


//
  Widget _buildMedicalEquipmentSection() {
    List<Widget> equipmentItems = [];

    if (widget.userDetail.doYouHavePulseOximeter != null) {
      equipmentItems.add(_buildInfoRow('Pulse Oximeter', _getPulseOximeterStatus()));
    }

    if (widget.userDetail.homeOxygenEnabled != null) {
      equipmentItems.add(_buildInfoRow('Home Oxygen', _getHomeOxygenStatus()));
    }

    if (widget.userDetail.isDoHaveDigitalStethoscope != null) {
      equipmentItems.add(
        _buildInfoRow(
          'Digital Stethoscope',
          widget.userDetail.isDoHaveDigitalStethoscope!,
        ),
      );
    }

    if (equipmentItems.isEmpty) {
      return SizedBox.shrink();
    }

    return _buildSection(
      'Medical Equipment & Monitoring',
      Icons.monitor_heart,
      equipmentItems,
    );
  }
//
  Widget _buildMedicationsSection() {
    List<Widget> medicationItems = [];


    if (widget.userDetail.inhalerType != null) {
      medicationItems.add(_buildInfoRow('Inhaler Type', _getInhalerInfo()));
    }

    if (widget.userDetail.rescuepackAtHome != null) {
      medicationItems.add(_buildInfoRow('Rescue Pack', widget.userDetail.rescuepackAtHome?['hasRescuePack']??false == true ? 'Available' : 'Not available'));
    }

    if (widget.userDetail.anyRecommends != null) {
      medicationItems.add(
        _buildInfoRow('Recommendations', widget.userDetail.anyRecommends!),
      );
    }

    if (medicationItems.isEmpty) {
      return SizedBox.shrink();
    }

    return _buildSection(
      'Medications & Treatment',
      Icons.medication,
      medicationItems,
    );
  }
//
  Widget _buildEmergencySection() {
    if (widget.userDetail.emergencyContactName == null ) {
      return SizedBox.shrink();
    }

    return _buildSection('Emergency Information', Icons.emergency, [
      _buildInfoRow('Emergency Contact', _getEmergencyContact()),
    ]);
  }
//
  Widget _buildVaccinationSection() {
    if (widget.userDetail.fluVaccinated == null) {
      return SizedBox.shrink();
    }

    return _buildSection('Vaccination & Prevention', Icons.vaccines, [
      _buildInfoRow('Flu Vaccination', _getVaccinationStatus()),
    ]);
  }
//
  Widget _buildLifestyleSection() {
    List<Widget> lifestyleItems = [];

    if (widget.userDetail.smokingStatus != null) {
      lifestyleItems.add(_buildInfoRow('Smoking Status', _getSmokingStatus()));
    }

    if (widget.userDetail.otherCondition != null) {
      lifestyleItems.add(_buildInfoRow('Other Conditions', _getOtherConditions()));
    }

    if (lifestyleItems.isEmpty) {
      return SizedBox.shrink();
    }

    return _buildSection(
      'Lifestyle & Risk Factors',
      Icons.smoking_rooms,
      lifestyleItems,
    );
  }
//
  Widget _buildSection(String title, IconData icon, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.blue.shade700, size: 20),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
            ),
          ),
        ],
      ),
    );
  }

  String _getPulseOximeterStatus(){
       final hasOximeter = widget.userDetail.doYouHavePulseOximeter?['ownsPulseOximeter'] ?? false == true;
        final lastLevel = widget.userDetail.doYouHavePulseOximeter?['lastOxygenLevel']??"N/A";
        return hasOximeter ? 'Yes (Last reading: $lastLevel%)' : 'No';
  }

  String _getHomeOxygenStatus() {
      final hasOxygen = widget.userDetail.homeOxygenEnabled?['hasHomeOxygen']??false == true;
        if (hasOxygen) {
          final liters = widget.userDetail
              .homeOxygenEnabled?['oxygenLitresPerMinute'];
          final hours = widget.userDetail
              .homeOxygenEnabled?['oxygenHoursPerDay'];
          return 'Yes (${liters}L/min, ${hours}hrs/day)';
        }else{
          return "N/A";
        }
  }

  String _getInhalerInfo() {
    final inhalers = widget.userDetail.inhalerType?['inhalers'] as List?;
            if (inhalers != null && inhalers.isNotEmpty) {
          final inhaler = inhalers.first;
          return '${inhaler['name']} (${inhaler['dosage']})';
        }else{
              return "N/A";
            }
  }

  String _getEmergencyContact() {
            final name = widget.userDetail.emergencyContactName?['emergencyContactName']??"N/A";
        final phone = widget.userDetail.emergencyContactName?['emergencyContactPhone']??"N/A";
        return '$name ($phone)';

  }

  String _getVaccinationStatus() {
            final vaccinations = widget.userDetail.fluVaccinated?['vaccinations'] as List?;
        if (vaccinations != null && vaccinations.isNotEmpty) {
          return vaccinations.join(', ');
        }else{
          return "N/A";
        }
  }

  String _getSmokingStatus() {
        final status = widget.userDetail.smokingStatus?['smokingStatus'];
        final cigarettes = widget.userDetail.smokingStatus?['cigarettesPerDay'];
        final years = widget.userDetail.smokingStatus?['smokingYears'];
        return '$status ($cigarettes cigs/day, $years years)';
  }

  String _getOtherConditions() {
            final conditions = widget.userDetail.otherCondition?['otherConditions'] as List?;
        final text = widget.userDetail.otherCondition?['otherConditionText'];
        if (conditions != null && conditions.isNotEmpty) {
          return '${conditions.join(', ')}${text != null ? ' - $text' : ''}';
        }else{
          return "N/A";
        }
  }

  Widget _checkHealthCheckData(){
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, PatientHealthCheckupDetailsScreen.path,arguments: widget.userDetail.id);
      },
      child: Center(child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ColorName.primary.withValues(alpha: 0.7)
        ),
        child: Text("check patient health data"),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:  SingleChildScrollView(
        child: Column(
          children: [
            // Professional Header Section
           _buildProfessionalHeader(),
             Gap(20),
             _checkHealthCheckData(),
             // Quick Stats Cards
            widget.userDetail.hospitalAdmissionsLast12m != null || widget.userDetail.copdDiagnosed !=  null ?_buildQuickStatsSection() : SizedBox(),
             // Patient Demographics
            _buildPatientDemographicsSection(),
            // COPD Assessment
             _buildCOPDAssessmentSection(),
            // Medical Equipment & Monitoring
            _buildMedicalEquipmentSection(),
            // Medications & Treatment
           _buildMedicationsSection(),
            // Emergency Information
            _buildEmergencySection(),
            // // Vaccination & Prevention
          _buildVaccinationSection(),
            // Lifestyle & Risk Factors
            _buildLifestyleSection(),
            SizedBox(height: 20),
          ],
        ),
      )
      );
  }
}