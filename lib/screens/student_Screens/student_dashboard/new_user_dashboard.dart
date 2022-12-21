import 'package:flutter/material.dart';
import 'package:thesis_eul/models/AccountModel.dart';
import 'package:thesis_eul/screens/student_Screens/student_dashboard/department_list.dart';
import 'package:thesis_eul/screens/student_Screens/student_dashboard/file_upload/file_uploadDashboard.dart';
import 'package:thesis_eul/screens/student_Screens/student_dashboard/place_Item.dart';

import 'package:thesis_eul/screens/student_Screens/student_dashboard/place_gridview.dart';
import 'package:thesis_eul/screens/student_Screens/student_dashboard/profile_user/user_profile.dart';
import 'package:thesis_eul/screens/student_Screens/student_dashboard/search_screen.dart';

import 'user_drawer/drawer.dart';

class UserDashboardNew extends StatelessWidget {
  UserDashboardNew(this.account, {super.key});
  Account account;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amberAccent,
        drawer: NavigationDrawer(account),
        appBar: appBar(context),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              const SearchWidget(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'Search and Explore the repository!',
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    height: 1.3,
                    fontSize: 30,
                  ),
                ),
              ),
              Department_List(),
              // PlaceItem(),
              PlaceGridView(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          backgroundColor: Colors.green,
          splashColor: Colors.green,
          onPressed: () {
            // showDialog(
            //     context: context,
            //     builder: (context) {
            //       return Container(
            //         child: AlertDialog(
            //           // ignore: prefer_const_constructors
            //           title: Text(
            //             'Upload File',
            //             style: const TextStyle(
            //                 fontWeight: FontWeight.bold, fontSize: 20.0),
            //           ),
            //           content: IconButton(
            //             // ignore: prefer_const_constructors
            //             icon: Icon(
            //               Icons.upload,
            //               size: 50.0,
            //             ),
            //             onPressed: () {
            //               // pickFile();
            //             },
            //           ),
            //           actions: [
            //             TextButton(
            //                 onPressed: () {
            //                   Navigator.pop(context);
            //                 },
            //                 // ignore: prefer_const_constructors
            //                 child: Text('CANCEL',
            //                     style: const TextStyle(
            //                       fontSize: 18.0,
            //                     ))),
            //             TextButton(
            //                 onPressed: () {
            //                   Navigator.pop(context);
            //                 },
            //                 // ignore: prefer_const_constructors
            //                 child: Text('CONFIRM',
            //                     // ignore: prefer_const_constructors
            //                     style: TextStyle(
            //                       fontSize: 18.0,
            //                     ))),
            //           ],
            //         ),
            //       );
            //     });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const File_Upload()),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: BottomAppBar(
          color: Colors.green,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[],
          ),
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserProfile(account)),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              'assets/pj.jpg',
              width: 36,
            ),
          ),
        ),
      ],
    );
  }
}
