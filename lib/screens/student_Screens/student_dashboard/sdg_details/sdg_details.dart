import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:thesis_eul/models/sdg.dart';
import 'package:thesis_eul/screens/student_Screens/student_dashboard/sdg_details/header_details.dart';
import 'package:thesis_eul/screens/student_Screens/student_dashboard/sdg_details/sdg_description.dart';
import 'package:thesis_eul/screens/student_Screens/student_dashboard/sdg_details/sdg_icon_list.dart';
import 'package:thesis_eul/screens/student_Screens/student_dashboard/sdg_details/sdg_name.dart';
import 'package:thesis_eul/screens/student_Screens/student_dashboard/sdg_details/sdg_view_button.dart';

class SDGDetails extends StatelessWidget {
  final SDG sdg;

  // ignore: use_key_in_widget_constructors, prefer_const_constructors_in_immutables
  SDGDetails(this.sdg);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return SafeArea(
      child: Scaffold(
        // ignore: prefer_const_constructors
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SDGHeader(sdg),
              SDGName(sdg),
              SDGDescription(sdg),
              SDGIconList(),
              SDGButton(),
            ],
          ),
        ),
      ),
    );
  }
}
