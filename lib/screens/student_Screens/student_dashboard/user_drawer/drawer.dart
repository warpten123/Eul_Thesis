import 'package:flutter/material.dart';

import '../../../login_screen.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );
  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      );
  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            ListTile(
              leading: const Icon(
                Icons.home_outlined,
                size: 30.0,
              ),
              title: const Text(
                "Home",
                style: TextStyle(fontSize: 22.0),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.book_sharp,
                size: 30.0,
              ),
              title: const Text("My Papers", style: TextStyle(fontSize: 22.0)),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.bookmark,
                size: 30.0,
              ),
              title: const Text("Bookmarks", style: TextStyle(fontSize: 22.0)),
              onTap: () {},
            ),
            const Divider(
              color: Colors.black54,
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                size: 30.0,
              ),
              title: const Text("Logout", style: TextStyle(fontSize: 22.0)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ));
              },
            ),
          ],
        ),
      );
}
