// export an Account Interfacee
class Account {
  String? accountID;
  String code;
  String? accountName;
  String accountEmail;
  String? accountPassword;
  String? department;
  String role;
  Account(
      {required this.code,
      required this.accountEmail,
      required this.role,
      required String accountPassword});
}

// extends to Account class
class Student extends Account {
  int? groupID;
  // inheret all attributes in Account class
  Student({
    required String studentID,
    required String code,
    required String studentName,
    required String studentEmail,
    required String studentPassword,
    required String department,
    required int groupID,
  }) : super(
          code: code,
          accountEmail: studentEmail,
          role: 'student',
          accountPassword: studentPassword,
        );

  register(String email, String name, String school_id, String password) {}
}

// extend teachers Account class to Accoount Class
class Teacher extends Account {
  // inheret all attributes in Account class
  Teacher({
    required String studentID,
    required String code,
    required String teacherName,
    required String teacherEmail,
    required String teacherPassword,
    required String department,
  }) : super(
          code: code,
          accountEmail: teacherEmail,
          role: 'teacher',
          accountPassword: teacherPassword,
        );
}
