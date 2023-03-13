import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/comments.dart';

import 'api_response.dart';

class CommentService {
  static const baseURL = 'http://10.0.2.2:3000/';
  static const headers = {'Content-Type': 'application/json'};
  Future<APIResponse<bool>> addComment(Comments comment) {
    print(
        "${comment.school_id}\n${comment.authored_id},\n${comment.comment_text},\n${comment.created_at},\n${comment.updated_at},\n${comment.comment_id}");
    return http
        .post(Uri.parse('${baseURL}comment/addComment'),
            headers: headers, body: json.encode(comment.toJson()))
        .then((data) {
      if (data.statusCode == 201 || data.statusCode == 200) {
        return APIResponse<bool>(
          data: true,
        );
      }
      return APIResponse<bool>(
          error: true, errorMessage: data.statusCode.toString());
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: "An error occured"));
  }

  Future<APIResponse<List<Comments>>> getResearchComments(String researchID) {
    print("bruh wtf");
    return http
        .get(Uri.parse('${baseURL}comment/getAllComments/$researchID'))
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = (jsonDecode(data.body)[0] as List)
            .map((e) => e as Map<String, dynamic>)
            .toList(); //
        final research = <Comments>[];

        // ignore: unused_local_variable
        for (var item in jsonData) {
          research.add(Comments.fromJson(item));
          print(research[0].comment_text);
        }

        return APIResponse<List<Comments>>(
          data: research,
        );
      }
      return APIResponse<List<Comments>>(
          error: true, errorMessage: "An error occured");
    }).catchError((_) => APIResponse<List<Comments>>(
            error: true, errorMessage: "An error occured"));
  }
}
