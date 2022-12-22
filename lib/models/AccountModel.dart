// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
class Account {
  String? school_id;
  int role_roleID;
  int departmentID;
  String first_name;
  String last_name;
  String email;
  String? password;
  int? approve;
  Account({
    this.school_id,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.departmentID,
    this.password,
    required this.role_roleID,
    this.approve,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        school_id: json['school_id'] as String,
        role_roleID: json['role_roleID'] as int,
        departmentID: json['departmentID'] as int,
        first_name: json['first_name'] as String,
        last_name: json['last_name'] as String,
        email: json['email'] as String,

        password: json['password'] as String,

        // ignore: unnecessary_null_in_if_null_operators, prefer_if_null_operators
        approve: json['approve'] as int,
      );
  factory Account.fromJsonFetchByID(Map<String, dynamic> json) => Account(
        school_id: json['school_id'] as String,
        role_roleID: json['role_roleID'] as int,
        departmentID: json['departmentID'] as int,
        first_name: json['first_name'] as String,
        last_name: json['last_name'] as String,
        email: json['email'] as String,

        // ignore: unnecessary_null_in_if_null_operators, prefer_if_null_operators
        approve: json['approve'] as int,
      );
  Map<String, dynamic> toJson() {
    return {
      'school_id': school_id,
      'role_roleID': role_roleID,
      'departmentID': departmentID,
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'password': password,
      'approve': approve,
    };
  }
}
