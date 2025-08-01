import 'dart:convert';

import 'package:admin_dashboard/data/model/search_user_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
            SizedBox(height: 16),

            // Patient Name
            Text(
              widget.userDetail.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),

            // Patient ID
            Text(
              'Patient ID: ${widget.userDetail.id}',
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
            SizedBox(height: 8),

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
              Expanded(
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
              Expanded(
                child: _buildStatCard(
                  'COPD Stage',
                  removeSlash(text: widget.userDetail.copdDiagnosed,returnText: 'copdStage'),
                 // _getCOPDStage(),
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
          SizedBox(height: 8),
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
        _buildInfoRow('Date of Birth', widget.userDetail.dateOfBirth!),
      if (widget.userDetail.gender != null)
        _buildInfoRow('Gender', widget.userDetail.gender!),
      if (widget.userDetail.email != null)
        _buildInfoRow('Email', widget.userDetail.email!),
      if (widget.userDetail.phone != null)
        _buildInfoRow('Phone', widget.userDetail.phone!),
      if (widget.userDetail.address != null)
        _buildInfoRow('Address', widget.userDetail.address!),
    ]);
  }

  Widget _buildCOPDAssessmentSection() {
    List<Widget> assessmentItems = [];

    final copdDiagnosis = _getCOPDDiagnosis();
    if (copdDiagnosis != 'Not specified') {
      assessmentItems.add(_buildInfoRow('COPD Diagnosed', copdDiagnosis));
    }

    final copdStage = _getCOPDStage();
    if (copdStage != 'Not specified') {
      assessmentItems.add(_buildInfoRow('COPD Stage', copdStage));
    }

    final actionPlan = _getActionPlanStatus();
    if (actionPlan != 'Not specified') {
      assessmentItems.add(_buildInfoRow('Action Plan', actionPlan));
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

  Widget _buildMedicalEquipmentSection() {
    List<Widget> equipmentItems = [];

    final pulseOximeter = _getPulseOximeterStatus();
    if (pulseOximeter != 'Not specified') {
      equipmentItems.add(_buildInfoRow('Pulse Oximeter', pulseOximeter));
    }

    final homeOxygen = _getHomeOxygenStatus();
    if (homeOxygen != 'Not specified') {
      equipmentItems.add(_buildInfoRow('Home Oxygen', homeOxygen));
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

  Widget _buildMedicationsSection() {
    List<Widget> medicationItems = [];

    final inhaler = _getInhalerInfo();
    if (inhaler != 'Not specified') {
      medicationItems.add(_buildInfoRow('Inhaler Type', inhaler));
    }

    final rescuePack = _getRescuePackStatus();
    if (rescuePack != 'Not specified') {
      medicationItems.add(_buildInfoRow('Rescue Pack', rescuePack));
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

  Widget _buildEmergencySection() {
    final emergencyContact = _getEmergencyContact();
    if (emergencyContact == 'Not specified') {
      return SizedBox.shrink();
    }

    return _buildSection('Emergency Information', Icons.emergency, [
      _buildInfoRow('Emergency Contact', emergencyContact),
    ]);
  }

  Widget _buildVaccinationSection() {
    final vaccination = _getVaccinationStatus();
    if (vaccination == 'Not specified') {
      return SizedBox.shrink();
    }

    return _buildSection('Vaccination & Prevention', Icons.vaccines, [
      _buildInfoRow('Flu Vaccination', vaccination),
    ]);
  }

  Widget _buildLifestyleSection() {
    List<Widget> lifestyleItems = [];

    final smokingStatus = _getSmokingStatus();
    if (smokingStatus != 'Not specified') {
      lifestyleItems.add(_buildInfoRow('Smoking Status', smokingStatus));
    }

    final otherConditions = _getOtherConditions();
    if (otherConditions != 'Not specified') {
      lifestyleItems.add(_buildInfoRow('Other Conditions', otherConditions));
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

  // Helper methods to parse JSON data
  String _getCOPDDiagnosis() {
    try {
      if (widget.userDetail.copdDiagnosed != null) {
        print('🔍 COPD Diagnosed raw data: ${widget.userDetail.copdDiagnosed}');
        // Handle the double-quoted JSON string
        String jsonString = widget.userDetail.copdDiagnosed!;
        // Remove outer quotes if present
        if (jsonString.startsWith('"') && jsonString.endsWith('"')) {
          jsonString = jsonString.substring(1, jsonString.length - 1);
        }
        // Unescape the JSON
        jsonString = jsonString.replaceAll('\\"', '"');
        final data = json.decode(jsonString);
        print('🔍 COPD Diagnosed parsed: $data');
        return data['hasCOPD'] == true ? 'Yes' : 'No';
      }
    } catch (e) {
      print('Error parsing COPD diagnosis: $e');
    }
    return 'Not specified';
  }


String removeSlash({required String? text, required String? returnText}){
  try {
      if (text != null) {
        print('🔍 COPD Stage raw data: ${text}');
        // Handle the double-quoted JSON string
        String jsonString = text;
        // Remove outer quotes if present
        if (jsonString.startsWith('"') && jsonString.endsWith('"')) {
          jsonString = jsonString.substring(1, jsonString.length - 1);
        }
        // Unescape the JSON
        jsonString = jsonString.replaceAll('\\"', '"');
        final data = json.decode(jsonString);
        print('🔍 COPD Stage parsed: $data');
        return data[returnText] ?? 'Not specified';
      }
    } catch (e) {
      print('Error parsing COPD stage: $e');
    }
    return 'Not specified';
}

  String _getCOPDStage() {
    try {
      if (widget.userDetail.copdDiagnosed != null) {
        print('🔍 COPD Stage raw data: ${widget.userDetail.copdDiagnosed}');
        // Handle the double-quoted JSON string
        String jsonString = widget.userDetail.copdDiagnosed!;
        // Remove outer quotes if present
        if (jsonString.startsWith('"') && jsonString.endsWith('"')) {
          jsonString = jsonString.substring(1, jsonString.length - 1);
        }
        // Unescape the JSON
        jsonString = jsonString.replaceAll('\\"', '"');
        final data = json.decode(jsonString);
        print('🔍 COPD Stage parsed: $data');
        return data['copdStage'] ?? 'Not specified';
      }
    } catch (e) {
      print('Error parsing COPD stage: $e');
    }
    return 'Not specified';
  }

  String _getActionPlanStatus() {
    try {
      if (widget.userDetail.copdActionPlan != null) {
        print('🔍 Action Plan raw data: ${widget.userDetail.copdActionPlan}');
        // Handle the double-quoted JSON string
        String jsonString = widget.userDetail.copdActionPlan!;
        // Remove outer quotes if present
        if (jsonString.startsWith('"') && jsonString.endsWith('"')) {
          jsonString = jsonString.substring(1, jsonString.length - 1);
        }
        // Unescape the JSON
        jsonString = jsonString.replaceAll('\\"', '"');
        final data = json.decode(jsonString);
        print('🔍 Action Plan parsed: $data');
        return data['hasCOPDActionPlan'] == true
            ? 'Available'
            : 'Not available';
      }
    } catch (e) {
      print('Error parsing action plan: $e');
    }
    return 'Not specified';
  }

  String _getPulseOximeterStatus() {
    try {
      if (widget.userDetail.doYouHavePulseOximeter != null) {
        print(
          '🔍 Pulse Oximeter raw data: ${widget.userDetail.doYouHavePulseOximeter}',
        );
        // Handle the double-quoted JSON string
        String jsonString = widget.userDetail.doYouHavePulseOximeter!;
        // Remove outer quotes if present
        if (jsonString.startsWith('"') && jsonString.endsWith('"')) {
          jsonString = jsonString.substring(1, jsonString.length - 1);
        }
        // Unescape the JSON
        jsonString = jsonString.replaceAll('\\"', '"');
        final data = json.decode(jsonString);
        print('🔍 Pulse Oximeter parsed: $data');
        final hasOximeter = data['ownsPulseOximeter'] == true;
        final lastLevel = data['lastOxygenLevel'];
        return hasOximeter ? 'Yes (Last reading: $lastLevel%)' : 'No';
      }
    } catch (e) {
      print('Error parsing pulse oximeter: $e');
    }
    return 'Not specified';
  }

  String _getHomeOxygenStatus() {
    try {
      if (widget.userDetail.homeOxygenEnabled != null) {
        print('🔍 Home Oxygen raw data: ${widget.userDetail.homeOxygenEnabled}');
        // Handle the double-quoted JSON string
        String jsonString = widget.userDetail.homeOxygenEnabled!;
        // Remove outer quotes if present
        if (jsonString.startsWith('"') && jsonString.endsWith('"')) {
          jsonString = jsonString.substring(1, jsonString.length - 1);
        }
        // Unescape the JSON
        jsonString = jsonString.replaceAll('\\"', '"');
        final data = json.decode(jsonString);
        print('🔍 Home Oxygen parsed: $data');
        final hasOxygen = data['hasHomeOxygen'] == true;
        if (hasOxygen) {
          final liters = data['oxygenLitresPerMinute'];
          final hours = data['oxygenHoursPerDay'];
          return 'Yes (${liters}L/min, ${hours}hrs/day)';
        }
        return 'No';
      }
    } catch (e) {
      print('Error parsing home oxygen: $e');
    }
    return 'Not specified';
  }

  String _getStethoscopeStatus() {
    print(
      '🔍 Stethoscope raw data: ${widget.userDetail.isDoHaveDigitalStethoscope}',
    );
    return widget.userDetail.isDoHaveDigitalStethoscope ?? 'Not specified';
  }

  String _getInhalerInfo() {
    try {
      if (widget.userDetail.inhalerType != null) {
        print('🔍 Inhaler raw data: ${widget.userDetail.inhalerType}');
        // Handle the double-quoted JSON string
        String jsonString = widget.userDetail.inhalerType!;
        // Remove outer quotes if present
        if (jsonString.startsWith('"') && jsonString.endsWith('"')) {
          jsonString = jsonString.substring(1, jsonString.length - 1);
        }
        // Unescape the JSON
        jsonString = jsonString.replaceAll('\\"', '"');
        final data = json.decode(jsonString);
        print('🔍 Inhaler parsed: $data');
        final inhalers = data['inhalers'] as List?;
        if (inhalers != null && inhalers.isNotEmpty) {
          final inhaler = inhalers.first;
          return '${inhaler['name']} (${inhaler['dosage']})';
        }
      }
    } catch (e) {
      print('Error parsing inhaler: $e');
    }
    return 'Not specified';
  }

  String _getRescuePackStatus() {
    try {
      if (widget.userDetail.rescuepackAtHome != null) {
        print('🔍 Rescue Pack raw data: ${widget.userDetail.rescuepackAtHome}');
        // Handle the double-quoted JSON string
        String jsonString = widget.userDetail.rescuepackAtHome!;
        // Remove outer quotes if present
        if (jsonString.startsWith('"') && jsonString.endsWith('"')) {
          jsonString = jsonString.substring(1, jsonString.length - 1);
        }
        // Unescape the JSON
        jsonString = jsonString.replaceAll('\\"', '"');
        final data = json.decode(jsonString);
        print('🔍 Rescue Pack parsed: $data');
        return data['hasRescuePack'] == true ? 'Available' : 'Not available';
      }
    } catch (e) {
      print('Error parsing rescue pack: $e');
    }
    return 'Not specified';
  }

  String _getEmergencyContact() {
    try {
      if (widget.userDetail.emergencyContactName != null) {
        print(
          '🔍 Emergency Contact raw data: ${widget.userDetail.emergencyContactName}',
        );
        // Handle the double-quoted JSON string
        String jsonString = widget.userDetail.emergencyContactName!;
        // Remove outer quotes if present
        if (jsonString.startsWith('"') && jsonString.endsWith('"')) {
          jsonString = jsonString.substring(1, jsonString.length - 1);
        }
        // Unescape the JSON
        jsonString = jsonString.replaceAll('\\"', '"');
        final data = json.decode(jsonString);
        print('🔍 Emergency Contact parsed: $data');
        final name = data['emergencyContactName'];
        final phone = data['emergencyContactPhone'];
        return '$name ($phone)';
      }
    } catch (e) {
      print('Error parsing emergency contact: $e');
    }
    return 'Not specified';
  }

  String _getVaccinationStatus() {
    try {
      if (widget.userDetail.fluVaccinated != null) {
        print('🔍 Vaccination raw data: ${widget.userDetail.fluVaccinated}');
        // Handle the double-quoted JSON string
        String jsonString = widget.userDetail.fluVaccinated!;
        // Remove outer quotes if present
        if (jsonString.startsWith('"') && jsonString.endsWith('"')) {
          jsonString = jsonString.substring(1, jsonString.length - 1);
        }
        // Unescape the JSON
        jsonString = jsonString.replaceAll('\\"', '"');
        final data = json.decode(jsonString);
        print('🔍 Vaccination parsed: $data');
        final vaccinations = data['vaccinations'] as List?;
        if (vaccinations != null && vaccinations.isNotEmpty) {
          return vaccinations.join(', ');
        }
      }
    } catch (e) {
      print('Error parsing vaccination: $e');
    }
    return 'Not specified';
  }

  String _getSmokingStatus() {
    try {
      if (widget.userDetail.smokingStatus != null) {
        print('🔍 Smoking Status raw data: ${widget.userDetail.smokingStatus}');
        // Handle the double-quoted JSON string
        String jsonString = widget.userDetail.smokingStatus!;
        // Remove outer quotes if present
        if (jsonString.startsWith('"') && jsonString.endsWith('"')) {
          jsonString = jsonString.substring(1, jsonString.length - 1);
        }
        // Unescape the JSON
        jsonString = jsonString.replaceAll('\\"', '"');
        final data = json.decode(jsonString);
        print('🔍 Smoking Status parsed: $data');
        final status = data['smokingStatus'];
        final cigarettes = data['cigarettesPerDay'];
        final years = data['smokingYears'];
        return '$status ($cigarettes cigs/day, $years years)';
      }
    } catch (e) {
      print('Error parsing smoking status: $e');
    }
    return 'Not specified';
  }

  String _getOtherConditions() {
    try {
      if (widget.userDetail.otherCondition != null) {
        print('🔍 Other Conditions raw data: ${widget.userDetail.otherCondition}');
        // Handle the double-quoted JSON string
        String jsonString = widget.userDetail.otherCondition!;
        // Remove outer quotes if present
        if (jsonString.startsWith('"') && jsonString.endsWith('"')) {
          jsonString = jsonString.substring(1, jsonString.length - 1);
        }
        // Unescape the JSON
        jsonString = jsonString.replaceAll('\\"', '"');
        final data = json.decode(jsonString);
        print('🔍 Other Conditions parsed: $data');
        final conditions = data['otherConditions'] as List?;
        final text = data['otherConditionText'];
        if (conditions != null && conditions.isNotEmpty) {
          return '${conditions.join(', ')}${text != null ? ' - $text' : ''}';
        }
      }
    } catch (e) {
      print('Error parsing other conditions: $e');
    }
    return 'Not specified';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:  SingleChildScrollView(
        child: Column(
          children: [
            // Professional Header Section
            _buildProfessionalHeader(),

            // Quick Stats Cards
            _buildQuickStatsSection(),

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

            // Vaccination & Prevention
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