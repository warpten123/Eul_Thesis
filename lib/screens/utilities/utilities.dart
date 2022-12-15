import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../student_Screens/student_dashboard/pdf_viewer/pdf_viewer.dart';

ScaffoldFeatureController showSnackBar(BuildContext context, String text) {
  final snackBar = SnackBar(
    content: Text(text),
    duration: const Duration(seconds: 2), //default is 4s
  );
  // Find the Scaffold in the widget tree and use it to show a SnackBar.
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

void openPDF(BuildContext context, File file) => Navigator.of(context)
    .push(MaterialPageRoute(builder: (context) => PDFViewerWidget(file)));
