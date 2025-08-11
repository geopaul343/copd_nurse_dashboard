class SearchResponse {
  final String message;
  final String? nextPageToken;
  final List<PatientUser> users;
  final String? accessToken;

  SearchResponse({
    required this.message,
    this.nextPageToken,
    required this.users,
    this.accessToken,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    try {
      List<PatientUser> users = [];

      if (json['users'] != null) {
        final usersList = json['users'] as List<dynamic>?;
        if (usersList != null) {
          for (int i = 0; i < usersList.length; i++) {
            try {
              final user = PatientUser.fromJson(usersList[i] as Map<String, dynamic>);
              users.add(user);
            } catch (e) {
              print('❌ Error parsing user at index $i: $e');
              print('❌ User data: ${usersList[i]}');
            }
          }
        }
      }

      return SearchResponse(
        message: json['message'] ?? '',
        nextPageToken: json['next_page_token'],
        accessToken: json['access_token'],
        users: users,
      );
    } catch (e) {
      print('❌ Error parsing SearchResponse: $e');
      print('❌ JSON data: $json');
      return SearchResponse(
        message: json['message'] ?? 'Error parsing response',
        nextPageToken: json['next_page_token'],
        accessToken: json['access_token'],
        users: [],
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'next_page_token': nextPageToken,
      'access_token': accessToken,
      'users': users.map((user) => user.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'SearchResponse(message: $message, nextPageToken: $nextPageToken, users: ${users.length}, accessToken: ${accessToken != null ? "present" : "null"})';
  }
}

class PatientUser {
  final String id;
  final String name;
  final String? email;
  final String? phone;
  final String? address;
  final String? dateOfBirth;
  final String? gender;
  final Map<String, dynamic>? medicalHistory;
  final Map<String, dynamic>? vitalSigns;
  final String? lastVisit;
  final String? nextAppointment;
  final String? status;
  final bool? isUserActive;
  final String? anyRecommends;
  final Map<String, dynamic>? copdActionPlan;
  final Map<String, dynamic>? copdDiagnosed;
  final Map<String, dynamic>? doYouHavePulseOximeter;
  final Map<String, dynamic>? emergencyContactName;
  final Map<String, dynamic>? fluVaccinated;
  final Map<String, dynamic>? homeOxygenEnabled;
  final int? hospitalAdmissionsLast12m;
  final Map<String, dynamic>? inhalerType;
  final String? isDoHaveDigitalStethoscope;
  final bool? isFlareUpsNonHospital;
  final Map<String, dynamic>? otherCondition;
  final int? pageNumber;
  final Map<String, dynamic>? rescuepackAtHome;
  final Map<String, dynamic>? smokingStatus;
  final String? createdAt;
  final String? updatedAt;

  PatientUser({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.address,
    this.dateOfBirth,
    this.gender,
    this.medicalHistory,
    this.vitalSigns,
    this.lastVisit,
    this.nextAppointment,
    this.status,
    this.isUserActive,
    this.anyRecommends,
    this.copdActionPlan,
    this.copdDiagnosed,
    this.doYouHavePulseOximeter,
    this.emergencyContactName,
    this.fluVaccinated,
    this.homeOxygenEnabled,
    this.hospitalAdmissionsLast12m,
    this.inhalerType,
    this.isDoHaveDigitalStethoscope,
    this.isFlareUpsNonHospital,
    this.otherCondition,
    this.pageNumber,
    this.rescuepackAtHome,
    this.smokingStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory PatientUser.fromJson(Map<String, dynamic> json) {
    try {
      return PatientUser(
        id: json['user_id'] ?? json['id'] ?? '',
        name: json['name'] ?? '',
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        address: json['address'] as String?,
        dateOfBirth: json['dateofbirth'] ?? json['date_of_birth'] ?? json['dateOfBirth'],
        gender: json['gender'] as String?,
        medicalHistory: json['medical_history'] ?? json['medicalHistory'],
        vitalSigns: json['vital_signs'] ?? json['vitalSigns'],
        lastVisit: json['last_visit'] ?? json['lastVisit'],
        nextAppointment: json['next_appointment'] ?? json['nextAppointment'],
        status: json['status'] as String?,
        isUserActive: json['is_user_active'] as bool?,
        anyRecommends: json['any_recommends'] as String?,
        copdActionPlan: json['copd_action_plan'] as Map<String, dynamic>?, // Changed to Map
        copdDiagnosed: json['copd_diagnosed'] as Map<String, dynamic>?, // Changed to Map
        doYouHavePulseOximeter: json['do_you_have_pulse_oximeter'] as Map<String, dynamic>?, // Changed to Map
        emergencyContactName: json['emergency_contact_name'] as Map<String, dynamic>?, // Changed to Map
        fluVaccinated: json['flu_vaccinated'] as Map<String, dynamic>?, // Changed to Map
        homeOxygenEnabled: json['home_oxygen_enabled'] as Map<String, dynamic>?, // Changed to Map
        hospitalAdmissionsLast12m: json['hospital_admissions_last_12m'] as int?,
        inhalerType: json['inhaler_type'] as Map<String, dynamic>?, // Changed to Map
        isDoHaveDigitalStethoscope: json['is_do_have_digital_stethoscope'] as String?,
        isFlareUpsNonHospital: json['is_flare_ups_non_hospital'] as bool?,
        otherCondition: json['other_condition'] as Map<String, dynamic>?, // Changed to Map
        pageNumber: json['page_number'] as int?,
        rescuepackAtHome: json['rescuepack_at_home'] as Map<String, dynamic>?, // Changed to Map
        smokingStatus: json['smoking_status'] as Map<String, dynamic>?, // Changed to Map
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
      );
    } catch (e) {
      print('❌ Error parsing PatientUser from JSON: $e');
      print('❌ JSON data: $json');
      return PatientUser(
        id: json['user_id'] ?? json['id'] ?? 'unknown',
        name: json['name'] ?? 'Unknown Patient',
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        address: json['address'] as String?,
        dateOfBirth: json['dateofbirth'] ?? json['date_of_birth'] ?? json['dateOfBirth'],
        gender: json['gender'] as String?,
        medicalHistory: json['medical_history'] ?? json['medicalHistory'],
        vitalSigns: json['vital_signs'] ?? json['vitalSigns'],
        lastVisit: json['last_visit'] ?? json['lastVisit'],
        nextAppointment: json['next_appointment'] ?? json['nextAppointment'],
        status: json['status'] as String?,
        isUserActive: json['is_user_active'] as bool?,
        anyRecommends: json['any_recommends'] as String?,
        copdActionPlan: json['copd_action_plan'] as Map<String, dynamic>?, // Changed to Map
        copdDiagnosed: json['copd_diagnosed'] as Map<String, dynamic>?, // Changed to Map
        doYouHavePulseOximeter: json['do_you_have_pulse_oximeter'] as Map<String, dynamic>?, // Changed to Map
        emergencyContactName: json['emergency_contact_name'] as Map<String, dynamic>?, // Changed to Map
        fluVaccinated: json['flu_vaccinated'] as Map<String, dynamic>?, // Changed to Map
        homeOxygenEnabled: json['home_oxygen_enabled'] as Map<String, dynamic>?, // Changed to Map
        hospitalAdmissionsLast12m: json['hospital_admissions_last_12m'] as int?,
        inhalerType: json['inhaler_type'] as Map<String, dynamic>?, // Changed to Map
        isDoHaveDigitalStethoscope: json['is_do_have_digital_stethoscope'] as String?,
        isFlareUpsNonHospital: json['is_flare_ups_non_hospital'] as bool?,
        otherCondition: json['other_condition'] as Map<String, dynamic>?, // Changed to Map
        rescuepackAtHome: json['rescuepack_at_home'] as Map<String, dynamic>?, // Changed to Map
        smokingStatus: json['smoking_status'] as Map<String, dynamic>?, // Changed to Map
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'dateofbirth': dateOfBirth,
      'gender': gender,
      'medical_history': medicalHistory,
      'vital_signs': vitalSigns,
      'last_visit': lastVisit,
      'next_appointment': nextAppointment,
      'status': status,
      'is_user_active': isUserActive,
      'any_recommends': anyRecommends,
      'copd_action_plan': copdActionPlan,
      'copd_diagnosed': copdDiagnosed,
      'do_you_have_pulse_oximeter': doYouHavePulseOximeter,
      'emergency_contact_name': emergencyContactName,
      'flu_vaccinated': fluVaccinated,
      'home_oxygen_enabled': homeOxygenEnabled,
      'hospital_admissions_last_12m': hospitalAdmissionsLast12m,
      'inhaler_type': inhalerType,
      'is_do_have_digital_stethoscope': isDoHaveDigitalStethoscope,
      'is_flare_ups_non_hospital': isFlareUpsNonHospital,
      'other_condition': otherCondition,
      'page_number': pageNumber,
      'rescuepack_at_home': rescuepackAtHome,
      'smoking_status': smokingStatus,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  @override
  String toString() {
    return 'PatientUser(id: $id, name: $name, email: $email, status: $status)';
  }
}