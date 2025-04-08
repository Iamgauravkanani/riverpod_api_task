class UserModel{
  String? firstName;
  String? lastName;
  String? message;

  UserModel({this.firstName, this.lastName, this.message});

  UserModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    message = json['message'];
  }
}