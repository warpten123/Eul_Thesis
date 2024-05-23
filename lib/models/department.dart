class Department {
  int departmentID;
  String departmentName;

  Department({
    required this.departmentID,
    required this.departmentName,
  });
  factory Department.fromJson(Map<String, dynamic> json) => Department(
        departmentID: json['departmentID'] as int,
        departmentName: json['departmentName'] as String,
      );

  Map<String, dynamic> toJson() {
    return {
      'departmentID': departmentID,
      'departmentName': departmentName,
    };
  }
}
