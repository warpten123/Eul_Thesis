// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:thesis_eul/models/sdg.dart';

import 'AccountModel.dart';

class Research_View {
  final String? research_id;
  final String date_published;
  final List<dynamic> keywords;
  final String title;
  final String abstracts;
  final int number_of_views;
  final int approved;
  final String file;
  final List<dynamic> authors;
  final List<dynamic> sdg;

  const Research_View(
      {required this.research_id,
      required this.date_published,
      required this.keywords,
      required this.title,
      required this.abstracts,
      required this.number_of_views,
      required this.approved,
      required this.file,
      required this.authors,
      required this.sdg});
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'research_id': research_id,
      'date_published': date_published,
      'keywords': keywords,
      'title': title,
      'abstracts': abstracts,
      'number_of_views': number_of_views,
      'approved': approved,
      'file': file,
      'authors': authors,
      'sdg': sdg,
    };
  }

  factory Research_View.fromJson(Map<String, dynamic> map) {
    return Research_View(
      research_id: map['research_id'] as String,
      date_published: map['date_published'] as String,
      keywords: map['keywords'] as List<dynamic>,
      title: map['title'] as String,
      abstracts: map['abstracts'] as String,
      number_of_views: map['number_of_views'] as int,
      approved: map['approved'] as int,
      file: map['file'] as String,
      authors: map['authors'] as List<dynamic>,
      sdg: map['sdg'] as List<dynamic>,
    );
  }
  // String toJson() => json.encode(toMap());

  // factory Research_View.fromJson(String source) => Research_View.fromMap(json.decode(source) as Map<String, dynamic>);
}
