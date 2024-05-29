import 'dart:typed_data';

class TempAccount {
  String name;
  String title;
  Uint8List url;
  String account_id;
  int idType;
  TempAccount({
    required this.name,
    required this.title,
    required this.url,
    required this.account_id,
    required this.idType,
  });
}
