// ignore_for_file: avoid_unnecessary_containers
import 'package:flutter/material.dart';


import '../../../../models/sdg.dart';
import '../content_userDashboard.dart';

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
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContentUserDashBoard(sdg),
              ));
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
