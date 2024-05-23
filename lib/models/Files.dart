import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Files {
  int? idx;
  String file;
  String research_id;
  String url;
  Files({
    this.idx,
    required this.file,
    // ignore: non_constant_identifier_names
    required this.research_id,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idx': idx,
      'file': file,
      'research_id': research_id,
      'url': url,
    };
  }

  factory Files.fromMap(Map<String, dynamic> map) {
    return Files(
      idx: map['idx'] as int,
      file: map['file'] as String,
      research_id: map['research_id'] as String,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Files.fromJson(String source) =>
      Files.fromMap(json.decode(source) as Map<String, dynamic>);
}
