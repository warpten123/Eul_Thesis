// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
// for File
import 'package:thesis_eul/api_service/api_response.dart';
import 'package:thesis_eul/models/Files.dart';
import 'package:thesis_eul/models/department.dart';
import 'package:thesis_eul/api_service/links.dart';
import 'package:thesis_eul/models/school.dart';
import '../models/AccountModel.dart';

class UserService {
  // static const baseURL = 'http://10.0.2.2:3000/'; //little-termite-22.loca.lt

  static const headers = {
    'Content-Type': 'application/json',
    'Connection': 'Keep-Alive',
  };
  Future<APIResponse<Account>> userLogin(String email, String password) {
    var userInfo = {
      'email': email,
      'password': password,
    };

    return http
        .post(Uri.parse('${baseURL}auth/login'),
            body: json.encode(userInfo), headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = jsonDecode(data.body);

        return APIResponse<Account>(
          data: Account.fromJsonFetchByID(jsonData),
        );
      }
      return APIResponse<Account>(
          error: true, errorMessage: data.statusCode.toString());
    }).catchError((_) => APIResponse<Account>(
            error: true, errorMessage: "An error occured"));
  }

  Future<APIResponse<bool>> updateAccount(Account account) {
    return http
        .post(Uri.parse('${baseURL}api/account/update/${account.account_id}'),
            body: json.encode(account.toJson()), headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
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
    return http.get(Uri.parse('${baseURL}api/account/')).then((data) {
      if (data.statusCode == 200) {
        final jsonData = (jsonDecode(data.body)[0] as List)
            .map((e) => e as Map<String, dynamic>)
            .toList(); //

        final account = <Account>[];
        //
        //("from API: ${jsonData[0]}");
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
        print("DATA FROM DEP: ${data.body}");
        final jsonData = (jsonDecode(data.body)); //
        final account = <Department>[];
        // print("from API: ${jsonData[0]}");
        // ignore: unused_local_variable
        for (var item in jsonData) {
          account.add(Department.fromJson2(item));
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

  Future<APIResponse<List<School>>> getAllSchools() {
    return http.get(Uri.parse('${baseURL}api/account/getSchool')).then((data) {
      if (data.statusCode == 200) {
        // final jsonData = (jsonDecode(data.body)[0] as List)
        //     .map((e) => e as Map<String, dynamic>)
        //     .toList(); //
        final jsonData = jsonDecode(data.body);

        final account = <School>[];
        // print("from API: ${jsonData[0]}");
        // ignore: unused_local_variable
        for (var item in jsonData) {
          account.add(School.fromJson(item));
        }
        return APIResponse<List<School>>(
          data: account,
        );
      }
      return APIResponse<List<School>>(
          error: true, errorMessage: data.statusCode.toString());
    }).catchError((_) => APIResponse<List<School>>(
        error: true, errorMessage: "An error occured"));
  }

  Future<APIResponse<List<Department>>> getAllDepartmentsBySchool(
      int school_id) {
    return http
        .get(Uri.parse(
            '${baseURL}api/account/getDepartmentBySchoolID/$school_id'))
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = jsonDecode(data.body);
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
        if (data.body.isEmpty) {
          print("Not Found");
        } else {
          print("DATA ${data.body}");
          final jsonData = jsonDecode(data.body);
          return APIResponse<Account>(
            data: Account.fromJson(jsonData),
          );
        }
      }
      return APIResponse<Account>(
          error: true, errorMessage: data.statusCode.toString());
    }).catchError((_) => APIResponse<Account>(
            error: true, errorMessage: "An error occured"));
  }

  Future<APIResponse<bool>> createAccount(Account account) {
    // print(
    //     "${account.account_id}, ${account.approve}, ${account.departmentID} , ${account.departmentName} ${account.email}, ${account.first_name}, ${account.image}, ${account.last_name}, ${account.password}, ${account.roleID}");
    return http
        .post(Uri.parse('${baseURL}auth/signup'),
            headers: headers, body: json.encode(account.toJson()))
        .then((data) {
      print("ACC ${data.statusCode}");
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

  Future<APIResponse<bool>> addUserProfile(
      Files file, String department, String school, String accountID) async {
    var uri = Uri.parse(
        '${baseURL}image/upload-avatar/$school/$department/$accountID');
    var request = http.MultipartRequest('POST', uri);
    // request.files.add(
    //     await http.MultipartFile.fromPath('research_id', file.research_id));

    request.files.add(await http.MultipartFile.fromPath('file', file.file));
    // request.fields['url'] = file.url;
    var response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 201 || response.statusCode == 200) {
      return APIResponse<bool>(
        data: true,
      );
    }
    return APIResponse<bool>(
        error: true, errorMessage: response.statusCode.toString());
  }

  // Future<APIResponse<Uint8List>> getUserProfile(String id, String department) {
  //   return http
  //       .get(Uri.parse('${baseURL}image/download/$department/$id'),
  //           headers: headers)
  //       .then((data) {
  //     if (data.statusCode == 200) {
  //       dynamic blob = data.bodyBytes;
  //       Uint8List image = blob.buffer.asUint8List();

  //       return APIResponse<Uint8List>(
  //         data: image,
  //       );
  //     }

  //     return APIResponse<Uint8List>(
  //         error: true, errorMessage: data.statusCode.toString());
  //   }).catchError((_) => APIResponse<Uint8List>(
  //           error: true, errorMessage: "An error occured"));
  // }
  Future<APIResponse<Uint8List>> getUserProfile(
      String id, String department, String schoolName) {
    return http
        .get(Uri.parse('${baseURL}image/download/$schoolName/$department/$id'),
            headers: headers)
        .then((data) {
      print(data.statusCode);
      if (data.statusCode == 200) {
        dynamic blob = data.bodyBytes;
        Uint8List image = blob.buffer.asUint8List();

        return APIResponse<Uint8List>(
          data: image,
        );
      }
      print("STATUS ${data.statusCode}");
      return APIResponse<Uint8List>(
          error: true, errorMessage: data.statusCode.toString());
    }).catchError((_) => APIResponse<Uint8List>(
            error: true, errorMessage: "An error occured"));
  }

  // Future<APIResponse<String>> flaskTest(String id) {
  //   return http
  //       .get(Uri.parse("${baseURL2}api?query=$id"), headers: headers)
  //       .then((data) {
  //     if (data.statusCode == 200) {
  //       final jsonData = jsonDecode(data.body);
  //       return APIResponse<String>(
  //         data: jsonData.toString(),
  //       );
  //     }
  //     return APIResponse<String>(
  //         error: true, errorMessage: data.statusCode.toString());
  //   }).catchError((_) =>
  //           APIResponse<String>(error: true, errorMessage: "An error occured"));
  // }
}
