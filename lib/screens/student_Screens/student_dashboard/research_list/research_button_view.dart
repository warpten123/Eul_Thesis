import 'dart:io';

import 'package:flutter/material.dart';
import 'package:thesis_eul/api_service/research_service.dart';
import 'package:thesis_eul/screens/student_Screens/student_dashboard/pdf_viewer/pdf_viewer.dart';
import 'package:thesis_eul/screens/utilities/utilities.dart';

import '../../../../models/sdg.dart';

class DetailsRead extends StatelessWidget {
  final SDG sdg;
  const DetailsRead(this.sdg, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 30, top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () async {
          final file = await ResearchService.pickFile();
          print("THIS IS FILE $file");
          if (file == null) return;
          // ignore: use_build_context_synchronously
          openPDF(context, file.path);
        },
        child: Container(
          // ignore: prefer_const_constructors
          padding: EdgeInsets.symmetric(vertical: 16),
          // ignore: prefer_const_constructors
          child: Text(
            'Read Paper',
            // ignore: prefer_const_constructors
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
