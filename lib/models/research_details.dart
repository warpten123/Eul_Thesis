// import from a filename account.dart
// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
// research_details class
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

class ResearchDetails extends Equatable {
  final String? research_id;
  final int departmentID;
  final List<dynamic> sdg_category;
  final List<dynamic> topic_category;
  final String date_published;
  final String adviser;

  final List<dynamic> keywords;
  final String title;
  final String abstracts;
  final String qr;
  final int number_of_views;

  const ResearchDetails({
    this.research_id,
    required this.departmentID,
    required this.topic_category,
    required this.sdg_category,
    required this.date_published,
    required this.adviser,
    required this.keywords,
    required this.title,
    required this.abstracts,
    required this.qr,
    required this.number_of_views,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'research_id': research_id,
      'departmentID': departmentID,
      'topic_category': topic_category,
      'sdg_category': sdg_category,
      'date_published': date_published,
      'adviser': adviser,
      'keywords': keywords,
      'title': title,
      'abstracts': abstracts,
      'qr': keywords,
      'number_of_views': number_of_views,
    };
  }

  factory ResearchDetails.fromMap(Map<String, dynamic> map) {
    return ResearchDetails(
      research_id: map['research_id'] as String,
      departmentID: map['departmentID'] as int,
      topic_category: map['topic_category'] as List<dynamic>,
      sdg_category: map['sdg_category'] as List<dynamic>,
      date_published: map['date_published'] as String,
      adviser: map['adviser'] as String,
      keywords: map['keywords'] as List<dynamic>,
      title: map['title'] as String,
      abstracts: map['abstracts'] as String,
      qr: map['qr'] as String,
      number_of_views: map['number_of_views'] as int,
    );
  }
  factory ResearchDetails.fromMapLibrary(Map<String, dynamic> map) {
    return ResearchDetails(
      departmentID: map['departmentID'] as int,
      topic_category: map['topic_category'] as List<dynamic>,
      sdg_category: map['sdg_category'] as List<dynamic>,
      date_published: map['date_published'] as String,
      adviser: map['adviser'] as String,
      keywords: map['keywords'] as List<dynamic>,
      title: map['title'] as String,
      abstracts: map['abstracts'] as String,
      qr: map['qr'] as String,
      number_of_views: map['number_of_views'] as int,
    );
  }
  factory ResearchDetails.fromJson(Map<String, dynamic> json) =>
      ResearchDetails(
        research_id: json['research_id'] as String,
        departmentID: json['departmentID'] as int,
        topic_category: json['topic_category'] as List<dynamic>,
        sdg_category: json['sdg_category'] as List<dynamic>,
        date_published: json['date_published'] as String,
        adviser: json['adviser'] as String,
        keywords: json['keywords'] as List<dynamic>,
        title: json['title'] as String,
        abstracts: json['abstracts'] as String,
        qr: json['qr'] as String,
        number_of_views: json['number_of_views'] as int,
      );

  Map<String, dynamic> toJson() {
    return {
      'research_id': research_id,
      'departmentID': departmentID,
      'topic_category': topic_category,
      'sdg_category': sdg_category,
      'date_published': date_published,
      'adviser': adviser,
      'keywords': keywords,
      'title': title,
      'abstracts': abstracts,
      'qr': qr,
      'number_of_views': number_of_views,
    };
  }

  @override
  List<Object?> get props => [
        research_id,
        departmentID,
        topic_category,
        sdg_category,
        date_published,
        adviser,
        keywords,
        title,
        abstracts,
        qr,
        number_of_views
      ];
  ResearchDetails copyWith({
    String? research_id,
    int? departmentID,
    List<String>? topic_category,
    List<String>? sdg_category,
    String? date_published,
    String? adviser,
    List<String>? keywords,
    String? title,
    String? abstract,
    String? qr,
    int? number_of_views,
  }) {
    return ResearchDetails(
        research_id: research_id ?? this.research_id,
        departmentID: departmentID ?? this.departmentID,
        topic_category: topic_category!,
        sdg_category: sdg_category ?? this.sdg_category,
        date_published: date_published ?? this.date_published,
        adviser: adviser ?? this.adviser,
        keywords: keywords ?? this.keywords,
        title: title ?? this.title,
        abstracts: abstract ?? this.abstracts,
        qr: qr ?? this.qr,
        number_of_views: number_of_views ?? this.number_of_views);
  }
}//end class
