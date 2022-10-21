import 'package:flutter/material.dart';
import 'package:thesis_eul/models/research.dart';
import 'package:thesis_eul/models/research_details.dart';
import 'package:thesis_eul/screens/student_Screens/student_dashboard/research_list/research_button_download.dart';
import 'package:thesis_eul/screens/student_Screens/student_dashboard/research_list/research_button_view.dart';

import '../../../../models/sdg.dart';

class Research_Details extends StatelessWidget {
  final SDG sdg;
  final ResearchDetails researchDetails;
  const Research_Details(this.sdg, this.researchDetails, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(researchDetails.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
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
                  '${researchDetails.authors[0]}, ${researchDetails.authors[1]}'),
              trailing: const Text("15 Pages"),
            ),
            const Text('Topics in this paper...'),
            //here scroll row from left to right
            // end scroll
            const ListTile(
              title: Text('Abstract of the Study'),
              subtitle: Text('Aria ang abstract.'),
            ),
            DetailsDownload(sdg),
            DetailsRead(sdg),
          ],
        ),
      ),
    );
  }
}
