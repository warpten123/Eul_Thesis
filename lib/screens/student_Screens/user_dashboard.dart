import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:thesis_eul/screens/student_Screens/student_dashboard/content_userDashboard.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      // bottomNavigationBar: BottomAppBar(
      //   color: Colors.green,
      //   shape: CircularNotchedRectangle(),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: <Widget>[
      //       IconButton(onPressed: () {}, icon: Icon(Icons.home)),
      //       IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
      //     ],
      //   ),

      //   // items: [
      //   //   BottomNavigationBarItem(
      //   //     icon: Icon(
      //   //       Icons.home,
      //   //     ),
      //   //     label: 'Home',
      //   //   ),
      //   //   BottomNavigationBarItem(
      //   //     icon: Icon(Icons.upload_rounded),
      //   //     label: 'Home',
      //   //   ),
      //   //   BottomNavigationBarItem(
      //   //     icon: Icon(
      //   //       Icons.favorite,
      //   //     ),
      //   //     label: 'Home',
      //   //   ),
      //   // ],
      // ),
      body: ContentUserDashBoard(),
    ));
  }
}
