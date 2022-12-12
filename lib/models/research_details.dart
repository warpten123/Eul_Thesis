// import from a filename account.dart
// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
// research_details class
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

class ResearchDetails extends Equatable {
  final String? research_id;
  final List<dynamic> sdg_category;
  final List<dynamic> topic_category;
  final String date_published;
  final String adviser;
  final String department;
  final List<dynamic> keywords;
  final String title;
  final String abstract;
  final String qr;
  final int number_of_views;

  const ResearchDetails({
    this.research_id,
    required this.topic_category,
    required this.sdg_category,
    required this.date_published,
    required this.adviser,
    required this.department,
    required this.keywords,
    required this.title,
    required this.abstract,
    required this.qr,
    required this.number_of_views,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'research_id': research_id,
      'topic_category': topic_category,
      'sdg_category': sdg_category,
      'date_published': date_published,
      'adviser': adviser,
      'department': department,
      'keywords': keywords,
      'title': title,
      'abstract': adviser,
      'qr': keywords,
      'number_of_views': number_of_views,
    };
  }

  factory ResearchDetails.fromMap(Map<String, dynamic> map) {
    return ResearchDetails(
      research_id: map['research_id'] as String,
      topic_category: map['topic_category'] as List<dynamic>,
      sdg_category: map['sdg_category'] as List<dynamic>,
      date_published: map['date_published'] as String,
      adviser: map['adviser'] as String,
      department: map['department'] as String,
      keywords: map['keywords'] as List<dynamic>,
      title: map['title'] as String,
      abstract: map['abstract'] as String,
      qr: map['qr'] as String,
      number_of_views: map['number_of_views'] as int,
    );
  }
  factory ResearchDetails.fromJson(Map<String, dynamic> json) =>
      ResearchDetails(
        research_id: json['research_id'] as String,
        topic_category: json['topic_category'] as List<dynamic>,
        sdg_category: json['sdg_category'] as List<dynamic>,
        date_published: json['date_published'] as String,
        adviser: json['adviser'] as String,
        department: json['department'] as String,
        keywords: json['keywords'] as List<dynamic>,
        title: json['title'] as String,
        abstract: json['abstract'] as String,
        qr: json['qr'] as String,
        number_of_views: json['number_of_views'] as int,
      );

  Map<String, dynamic> toJson() {
    return {
      'research_id': research_id,
      'topic_category': topic_category,
      'sdg_category': sdg_category,
      'date_published': date_published,
      'adviser': adviser,
      'department': department,
      'keywords': keywords,
      'title': title,
      'abstract': abstract,
      'qr': qr,
      'number_of_views': number_of_views,
    };
  }

  @override
  List<Object?> get props => [
        research_id,
        topic_category,
        sdg_category,
        date_published,
        adviser,
        department,
        keywords,
        title,
        abstract,
        qr,
        number_of_views
      ];
  ResearchDetails copyWith({
    String? research_id,
    List<String>? topic_category,
    List<String>? sdg_category,
    String? date_published,
    String? adviser,
    String? department,
    List<String>? keywords,
    String? title,
    String? abstract,
    String? qr,
    int? number_of_views,
  }) {
    return ResearchDetails(
        research_id: research_id ?? this.research_id,
        topic_category: topic_category!,
        sdg_category: sdg_category ?? this.sdg_category,
        date_published: date_published ?? this.date_published,
        adviser: adviser ?? this.adviser,
        department: department ?? this.department,
        keywords: keywords ?? this.keywords,
        title: title ?? this.title,
        abstract: abstract ?? this.abstract,
        qr: qr ?? this.qr,
        number_of_views: number_of_views ?? this.number_of_views);
  }
}//end class
