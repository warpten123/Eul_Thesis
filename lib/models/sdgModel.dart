import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SDGModel {
  int sdg_id;
  String goalName;
  String sdg_score;
  SDGModel({
    required this.sdg_id,
    required this.goalName,
    required this.sdg_score,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sdg_id': sdg_id,
      'goalName': goalName,
      'sdg_score': sdg_score,
    };
  }

  factory SDGModel.fromMap(Map<String, dynamic> map) {
    return SDGModel(
      sdg_id: map['sdg_id'] as int,
      goalName: map['goalName'] as String,
      sdg_score: map['sdg_score'] as String,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory SDGModel.fromJson(String source) =>
  //     SDGModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
