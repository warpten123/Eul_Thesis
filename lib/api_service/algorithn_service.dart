import 'dart:convert';

import 'package:thesis_eul/api_service/api_response.dart';
import 'package:http/http.dart' as http;
import '../models/comments.dart';
import 'package:thesis_eul/api_service/links.dart';

class AlgorithmService {
  // static const baseURLFlask = 'http://10.0.2.2:5000/';
  static const headers = {
    'Content-Type': 'application/json',
    'Connection': 'Keep-Alive',
  };

  Future<APIResponse<Map<String, dynamic>>> extractInformation(
      String fileName) {
    return http
        .get(
            Uri.parse('${baseURLFlask}python/information_extraction/$fileName'))
        .then((data) {
      if (data.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(data.body);
        return APIResponse<Map<String, dynamic>>(
          data: jsonData,
        );
      }
      return APIResponse<Map<String, dynamic>>(
          error: true, errorMessage: "An error occured");
    }).catchError((_) => APIResponse<Map<String, dynamic>>(
            error: true, errorMessage: "An error occured"));
  }

  Future<APIResponse<Map<String, dynamic>>> extractAbstract(String fileName) {
    return http
        .get(
            Uri.parse('${baseURLFlask}python/knn/extract_forDataSet/$fileName'))
        .then((data) {
      if (data.statusCode == 200) {
        print("DATA ${data.body}");
        Map<String, dynamic> jsonData = jsonDecode(data.body);
        return APIResponse<Map<String, dynamic>>(
          data: jsonData,
        );
      }
      return APIResponse<Map<String, dynamic>>(
          error: true, errorMessage: "An error occured");
    }).catchError((_) => APIResponse<Map<String, dynamic>>(
            error: true, errorMessage: "An error occured"));
  }

  Future<APIResponse<Map<String, dynamic>>> checkAcceptance(String fileName) {
    return http
        .get(Uri.parse('${baseURLFlask}python/knn/check_acceptance/$fileName'))
        .then((data) {
      if (data.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(data.body);
        return APIResponse<Map<String, dynamic>>(
          data: jsonData,
        );
      }
      return APIResponse<Map<String, dynamic>>(
          error: true, errorMessage: "An error occured");
    }).catchError((_) => APIResponse<Map<String, dynamic>>(
            error: true, errorMessage: "An error occured"));
  }

  Future<APIResponse<List<dynamic>>> getKeyPhrases(String fileName) {
    return http
        .get(Uri.parse(
            '${baseURLFlask}python/information_extractor/keyphrases/$fileName'))
        .then((data) {
      if (data.statusCode == 200) {
        print(data.body);
        List<dynamic> jsonData = jsonDecode(data.body);
        return APIResponse<List<dynamic>>(
          data: jsonData,
        );
      }
      return APIResponse<List<dynamic>>(
          error: true, errorMessage: "An error occured");
    }).catchError((_) => APIResponse<List<dynamic>>(
            error: true, errorMessage: "An error occured"));
  }
}
