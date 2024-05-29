class Department {
  int departmentID;
  String departmentName;
  int school_id;
  String? schoolName;

  Department({
    required this.departmentID,
    required this.departmentName,
    required this.school_id,
    this.schoolName,
  });
  factory Department.fromJson(Map<String, dynamic> json) => Department(
        departmentID: json['departmentID'] as int,
        departmentName: json['departmentName'] as String,
        school_id: json['school_id'] as int,
        schoolName: json['schoolName'] as String,
      );
  factory Department.fromJson2(Map<String, dynamic> json) => Department(
        departmentID: json['departmentID'] as int,
        departmentName: json['departmentName'] as String,
        school_id: json['school_id'] as int,
      );
  Map<String, dynamic> toJson() {
    return {
      'departmentID': departmentID,
      'departmentName': departmentName,
      'school_id': school_id,
      'schoolName': schoolName,
    };
  }
}
