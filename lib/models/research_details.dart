// import from a filename account.dart
// ignore_for_file: public_member_api_docs, sort_constructors_first
// research_details class
import 'package:json_annotation/json_annotation.dart';
class ResearchDetails {
  String title;
  String image;
  String department;
  List<String> authors;
  String researchId;
  List<String> category;
  String datePublished;
  String adviser;
  List<String> keywords;
  ResearchDetails({
    required this.title,
    required this.image,
    required this.department,
    required this.authors,
    required this.researchId,
    required this.category,
    required this.datePublished,
    required this.adviser,
    required this.keywords,
  });

}
