import 'package:flutter/material.dart';
import 'package:thesis_eul/models/research.dart';
import 'package:thesis_eul/models/research_details.dart';
import 'package:thesis_eul/screens/student_Screens/student_dashboard/research_list/research_button_download.dart';
import 'package:thesis_eul/screens/student_Screens/student_dashboard/research_list/research_button_view.dart';

import '../../../../models/sdg.dart';

// ignore: camel_case_types
class Research_Details extends StatelessWidget {
  final SDG sdg;
  final ResearchDetails researchDetails;
  const Research_Details(this.sdg, this.researchDetails, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        title: Text(researchDetails.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Image.asset(
                  sdg.image,
                  height: 80,
                  width: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(researchDetails.title),
                subtitle: Text(
                    '${researchDetails.sdg_category[0]}, ${researchDetails.sdg_category[1]}'),
                trailing: const Text("15 Pages"),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(''),
              const SizedBox(
                height: 20,
              ),
              //here scroll row from left to right
              // end scroll
              ListTile(
                isThreeLine: true,
                title: const Text('Abstract of the Study'),
                subtitle: Text(researchDetails.abstract),
              ),
              ListTile(
                isThreeLine: true,
                title: const Text('Date Published'),
                subtitle: Text(researchDetails.date_published),
              ),
              ListTile(
                isThreeLine: true,
                title: const Text('Research Adviser'),
                subtitle: Text(researchDetails.adviser),
              ),
              DetailsDownload(sdg),
              DetailsRead(sdg),
            ],
          ),
        ),
      ),
    );
  }
}
