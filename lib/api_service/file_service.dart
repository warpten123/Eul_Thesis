import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:io'; // for File
import 'package:thesis_eul/api_service/api_response.dart';
import 'package:thesis_eul/models/Files.dart';
import 'package:path_provider/path_provider.dart';



class FileService {
  static const baseURL = 'http://10.0.2.2:3000/';
  static const headers = {
    'apiKey': 'abaf3c8e-72c0-498b-9862-47afad7add14',
    'Content-Type': 'application/json'
  };
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
    var uri =
        Uri.parse('http://10.0.2.2:3000/file/upload-file/${file.research_id}');
    var request = http.MultipartRequest('POST', uri);
    // request.files.add(
    //     await http.MultipartFile.fromPath('research_id', file.research_id));

    request.files.add(await http.MultipartFile.fromPath('file', file.file));
    request.fields['url'] = file.url;
    var response = await request.send();

    if (response.statusCode == 201 || response.statusCode == 200) {
      return APIResponse<bool>(
        data: true,
      );
    }
    return APIResponse<bool>(
        error: true, errorMessage: response.statusCode.toString());
  }

  Future<APIResponse<Uint8List>> getResearchFile(String id) {
    return http
        .get(Uri.parse('${baseURL}file/download/$id'), headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        dynamic blob = data.bodyBytes;
        Uint8List image = blob.buffer.asUint8List();
        return APIResponse<Uint8List>(
          data: image,
        );
      }

      return APIResponse<Uint8List>(
          error: true, errorMessage: data.statusCode.toString());
    }).catchError((_) => APIResponse<Uint8List>(
            error: true, errorMessage: "An error occured"));
  }
}
