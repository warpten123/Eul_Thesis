import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:thesis_eul/api_service/research_service.dart';
import 'package:thesis_eul/screens/student_Screens/student_dashboard/user_bookmarks/user_bookmarks.dart';
import 'package:thesis_eul/screens/student_Screens/student_dashboard/user_library/user_research_dashboard.dart';

import '../../../../api_service/api_response.dart';
import '../../../../models/AccountModel.dart';
import '../../../../models/research_details.dart';
import '../../../login_screen.dart';

class NavigationDrawer extends StatelessWidget {
  NavigationDrawer(this.loggedAccount, {super.key});
  Account loggedAccount;
  late List<ResearchDetails> research;
  ResearchService get resService => GetIt.instance<ResearchService>();
  late APIResponse<List<ResearchDetails>> _apiResponseRes;
  Future<APIResponse<List<ResearchDetails>>> getUserLibrary(
      String schoolID) async {
    return _apiResponseRes = await resService.getUserLibray(schoolID);
  }

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
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.book_sharp,
                size: 30.0,
              ),
              title: const Text("My Papers", style: TextStyle(fontSize: 22.0)),
              onTap: () async {
                Navigator.pop(context);
                // final result = await getUserLibrary(loggedAccount.school_id!);
                // research = result.data!;
                // print(research.length);
                // ignore: use_build_context_synchronously
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UserLibrary(loggedAccount.school_id!),
                    ));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.bookmark,
                size: 30.0,
              ),
              title: const Text("Bookmarks", style: TextStyle(fontSize: 22.0)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UserBookmarks(loggedAccount.school_id!),
                    ));
              },
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
