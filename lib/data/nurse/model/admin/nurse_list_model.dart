// To parse this JSON data, do
//
//     final nurseDetailModel = nurseDetailModelFromJson(jsonString);

import 'dart:convert';

NurseDetailModel nurseDetailModelFromJson(String str) => NurseDetailModel.fromJson(json.decode(str));

String nurseDetailModelToJson(NurseDetailModel data) => json.encode(data.toJson());

class NurseDetailModel {
  List<NursesList>? users;

  NurseDetailModel({
    this.users,
  });

  factory NurseDetailModel.fromJson(Map<String, dynamic> json) => NurseDetailModel(
    users: json["users"] == null ? [] : List<NursesList>.from(json["users"]!.map((x) => NursesList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x.toJson())),
  };
}

class NursesList {
  String? email;
  String? userId;
  String? userName;
  int? userType;

  NursesList({
    this.email,
    this.userId,
    this.userName,
    this.userType,
  });

  factory NursesList.fromJson(Map<String, dynamic> json) => NursesList(
    email: json["email"],
    userId: json["user_id"],
    userName: json["user_name"],
    userType: json["user_type"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "user_id": userId,
    "user_name": userName,
    "user_type": userType,
  };
}
