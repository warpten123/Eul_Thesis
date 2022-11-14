// import from a filename account.dart
// ignore_for_file: public_member_api_docs, sort_constructors_first
// research_details class
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

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
      'researchId': researchId,
      'category': sdgCategory,
      'datePublished': datePublished,
      'authors': authors,
      'adviser': adviser,
      'keywords': keywords,
    };
  }

  factory ResearchDetails.fromMap(Map<String, dynamic> map) {
    return ResearchDetails(
      title: map['title'] as String,
      image: map['image'] as String,
      department: map['department'] as String,
      researchId: map['researcId'] as String,
      sdgCategory: map['sdgCategory'] as List<String>,
      datePublished: map['datePublished'] as String,
      authors: map['authors'] as List<String>,
      adviser: map['adviser'] as String,
      keywords: map['keywords'] as List<String>,
    );
  }
  factory ResearchDetails.fromJson(Map<String, dynamic> json) =>
      ResearchDetails(
        title: json['title'] as String,
        image: json['image'] as String,
        department: json['department'] as String,
        researchId: json['researcId'] as String,
        sdgCategory: json['category'] as List<String>,
        datePublished: json['datePublished'] as String,
        authors: json['authors'] as List<String>,
        adviser: json['adviser'] as String,
        keywords: json['keywords'] as List<String>,
      );

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'image': image,
      'department': department,
      'researcId': researchId,
      'sdgCategory': sdgCategory,
      'datePublished': datePublished,
      'authors': authors,
      'adviser': adviser,
      'keywords': keywords
    };
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
}//end class
