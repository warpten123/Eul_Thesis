class School {
  int schoolID;
  String schoolName;

  School({
    required this.schoolID,
    required this.schoolName,
  });
  factory School.fromJson(Map<String, dynamic> json) => School(
        schoolID: json['schoolID'] as int,
        schoolName: json['schoolName'] as String,
      );

  Map<String, dynamic> toJson() {
    return {
      'schoolID': schoolID,
      'schoolName': schoolName,
    };
  }
}
