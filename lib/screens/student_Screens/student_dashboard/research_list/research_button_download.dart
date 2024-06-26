// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../models/sdg.dart';
import '../content_userDashboard.dart';
import 'research_list.dart';

class DetailsDownload extends StatelessWidget {
  final SDG sdg;
  final String id;
  const DetailsDownload(this.sdg, this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 30, top: 20),
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContentUserDashBoard(sdg, id),
              ));
        },
        child: Container(
          // ignore: prefer_const_constructors
          padding: EdgeInsets.symmetric(vertical: 16),
          // ignore: prefer_const_constructors
          child: Text(
            'Download PDF',
            // ignore: prefer_const_constructors
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
