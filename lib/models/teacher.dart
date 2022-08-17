// ignore_for_file: public_member_api_docs, sort_constructors_first
class Teacher {
  int teacherID;
  String teacherName;
  List<int?> classID;
  List<String?> groups;
  Teacher({
    required this.teacherID,
    required this.teacherName,
    required this.classID,
    required this.groups,
  });
}
