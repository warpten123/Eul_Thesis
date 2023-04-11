import 'dart:convert';

import 'package:thesis_eul/api_service/api_response.dart';
import 'package:http/http.dart' as http;
import '../models/comments.dart';

class AlgorithmService {
  static const baseURLFlask = 'http://10.0.2.2:5000/';
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
        .get(Uri.parse('${baseURLFlask}python/knn/extract_abstract/$fileName'))
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
}
