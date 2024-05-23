// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;
// for File
import 'package:thesis_eul/api_service/api_response.dart';
import 'package:thesis_eul/models/authored.dart';
import 'package:thesis_eul/models/research_details.dart';
import 'package:thesis_eul/api_service/links.dart';

class ResearchService {
  // static const baseURL = 'http://10.0.2.2:3000/'; //eul-backend.loca.lt
  // static const baseURL = 'https://lazy-emu-89.loca.lt/'; //eul-backend.loca.lt
  static const headers = {
    'apiKey': 'abaf3c8e-72c0-498b-9862-47afad7add14',
    'Content-Type': 'application/json',
    'Connection': 'Keep-Alive',
  };
  Future<APIResponse<List<ResearchDetails>>> getResearchList() {
    return http
        .get(Uri.parse('${baseURL}api/research/fetchAllResearchList'))
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = (jsonDecode(data.body)[0] as List)
            .map((e) => e as Map<String, dynamic>)
            .toList(); //
        final research = <ResearchDetails>[];

        // ignore: unused_local_variable
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

  Future<APIResponse<List<ResearchDetails>>> getSDGList(String goal) {
    return http
        .get(Uri.parse('${baseURL}api/research/getResearchBySimilarSDG/$goal'))
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = (jsonDecode(data.body));

        final research = <ResearchDetails>[];

        // ignore: unused_local_variable
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

  Future<APIResponse<List<ResearchDetails>>> getUserLibray(String schooldID) {
    return http
        .get(Uri.parse('${baseURL}api/research/fetchMyResearchList/$schooldID'))
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = (jsonDecode(data.body)[0] as List)
            .map((e) => e as Map<String, dynamic>)
            .toList(); //
        final research = <ResearchDetails>[];

        // ignore: unused_local_variable
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

  Future<APIResponse<List<ResearchDetails>>> getUserBookmarks(
      String schooldID) {
    return http
        .get(Uri.parse('${baseURL}api/research/fetchLibrary/$schooldID'))
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = (jsonDecode(data.body)[0] as List)
            .map((e) => e as Map<String, dynamic>)
            .toList(); //
        final research = <ResearchDetails>[];

        // ignore: unused_local_variable
        for (var item in jsonData) {
          research.add(ResearchDetails.fromMap(item));
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

//removeMyResearchList
  Future<APIResponse<bool>> removeBookmark(
      String research_id, String school_id) {
    var userInfo = {
      'research_id': research_id,
      'school_id': school_id,
    };
    return http
        .post(Uri.parse('${baseURL}api/research/removeMyResearchList/'),
            body: json.encode(userInfo), headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        return APIResponse<bool>(
          data: true,
        );
      }
      return APIResponse<bool>(error: true, errorMessage: "An error occured");
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: "An error occured"));
  }

  Future<APIResponse<bool>> addResearch(ResearchDetails research) {
    return http
        .post(Uri.parse('${baseURL}api/research/addResearchDetails'),
            headers: headers, body: json.encode(research.toJson()))
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

  Future<APIResponse<bool>> addBookmarks(ResearchDetails research) {
    return http
        .post(Uri.parse('${baseURL}api/research/addResearchDetails'),
            headers: headers, body: json.encode(research.toJson()))
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

  Future<APIResponse<bool>> addAuthored(String researchID, String studentID) {
    var payload = {
      'research_id': researchID,
      'school_id': studentID,
    };
    return http
        .post(Uri.parse('${baseURL}api/research/addAuthored'),
            headers: headers, body: json.encode(payload))
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

  Future<APIResponse<bool>> addResearchList(
      String research_id, String school_id) {
    var payload = {
      'research_id': research_id,
      'school_id': school_id,
    };

    return http
        .post(Uri.parse('${baseURL}api/research/addMyResearchList'),
            headers: headers, body: json.encode(payload))
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

  Future<APIResponse<bool>> deleteResearch(String researchID) {
    return http
        .delete(
      Uri.parse('${baseURL}api/research/deleteResearch/$researchID'),
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

  // //update note
  Future<APIResponse<bool>> updateResearch(ResearchDetails research) {
    return http
        .put(Uri.parse('${baseURL}api/research/updateResearchDetails'),
            headers: headers, body: json.encode(research.toJson()))
        .then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(
          data: true,
        );
      }
      return APIResponse<bool>(
          error: true, errorMessage: data.statusCode.toString());
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: "An error occured"));
  }

  Future<APIResponse<Authored>> getAuthored(String researchID) {
    return http
        .get(Uri.parse('${baseURL}api/research/getAuthored/$researchID'),
            headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = jsonDecode(data.body)[0];
        return APIResponse<Authored>(
          data: Authored.fromJson(jsonData[0]),
        );
      } else {
        print(data.statusCode.toString());
      }
      return APIResponse<Authored>(
          error: true, errorMessage: data.statusCode.toString());
    }).catchError((_) => APIResponse<Authored>(
            error: true, errorMessage: "An error occured"));
  }
  // ///deleteNote
  // Future<APIResponse<bool>> deleteResearch(String researchID) {
  //   return http
  //       .delete(
  //     Uri.parse(API + '/research/' + researchID),
  //     headers: headers,
  //   )
  //       .then((data) {
  //     if (data.statusCode == 204) {
  //       return APIResponse<bool>(
  //         data: true,
  //       );
  //     }
  //     return APIResponse<bool>(error: true, errorMessage: "An error occured");
  //   }).catchError((_) =>
  //           APIResponse<bool>(error: true, errorMessage: "An error occured"));
  // }

}
