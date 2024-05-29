// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
class Account {
  String? account_id;
  int? roleID;
  int departmentID;
  String first_name;
  String last_name;
  String email;
  String? password;
  int? approve;
  String? departmentName;
  String? image;
  String? schoolName;
  String? token;
  String? message;
  Account({
    this.account_id,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.departmentID,
    this.password,
    this.roleID,
    this.approve,
    this.departmentName,
    this.image,
    this.schoolName,
    this.token,
    this.message,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        account_id: json['account_id'] as String,
        roleID: json['roleID'] as int,
        departmentID: json['departmentID'] as int,
        first_name: json['first_name'] as String,
        last_name: json['last_name'] as String,
        email: json['email'] as String,
        // password: json['password'] as String,
        departmentName: json['departmentName'] as String,
        schoolName: json['schoolName'] as String,
        // ignore: unnecessary_null_in_if_null_operators, prefer_if_null_operators
        // approve: json['approve'] as int,
        image: json['image'] as String,
      );
  factory Account.fromJsonFetchByID(Map<String, dynamic> json) => Account(
        account_id: json['account_id'] as String,
        // role_roleID: json['role_roleID'] as int,
        departmentID: json['departmentID'] as int,
        roleID: json['roleID'] as int,
        first_name: json['first_name'] as String,
        last_name: json['last_name'] as String,
        email: json['email'] as String,
        departmentName: json['departmentName'] as String,
        schoolName: json['schoolName'] as String,
        // ignore: unnecessary_null_in_if_null_operators, prefer_if_null_operators
        approve: json['approve'] as int,
        image: json['image'] as String,
        token: json['token'] as String,
        message: json['message'] as String,
      );
  Map<String, dynamic> toJson() {
    return {
      'account_id': account_id,
      'roleID': roleID,
      'departmentID': departmentID,
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'password': password,
      'approve': approve,
      'departmentName': departmentName,
      'image': image,
      'schoolName': schoolName,
      'token': token,
    };
  }
}
