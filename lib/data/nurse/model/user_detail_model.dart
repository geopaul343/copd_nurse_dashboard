
class UserDetails{
  String? userToken;
  String? userId;
  String? userEmail;
  String? userName;

  UserDetails({this.userToken, this.userEmail, this.userId, this.userName});

  Map<String, dynamic> toJson() {
    return {
      'userToken': userToken,
      'userId': userId,
      'userEmail': userEmail,
      'userName': userName,
    };
  }

  // Create UserDetails from a Map (JSON decoding)
  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      userToken: json['userToken'],
      userId: json['userId'],
      userEmail: json['userEmail'],
      userName: json['userName'],
    );
  }
}