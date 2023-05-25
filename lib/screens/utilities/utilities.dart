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
    if (key == token[0]) {
      month = value;
    }

    // 5        Saturn
    // 4        Mars
    // 3        Earth
    // 6        Jupiter
  });
  newDate = "${token[2]}-$month-${token[1]}";
  return newDate;
}

Color getColor(String goal) {
  Map<String, Color> sdgGoals = HashMap();
  Color sdgColors = Colors.black;
  final data = {
    'Goal 1: No Poverty': const Color.fromARGB(255, 230, 36, 60),
    'Goal 2: Zero Hunger': const Color.fromARGB(255, 222, 165, 58),
    'Goal 3: Good Health and Well-Being':
        const Color.fromARGB(255, 79, 157, 56),
    'Goal 4: Quality Education': const Color.fromARGB(255, 197, 26, 45),
    'Goal 5: Gender Equality': const Color.fromARGB(255, 253, 57, 33),
    'Goal 6: Clean Water and Sanitation':
        const Color.fromARGB(255, 47, 185, 226),
    'Goal 7: Affordable and Clean Energy':
        const Color.fromARGB(255, 253, 194, 12),
    'Goal 8: Decent Work and Economic Growth':
        const Color.fromARGB(255, 162, 26, 66),
    'Goal 9: Industry, Innovation and Infrastructure':
        const Color.fromARGB(255, 255, 103, 38),
    'Goal 10: Reduced Inequalities': const Color.fromARGB(255, 222, 18, 105),
    'Goal 11: Sustainable Cities and Communities':
        const Color.fromARGB(255, 255, 156, 39),
    'Goal 12: Responsible Consumption and Production':
        const Color.fromARGB(255, 190, 139, 48),
    'Goal 13: Climate Action': const Color.fromARGB(255, 65, 124, 70),
    'Goal 14: Life Below Water': const Color.fromARGB(255, 12, 151, 220),
    'Goal 15: Life on Land': const Color.fromARGB(255, 87, 191, 40),
    'Goal 16: Peace, Justice and Strong Institutions':
        const Color.fromARGB(255, 0, 104, 157),
    'Goal 17: Partnership for the Goals':
        const Color.fromARGB(255, 25, 71, 105),
  };
  sdgGoals.addEntries(data.entries);
  sdgGoals.forEach((key, value) {
    print("$value");
    if (key == goal) {
      sdgColors = value;
    }
  });
  return sdgColors;
}

String getImageUrl(String goal) {
  final data = {
    'Goal 1: No Poverty': 'assets/1.png',
    'Goal 2: Zero Hunger': 'assets/2.png',
    'Goal 3: Good Health and Well-Being': 'assets/3.png',
    'Goal 4: Quality Education': 'assets/4.png',
    'Goal 5: Gender Equality': 'assets/5.png',
    'Goal 6: Clean Water and Sanitation': 'assets/6.png',
    'Goal 7: Affordable and Clean Energy': 'assets/7.png',
    'Goal 8: Decent Work and Economic Growth': 'assets/8.png',
    'Goal 9: Industry, Innovation, and Infrastructure': 'assets/9.png',
    'Goal 10: Reduced Inequalities': 'assets/10.png',
    'Goal 11: Sustainable Cities and Communities': 'assets/11.png',
    'Goal 12: Responsible Consumption and Production': 'assets/12.png',
    'Goal 13: Climate Action': 'assets/13.png',
    'Goal 14: Life Below Water': 'assets/14.png',
    'Goal 15: Life on Land': 'assets/15.png',
    'Goal 16: Peace, Justice and Strong Institutions': 'assets/16.png',
    'Goal 17: Partnership for the Goals': 'assets/17.png',
  };
  Map<String, String> getImage = HashMap();
  getImage.addEntries(data.entries);
  String url = "";
  getImage.forEach((key, value) {
    if (goal == key) {
      url = value;
    }
  });
  return url;
}
