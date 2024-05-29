// import from a filename account.dart
// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
// research_details class
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:thesis_eul/models/AccountModel.dart';

class ResearchDetails extends Equatable {
  final String? research_id;
  final int? departmentID;
  final List<dynamic>? sdg_category;
  final String date_published;
  final List<dynamic> keywords;
  final String title;
  final String abstracts;
  final int number_of_views;
  final int approved;
  final String file;

  const ResearchDetails({
    this.research_id,
    this.departmentID,
    this.sdg_category,
    required this.date_published,
    required this.keywords,
    required this.title,
    required this.abstracts,
    required this.number_of_views,
    required this.approved,
    required this.file,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'research_id': research_id,
      'departmentID': departmentID,
      'sdg_category': sdg_category,
      'date_published': date_published,
      'keywords': keywords,
      'title': title,
      'abstracts': abstracts,
      'qr': keywords,
      'number_of_views': number_of_views,
      'approved': approved,
      'file': file,
    };
  }

  factory ResearchDetails.fromMap(Map<String, dynamic> map) {
    return ResearchDetails(
      research_id: map['research_id'] as String,
      departmentID: map['departmentID'] as int,
      sdg_category: map['sdg_category'] as List<dynamic>,
      date_published: map['date_published'] as String,
      keywords: map['keywords'] as List<dynamic>,
      title: map['title'] as String,
      abstracts: map['abstracts'] as String,
      number_of_views: map['number_of_views'] as int,
      approved: map['approved'] as int,
      file: map['file'] as String,
    );
  }
  factory ResearchDetails.fromMapLibrary(Map<String, dynamic> map) {
    return ResearchDetails(
      departmentID: map['departmentID'] as int,
      sdg_category: map['sdg_category'] as List<dynamic>,
      date_published: map['date_published'] as String,
      keywords: map['keywords'] as List<dynamic>,
      title: map['title'] as String,
      abstracts: map['abstracts'] as String,
      approved: map['approved'] as int,
      number_of_views: map['number_of_views'] as int,
      file: map['file'] as String,
    );
  }
  factory ResearchDetails.fromJson(Map<String, dynamic> json) =>
      ResearchDetails(
        research_id: json['research_id'] as String,
        departmentID: json['departmentID'] as int,
        sdg_category: json['sdg_category'] as List<dynamic>,
        date_published: json['date_published'] as String,
        keywords: json['keywords'] as List<dynamic>,
        title: json['title'] as String,
        abstracts: json['abstracts'] as String,
        approved: json['approved'] as int,
        number_of_views: json['number_of_views'] as int,
        file: json['file'] as String,
      );

  Map<String, dynamic> toJson() {
    return {
      'research_id': research_id,
      'departmentID': departmentID,
      'sdg_category': sdg_category,
      'date_published': date_published,
      'keywords': keywords,
      'title': title,
      'abstracts': abstracts,
      'approved': approved,
      'number_of_views': number_of_views,
      'file': file,
    };
  }

  @override
  List<Object?> get props => [
        research_id,
        departmentID,
        sdg_category,
        date_published,
        file,
        keywords,
        title,
        abstracts,
        number_of_views,
        approved,
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
    int? approved,
    int? number_of_views,
    dynamic sdg_categories,
  }) {
    return ResearchDetails(
      research_id: research_id ?? this.research_id,
      departmentID: departmentID ?? this.departmentID,
      sdg_category: sdg_category ?? this.sdg_category,
      date_published: date_published ?? this.date_published,
      keywords: keywords ?? this.keywords,
      title: title ?? this.title,
      abstracts: abstract ?? this.abstracts,
      approved: approved ?? this.approved,
      number_of_views: number_of_views ?? this.number_of_views,
      file: file ?? this.file,
    );
  }
}//end class
