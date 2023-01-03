import 'dart:io';
import 'dart:math';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

ScaffoldFeatureController showSnackBarSucess(
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
