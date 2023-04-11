// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Comments {
  int? comment_id;
  String? school_id;
  int? authored_id;
  String? comment_text;
  String? created_at;
  String? updated_at;

  Comments({
    this.comment_id,
    this.school_id,
    this.authored_id,
    this.comment_text,
    this.created_at,
    this.updated_at,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'comment_id': comment_id,
      'school_id': school_id,
      'authored_id': authored_id,
      'comment_text': comment_text,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory Comments.fromMap(Map<String, dynamic> map) {
    return Comments(
      comment_id: map['comment_id'] as int,
      school_id: map['school_id'] as String,
      authored_id: map['authored_id'] as int,
      comment_text: map['comment_text'] as String,
      created_at: map['created_at'] as String,
      updated_at: map['updated_at'] as String,
    );
  }
  factory Comments.fromJson(Map<String, dynamic> map) {
    return Comments(
      comment_id: map['comment_id'],
      school_id: map['school_id'],
      authored_id: map['authored_id'],
      comment_text: map['comment_text'],
      created_at: map['created_at'],
      updated_at: map['updated_at'],
    );
  }
}
