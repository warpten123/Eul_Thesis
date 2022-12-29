// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:mysql1/mysql1.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:io'; // for File
import 'package:path/path.dart';
import 'package:thesis_eul/api_service/api_response.dart';
import 'package:thesis_eul/models/Files.dart';
import 'package:thesis_eul/models/department.dart';
import 'package:thesis_eul/models/research_details.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

import '../models/AccountModel.dart';
import '../models/student.dart';
import '../models/ticket.dart';

import 'package:dio/dio.dart';

class ResearchService {
  static const baseURL = 'http://10.0.2.2:3000/';
  static const headers = {
    'apiKey': 'abaf3c8e-72c0-498b-9862-47afad7add14',
    'Content-Type': 'application/json'
  };
  Future<APIResponse<List<ResearchDetails>>> getResearchList() {
    return http
        .get(Uri.parse('${baseURL}api/research/fetchAllResearchList'))
        .then((data) {
      print("get res ${data.statusCode}");
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

  Future<APIResponse<List<ResearchDetails>>> getUserLibray(String schooldID) {
    return http
        .get(Uri.parse('${baseURL}api/research/fetchMyResearchList/$schooldID'))
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = (jsonDecode(data.body)[0] as List)
            .map((e) => e as Map<String, dynamic>)
            .toList(); //
        print("get res $jsonData");
        final research = <ResearchDetails>[];

        // ignore: unused_local_variable
        for (var item in jsonData) {
          research.add(ResearchDetails.fromMapLibrary(item));
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
        print("get res $jsonData");
        final research = <ResearchDetails>[];

        // ignore: unused_local_variable
        for (var item in jsonData) {
          research.add(ResearchDetails.fromMapLibrary(item));
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
    return http.get(Uri.parse('${baseURL}ticket/all')).then((data) {
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

  Future<APIResponse<bool>> userLogin(String id, String password) {
    var userInfo = {
      'school_id': id,
      'password': password,
    };
    return http
        .post(Uri.parse('${baseURL}auth/login'),
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

  Future<APIResponse<bool>> updateAccount(Account account) {
    print("${baseURL}api/account/update/${account.school_id}");
    return http
        .post(Uri.parse('${baseURL}api/account/update/${account.school_id}'),
            body: json.encode(account.toJson()), headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        print("yehey!");
        return APIResponse<bool>(
          data: true,
        );
      }
      return APIResponse<bool>(
          error: true, errorMessage: data.statusCode.toString());
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: "An error occured"));
  }

  Future<APIResponse<List<Account>>> getAllAccounts() {
    return http.get(Uri.parse(baseURL + 'api/account/')).then((data) {
      if (data.statusCode == 200) {
        final jsonData = (jsonDecode(data.body)[0] as List)
            .map((e) => e as Map<String, dynamic>)
            .toList(); //
        final account = <Account>[];
        // print("from API: ${jsonData[0]}");
        // ignore: unused_local_variable
        for (var item in jsonData) {
          account.add(Account.fromJson(item));
        }
        return APIResponse<List<Account>>(
          data: account,
        );
      }
      return APIResponse<List<Account>>(
          error: true, errorMessage: "An error occured");
    }).catchError((_) => APIResponse<List<Account>>(
        error: true, errorMessage: "An error occured"));
  }

  Future<APIResponse<List<Department>>> getAllDepartments() {
    return http
        .get(Uri.parse('${baseURL}api/account/departments'))
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = (jsonDecode(data.body)[0] as List)
            .map((e) => e as Map<String, dynamic>)
            .toList(); //
        print("SETVICE: $jsonData");
        final account = <Department>[];
        // print("from API: ${jsonData[0]}");
        // ignore: unused_local_variable
        for (var item in jsonData) {
          account.add(Department.fromJson(item));
        }
        return APIResponse<List<Department>>(
          data: account,
        );
      }
      return APIResponse<List<Department>>(
          error: true, errorMessage: data.statusCode.toString());
    }).catchError((_) => APIResponse<List<Department>>(
            error: true, errorMessage: "An error occured"));
  }

  Future<APIResponse<Account>> getStudentByID(String id) {
    return http
        .get(Uri.parse('${baseURL}api/account/$id'), headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = jsonDecode(data.body)[0];
        print("from service: $jsonData");
        return APIResponse<Account>(
          data: Account.fromJsonFetchByID(jsonData[0]),
        );
      }
      return APIResponse<Account>(
          error: true, errorMessage: data.statusCode.toString());
    }).catchError((_) => APIResponse<Account>(
            error: true, errorMessage: "An error occured"));
  }

  Future<APIResponse<bool>> createAccount(Account account) {
    print("SERVICE ${account.departmentID}");
    print("SERVICE ${account.email}");
    print("SERVICE ${account.role_roleID}");
    return http
        .post(Uri.parse('http://10.0.2.2:3000/auth/signup'),
            headers: headers, body: json.encode(account.toJson()))
        .then((data) {
      if (data.statusCode == 200 || data.statusCode == 201) {
        return APIResponse<bool>(
          data: true,
        );
      }
      return APIResponse<bool>(
          error: true, errorMessage: data.statusCode.toString());
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
  Future<APIResponse<bool>> addResearch(ResearchDetails research) {
    print("service ${research.abstracts}");
    return http
        .post(Uri.parse('http://10.0.2.2:3000/api/research/addResearchDetails'),
            headers: headers, body: json.encode(research.toJson()))
        .then((data) {
      print("from add ${data.body}");
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
        .post(Uri.parse('http://10.0.2.2:3000/api/research/addAuthored'),
            headers: headers, body: json.encode(payload))
        .then((data) {
      print("from add ${data.body}");
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
        .post(Uri.parse('http://10.0.2.2:3000/api/research/addMyResearchList'),
            headers: headers, body: json.encode(payload))
        .then((data) {
      print("from add ${data.body}");
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
    print("update");
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

  Future<APIResponse<bool>> fileUpload(Files file) async {
    // var userInfo = {
    //   'school_id': id,
    //   'password': password,
    // };
    var map = <String, dynamic>{};
    map['file'] = file.file;
    map['research_id'] = file.research_id;
    map['url'] = file.url;
    print(file.url);
    var uri =
        Uri.parse('http://10.0.2.2:3000/file/upload-file/${file.research_id}');
    var request = http.MultipartRequest('POST', uri);
    // request.files.add(
    //     await http.MultipartFile.fromPath('research_id', file.research_id));

    request.files.add(await http.MultipartFile.fromPath('file', file.file));
    request.fields['url'] = file.url;
    var response = await request.send();

    if (response.statusCode == 201 || response.statusCode == 200) {
      print("fromservice: ${response.statusCode}");
      return APIResponse<bool>(
        data: true,
      );
    }
    return APIResponse<bool>(
        error: true, errorMessage: response.statusCode.toString());
  }

  Future<APIResponse<bool>> addUserProfile(Files file) async {
    var uri = Uri.parse(
        'http://10.0.2.2:3000/image/upload-avatar/${file.research_id}');
    var request = http.MultipartRequest('POST', uri);
    // request.files.add(
    //     await http.MultipartFile.fromPath('research_id', file.research_id));

    request.files.add(await http.MultipartFile.fromPath('file', file.file));
    // request.fields['url'] = file.url;
    var response = await request.send();

    if (response.statusCode == 201 || response.statusCode == 200) {
      print("fromservice: ${response.statusCode}");
      return APIResponse<bool>(
        data: true,
      );
    }
    return APIResponse<bool>(
        error: true, errorMessage: response.statusCode.toString());
  }

  Future<APIResponse<dynamic>> getResearchFile(String id) {
    return http
        .get(Uri.parse('${baseURL}file/download/$id'), headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        print("from file: {$data.toString()}");
        final jsonData = jsonDecode(data.body);
        print("from file: $jsonData");
        return APIResponse<dynamic>(
          data: jsonData,
        );
      }

      return APIResponse<dynamic>(
          error: true, errorMessage: data.statusCode.toString());
    }).catchError((_) => APIResponse<dynamic>(
            error: true, errorMessage: "An error occured"));
  }

  Future<APIResponse<dynamic>> getUserProfile(String id) {
    return http
        .get(Uri.parse('${baseURL}image/download/$id'), headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        print("data ${data.body}");
        dynamic blob = data.body;
        Uint8List image = Uint8List.fromList(blob.toBytes());
        print("IMAGE: $image");
        return APIResponse<dynamic>(
          data: image,
        );
      }

      return APIResponse<dynamic>(
          error: true, errorMessage: data.statusCode.toString());
    }).catchError((_) => APIResponse<dynamic>(
            error: true, errorMessage: "An error occured"));
  }
}
