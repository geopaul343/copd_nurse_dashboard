// To parse this JSON data, do
//
//     final patientCheckUpDataModel = patientCheckUpDataModelFromJson(jsonString);

import 'dart:convert';

PatientCheckUpDataModel patientCheckUpDataModelFromJson(String str) => PatientCheckUpDataModel.fromJson(json.decode(str));

String patientCheckUpDataModelToJson(PatientCheckUpDataModel data) => json.encode(data.toJson());

class PatientCheckUpDataModel {
  PatientCheckUpDataModelData? data;
  String? message;

  PatientCheckUpDataModel({
    this.data,
    this.message,
  });

  factory PatientCheckUpDataModel.fromJson(Map<String, dynamic> json) => PatientCheckUpDataModel(
    data: json["data"] == null ? null : PatientCheckUpDataModelData.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
  };
}

class PatientCheckUpDataModelData {
  List<UserDailyDatum>? userDailyData;
  List<UserLyDatum>? userMonthlyData;
  List<UserLyDatum>? userWeeklyData;

  PatientCheckUpDataModelData({
    this.userDailyData,
    this.userMonthlyData,
    this.userWeeklyData,
  });

  factory PatientCheckUpDataModelData.fromJson(Map<String, dynamic> json) => PatientCheckUpDataModelData(
    userDailyData: json["user_daily_data"] == null ? [] : List<UserDailyDatum>.from(json["user_daily_data"]!.map((x) => UserDailyDatum.fromJson(x))),
    userMonthlyData: json["user_monthly_data"] == null ? [] : List<UserLyDatum>.from(json["user_monthly_data"]!.map((x) => UserLyDatum.fromJson(x))),
    userWeeklyData: json["user_weekly_data"] == null ? [] : List<UserLyDatum>.from(json["user_weekly_data"]!.map((x) => UserLyDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user_daily_data": userDailyData == null ? [] : List<dynamic>.from(userDailyData!.map((x) => x.toJson())),
    "user_monthly_data": userMonthlyData == null ? [] : List<dynamic>.from(userMonthlyData!.map((x) => x.toJson())),
    "user_weekly_data": userWeeklyData == null ? [] : List<dynamic>.from(userWeeklyData!.map((x) => x.toJson())),
  };
}

class UserDailyDatum {
  DateTime? createdAt;
  UserDailyDatumData? data;
  String? isDailySubmitted;
  String? userId;
  String? userName;

  UserDailyDatum({
    this.createdAt,
    this.data,
    this.isDailySubmitted,
    this.userId,
    this.userName
  });

  factory UserDailyDatum.fromJson(Map<String, dynamic> json) => UserDailyDatum(
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    data: json["data"] == null ? null : UserDailyDatumData.fromJson(json["data"]),
    isDailySubmitted: json["is_daily_submitted"],
    userId: json["user_id"],
    userName: json["user_name"],
  );

  Map<String, dynamic> toJson() => {
    "created_at": createdAt?.toIso8601String(),
    "data": data?.toJson(),
    "is_daily_submitted": isDailySubmitted,
    "user_id": userId,
    "user_name": userName,
  };
}

class UserDailyDatumData {
  dynamic? breathing;
  bool? didShortWalk;
  bool? hasInhalerStock;
  List<LungSoundRecording>? lungSoundRecordings;
  String? phlegmChange;
  String? phlegmColor;
  String? regularInhalerReason;
  int? relieverPuffs;
  int? spo2;
  bool? tookRegularInhaler;
  bool? usedOxygenAsPrescribed;

  UserDailyDatumData({
    this.breathing,
    this.didShortWalk,
    this.hasInhalerStock,
    this.lungSoundRecordings,
    this.phlegmChange,
    this.phlegmColor,
    this.regularInhalerReason,
    this.relieverPuffs,
    this.spo2,
    this.tookRegularInhaler,
    this.usedOxygenAsPrescribed,
  });

  factory UserDailyDatumData.fromJson(Map<String, dynamic> json) => UserDailyDatumData(
    breathing: json["breathing"],
    didShortWalk: json["did_short_walk"],
    hasInhalerStock: json["has_inhaler_stock"],
    lungSoundRecordings: json["lung_sound_recordings"] == null ? [] : List<LungSoundRecording>.from(json["lung_sound_recordings"]!.map((x) => LungSoundRecording.fromJson(x))),
    phlegmChange: json["phlegm_change"],
    phlegmColor: json["phlegm_color"],
    regularInhalerReason: json["regular_inhaler_reason"],
    relieverPuffs: json["reliever_puffs"],
    spo2: json["spo2"],
    tookRegularInhaler: json["took_regular_inhaler"],
    usedOxygenAsPrescribed: json["used_oxygen_as_prescribed"],
  );

  Map<String, dynamic> toJson() => {
    "breathing": breathing,
    "did_short_walk": didShortWalk,
    "has_inhaler_stock": hasInhalerStock,
    "lung_sound_recordings": lungSoundRecordings == null ? [] : List<dynamic>.from(lungSoundRecordings!.map((x) => x.toJson())),
    "phlegm_change": phlegmChange,
    "phlegm_color": phlegmColor,
    "regular_inhaler_reason": regularInhalerReason,
    "reliever_puffs": relieverPuffs,
    "spo2": spo2,
    "took_regular_inhaler": tookRegularInhaler,
    "used_oxygen_as_prescribed": usedOxygenAsPrescribed,
  };
}

class LungSoundRecording {
  String? fileUri;
  int? index;
  String? lungPoint;
  int? timestamp;

  LungSoundRecording({
    this.fileUri,
    this.index,
    this.lungPoint,
    this.timestamp,
  });

  factory LungSoundRecording.fromJson(Map<String, dynamic> json) => LungSoundRecording(
    fileUri: json["file_uri"],
    index: json["index"],
    lungPoint: json["lung_point"],
    timestamp: json["timestamp"],
  );

  Map<String, dynamic> toJson() => {
    "file_uri": fileUri,
    "index": index,
    "lung_point": lungPoint,
    "timestamp": timestamp,
  };
}

class UserLyDatum {
  DateTime? createdAt;
  int? grade;
  bool? isMonthlySubmitted;
  String? userId;
  String? userName;
  String? isWeeklySubmitted;

  UserLyDatum({
    this.createdAt,
    this.grade,
    this.isMonthlySubmitted,
    this.userId,
    this.userName,
    this.isWeeklySubmitted,
  });

  factory UserLyDatum.fromJson(Map<String, dynamic> json) => UserLyDatum(
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    grade: json["grade"],
    userName: json["user_name"],
    isMonthlySubmitted: json["is_monthly_submitted"],
    userId: json["user_id"],
    isWeeklySubmitted: json["is_weekly_submitted"],
  );

  Map<String, dynamic> toJson() => {
    "created_at": createdAt?.toIso8601String(),
    "grade": grade,
    "user_name": userName,
    "is_monthly_submitted": isMonthlySubmitted,
    "user_id":userId,
    "is_weekly_submitted": isWeeklySubmitted,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
