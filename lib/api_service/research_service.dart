import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thesis_eul/api_service/api_response.dart';
import 'package:thesis_eul/models/research_details.dart';

import '../models/research.dart';

class ResearchService {
  static const API = 'https://tq-notes-api-jkrgrdggbq-el.a.run.app';
  static const headers = {
    'apiKey': 'abaf3c8e-72c0-498b-9862-47afad7add14',
    'Content-Type': 'application/json'
  };
  Future<APIResponse<List<ResearchDetails>>> getResearchList() {
    return http
        .get(Uri.parse(API + '/research'), headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = jsonDecode(data.body); //
        final research = <ResearchDetails>[];
        for (var item in jsonData) {
          research.add(ResearchDetails.fromJson(item));
        }
        return APIResponse<List<ResearchDetails>>(
          data: research,
        );
      }
      return APIResponse<List<ResearchDetails>>(
          error: true, errorMessage: "An error occured");
    }).catchError((_) => APIResponse<List<ResearchDetails>>(
            error: true, errorMessage: "An error occured"));
  }

  ////single item
  Future<APIResponse<ResearchDetails>> getResearch(String researchID) {
    return http
        .get(Uri.parse(API + '/research/' + researchID), headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = jsonDecode(data.body);

        return APIResponse<ResearchDetails>(
          data: ResearchDetails.fromJson(jsonData),
        );
      }
      return APIResponse<ResearchDetails>(error: true, errorMessage: "An error occured");
    }).catchError((_) =>
            APIResponse<ResearchDetails>(error: true, errorMessage: "An error occured"));
  }

  //create note
  Future<APIResponse<bool>> createNote(NoteManipulation item) {
    return http
        .post(Uri.parse(API + '/notes'),
            headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(
          data: true,
        );
      }
      return APIResponse<bool>(error: true, errorMessage: "An error occured");
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: "An error occured"));
  }

  //update note
  Future<APIResponse<bool>> updateNote(String noteID, NoteManipulation item) {
    return http
        .put(Uri.parse(API + '/notes/' + noteID),
            headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(
          data: true,
        );
      }
      return APIResponse<bool>(error: true, errorMessage: "An error occured");
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: "An error occured"));
  }

  ///deleteNote
  Future<APIResponse<bool>> deleteNote(String noteID) {
    return http
        .delete(
      Uri.parse(API + '/notes/' + noteID),
      headers: headers,
    )
        .then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(
          data: true,
        );
      }
      return APIResponse<bool>(error: true, errorMessage: "An error occured");
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: "An error occured"));
  }
}
