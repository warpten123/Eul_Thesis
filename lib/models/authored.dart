// ignore_for_file: public_member_api_docs, sort_constructors_first
class Authored {
  int? authored_id;
  String research_id;
  String school_id;
  Authored({
    this.authored_id,
    required this.research_id,
    required this.school_id,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'authored_id': authored_id,
      'research_id': research_id,
      'school_id': school_id,
    };
  }

  factory Authored.fromMap(Map<String, dynamic> map) {
    return Authored(
      authored_id: map['authored_id'] as int,
      research_id: map['research_id'] as String,
      school_id: map['school_id'] as String,
    );
  }
  factory Authored.fromJson(Map<String, dynamic> map) {
    return Authored(
      authored_id: map['authored_id'] as int,
      research_id: map['research_id'] as String,
      school_id: map['school_id'] as String,
    );
  }
}
