// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:thesis_eul/models/sdg.dart';

class SDGDescription extends StatelessWidget {
  final SDG sdg;
  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  SDGDescription(this.sdg);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Text(
            'SDG Description',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            sdg.description,
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 18, height: 1.5),
          ),
        ],
      ),
    );
  }
}
