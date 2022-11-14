import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:io'; // for File

import 'package:thesis_eul/api_service/api_response.dart';
import 'package:thesis_eul/models/research_details.dart';
import 'package:path_provider/path_provider.dart';

import '../models/ticket.dart';

class ResearchService {
  static const API = 'https://tq-notes-api-jkrgrdggbq-el.a.run.app';
  static const baseURL = 'http://10.0.2.2:8080/';
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
          print("from API: $research");
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

  Future<APIResponse<List<Ticket>>> getTicketList() {
    return http.get(Uri.parse(baseURL + 'ticket/all')).then((data) {
      if (data.statusCode == 200) {
        final jsonData = jsonDecode(data.body); //
        final ticket = <Ticket>[];
        print("from API: $jsonData");
        for (var item in jsonData) {
          ticket.add(Ticket.fromJson(item));
          print("from API: $ticket");
        }
        return APIResponse<List<Ticket>>(
          data: ticket,
        );
      }
      return APIResponse<List<Ticket>>(
          error: true, errorMessage: "An error occured");
    }).catchError((_) => APIResponse<List<Ticket>>(
        error: true, errorMessage: "An error occured"));
  }

  Future<APIResponse<bool>> createTicket(Ticket ticket) {
    return http
        .post(Uri.parse(baseURL + 'ticket/create'),
            body: json.encode(ticket.toJson()))
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
  // ////single item
  // Future<APIResponse<ResearchDetails>> getResearch(String researchID) {
  //   return http
  //       .get(Uri.parse(API + '/research/' + researchID), headers: headers)
  //       .then((data) {
  //     if (data.statusCode == 200) {
  //       final jsonData = jsonDecode(data.body);

  //       return APIResponse<ResearchDetails>(
  //         data: ResearchDetails.fromJson(jsonData),
  //       );
  //     }
  //     return APIResponse<ResearchDetails>(
  //         error: true, errorMessage: "An error occured");
  //   }).catchError((_) => APIResponse<ResearchDetails>(
  //           error: true, errorMessage: "An error occured"));
  // }

  // //create note
  // Future<APIResponse<bool>> uploadResearch(ResearchDetails research) {
  //   return http
  //       .post(Uri.parse(API + '/research'),
  //           headers: headers, body: json.encode(item.toJson()))
  //       .then((data) {
  //     if (data.statusCode == 201) {
  //       return APIResponse<bool>(
  //         data: true,
  //       );
  //     }
  //     return APIResponse<bool>(error: true, errorMessage: "An error occured");
  //   }).catchError((_) =>
  //           APIResponse<bool>(error: true, errorMessage: "An error occured"));
  // }

  // //update note
  // Future<APIResponse<bool>> updateResearch(
  //     String researchID, ResearchDetails research) {
  //   return http
  //       .put(Uri.parse(API + '/research/' + noteID),
  //           headers: headers, body: json.encode(item.toJson()))
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

  Future<File> loadNetwork(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;

    return _storeFile(url, bytes);
  }

  Future<File> _storeFile(String url, List<int> bytes) async {
    final fileName = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  static Future<File?> pickFile() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result == null) return null;
    return File(result.paths.first!);
  }
}
