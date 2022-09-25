import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:thesis_eul/models/sdg.dart';

class SDGName extends StatelessWidget {
  final SDG sdg;
  SDGName(this.sdg);

  @override
  Widget build(BuildContext context) {
    return Container(
      // ignore: prefer_const_constructors
      padding: EdgeInsets.only(top: 30, bottom: 20, left: 30, right: 30),
      // ignore: prefer_const_constructors

      decoration: const BoxDecoration(
        color: Colors.grey,
        // ignore: unnecessary_const
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(36),
          // ignore: unnecessary_const
          bottomRight: const Radius.circular(36),
        ),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                // ignore: prefer_const_constructors
                Text(
                  sdg.name,
                  // ignore: prefer_const_constructors
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                // ignore: prefer_const_constructors
                Text(
                  sdg.goal,
                  // ignore: prefer_const_constructors
                  style: TextStyle(fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Row(
            // ignore: prefer_const_constructors
            children: [
              Icon(Icons.book),
              Text(
                sdg.subtitle.toString(),
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ],
      ),
    );
  }
}
