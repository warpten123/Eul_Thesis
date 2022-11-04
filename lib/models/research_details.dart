// import from a filename account.dart
// ignore_for_file: public_member_api_docs, sort_constructors_first
// research_details class
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class ResearchDetails extends Equatable {
  final String title;
  final String image;
  final String department;
  final List<String> authors;
  final String? researchId;
  final List<String>? sdgCategory;
  final String? datePublished;
  final String adviser;
  final List<String>? keywords;
  const ResearchDetails({
    required this.title,
    required this.image,
    required this.department,
    required this.authors,
    this.researchId,
    this.sdgCategory,
    this.datePublished,
    required this.adviser,
    this.keywords,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'image': image,
      'department': department,
      'authors': authors,
      'researchId': researchId,
      'sdgCategory': sdgCategory,
      'datePublished': datePublished,
      'adviser': adviser,
      'keywords': keywords,
    };
  }

  factory ResearchDetails.fromMap(Map<String, dynamic> map) {
    return ResearchDetails(
      title: map['title'] as String,
      image: map['image'] as String,
      department: map['department'] as String,
      authors: List<String>.from((map['authors'] as List<String>),
      researchId: map['researchId'] != null ? map['researchId'] as String : null,
      sdgCategory: map['sdgCategory'] != null ? List<String>.from((map['sdgCategory'] as List<String>) : null,
      datePublished: map['datePublished'] != null ? map['datePublished'] as String : null,
      adviser: map['adviser'] as String,
      keywords: map['keywords'] != null ? List<String>.from((map['keywords'] as List<String>) : null,
    );
  }
  @override
  List<Object?> get props => [
        title,
        image,
        department,
        researchId,
        sdgCategory,
        datePublished,
        authors,
        adviser,
        keywords
      ];
  ResearchDetails copyWith({
    String? title,
    String? image,
    String? department,
    String? researchId,
    List<String>? sdgCategory,
    String? datePublished,
    List<String>? authors,
    String? adviser,
    List<String>? keywords,
  }) {
    return ResearchDetails(
        title: title ?? this.title,
        image: image!,
        department: department ?? this.department,
        researchId: researchId ?? this.researchId,
        sdgCategory: sdgCategory ?? this.sdgCategory,
        datePublished: datePublished ?? this.datePublished,
        authors: authors ?? this.authors,
        adviser: adviser ?? this.adviser,
        keywords: keywords ?? this.keywords);
  }

  String toJson() => json.encode(toMap());

  factory ResearchDetails.fromJson(String source) => ResearchDetails.fromMap(json.decode(source) as Map<String, dynamic>);
}//end class
