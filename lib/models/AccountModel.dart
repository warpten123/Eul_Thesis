// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
class Account {
  String school_id;
  String first_name;
  String last_name;
  String email;
  String department;
  String password;
  String? role;
  int? approve;
  Account({
    required this.school_id,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.department,
    required this.password,
    required this.role,
    this.approve,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        school_id: json['school_id'] as String,
        first_name: json['first_name'] as String,
        last_name: json['last_name'] as String,
        email: json['email'] as String,
        department: json['department'] as String,
        password: json['password'] as String,
        role: json['role'] as String,
        // ignore: unnecessary_null_in_if_null_operators, prefer_if_null_operators
        approve: json['approve'] as int,
      );

  Map<String, dynamic> toJson() {
    return {
      'school_id': school_id,
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'department': department,
      'password': password,
      'role': role,
      'approve': approve,
    };
  }
}
