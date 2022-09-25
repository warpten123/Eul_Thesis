import 'package:flutter/material.dart';
import 'package:thesis_eul/screens/student_Screens/student_dashboard/department_list.dart';

import 'package:thesis_eul/screens/student_Screens/student_dashboard/place_gridview.dart';
import 'package:thesis_eul/screens/student_Screens/student_dashboard/search_screen.dart';

class UserDashboardNew extends StatelessWidget {
  const UserDashboardNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          showDialog(
              context: context,
              builder: (context) {
                return Container(
                  child: AlertDialog(
                    // ignore: prefer_const_constructors
                    title: Text(
                      'Upload File',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    content: IconButton(
                      // ignore: prefer_const_constructors
                      icon: Icon(
                        Icons.upload,
                        size: 50.0,
                      ),
                      onPressed: () {
                        // pickFile();
                      },
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          // ignore: prefer_const_constructors
                          child: Text('CANCEL',
                              style: const TextStyle(
                                fontSize: 18.0,
                              ))),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          // ignore: prefer_const_constructors
                          child: Text('CONFIRM',
                              // ignore: prefer_const_constructors
                              style: TextStyle(
                                fontSize: 18.0,
                              ))),
                    ],
                  ),
                );
              });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.green,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.home),
              iconSize: 30.0,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite),
              iconSize: 30.0,
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.menu),
      ),
      actions: [
        Container(
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
      ],
    );
  }
}
