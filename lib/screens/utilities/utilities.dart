import 'dart:collection';
import 'dart:io';
import 'dart:math';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:snack/snack.dart';
import '../student_Screens/student_dashboard/pdf_viewer/pdf_viewer.dart';

ScaffoldFeatureController showSnackBarError(BuildContext context, String text) {
  // final snackBar = SnackBar(
  //   content: Text(text),
  //   duration: const Duration(seconds: 2), //default is 4s
  // );
  // Find the Scaffold in the widget tree and use it to show a SnackBar.
  final snackBar = SnackBar(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'Aw snap!',
      message: text,

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      contentType: ContentType.failure,
    ),
  );
  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

ScaffoldFeatureController showSnackBarSuccess(
    BuildContext context, String text) {
  // final snackBar = SnackBar(
  //   content: Text(text),
  //   duration: const Duration(seconds: 2), //default is 4s
  // );
  // Find the Scaffold in the widget tree and use it to show a SnackBar.
  final snackBar = SnackBar(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'Information!',
      message: text,

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      contentType: ContentType.success,
    ),
  );
  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

String generatePassword() {
  String password;
  var rnd = Random();

  String year = "2020", rndNumber = "";
  for (var i = 0; i < 6; i++) {
    rndNumber = rndNumber + rnd.nextInt(9).toString();
  }
  password = year + rndNumber;
  return password;
}

int generateCommentID() {
  String comment;
  var rnd = Random();

  String start = "5000", rndNumber = "";
  for (var i = 0; i < 5; i++) {
    rndNumber = rndNumber + rnd.nextInt(9).toString();
  }
  comment = start + rndNumber;

  return int.parse(comment);
}

String generateID() {
  String id;
  var rnd = Random();

  String year = "1000", rndNumber = "";
  for (var i = 0; i < 10; i++) {
    rndNumber = rndNumber + rnd.nextInt(9).toString();
  }
  id = year + rndNumber;
  return id;
}

void openPDF(BuildContext context, String file) => Navigator.of(context)
    .push(MaterialPageRoute(builder: (context) => PDFViewerWidget(file)));

String convertDate(String date) {
  //convert to yyyy/mm/dd
  String newDate = "";
  date = date.replaceAll(",", "");
  final token = date.split(" ");
  String month = "";
  final Map<String, String> months = HashMap(); // Is a HashMap
  // final  data = {
  //   'January': 01,'Febuary','March','April','May','June','July','August',
  //   'September','October','November','December'
  // };
  final data = {
    'January': '01',
    'Febuary': '02',
    'March': '03',
    'April': '04',
    'May': '05',
    'June': '06',
    'July': '07',
    'August': '08',
    'September': '09',
    'October': '10',
    'November': '11',
    'December': '12',
  };
  months.addEntries(data.entries);
  months.forEach((key, value) {
    print('$key \t $value');
    if (key == token[0]) {
      month = value;
    }

    // 5        Saturn
    // 4        Mars
    // 3        Earth
    // 6        Jupiter
  });
  newDate = "${token[2]}-$month-${token[1]}";
  print(newDate);
  return newDate;
}
