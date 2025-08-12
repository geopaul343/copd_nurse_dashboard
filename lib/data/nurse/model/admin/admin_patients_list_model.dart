// To parse this JSON data, do
//
//     final adminPatientsListModel = adminPatientsListModelFromJson(jsonString);

import 'dart:convert';

List<AdminPatientsListModel> adminPatientsListModelFromJson(String str) => List<AdminPatientsListModel>.from(json.decode(str).map((x) => AdminPatientsListModel.fromJson(x)));

String adminPatientsListModelToJson(List<AdminPatientsListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdminPatientsListModel {
  String? email;
  String? userId;
  String? userName;
  String? userDob;
  String? nurseId;
  bool isSelect;

  AdminPatientsListModel({
    this.email,
    this.userId,
    this.userName,
    this.userDob,
    this.nurseId,
    this.isSelect = false
  });

  factory AdminPatientsListModel.fromJson(Map<String, dynamic> json) => AdminPatientsListModel(
    email: json["email"],
    userId: json["user_id"],
    userName: json["user_name"],
    userDob: json["user_dob"],
    nurseId: json["nurse_id"]
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "user_id": userId,
    "user_name": userName,
    "user_dob": userDob,
    "nurse_id": nurseId
  };
}
