import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thesis_eul/models/research_details.dart';
import 'package:thesis_eul/screens/student_Screens/student_dashboard/profile_user/appBar.dart';

import '../../../../models/AccountModel.dart';

class UserProfile extends StatefulWidget {
  UserProfile(this.account, {super.key});
  Account account;
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final double height = 280;
  final double profileHeight = 144;

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return SafeArea(
        child: Scaffold(
      // appBar: buildAppBar(context),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          stack(),
          content(),
        ],
      ),
    ));
  }

  Widget content() {
    return Column(
      // ignore: prefer_const_literals_to_create_immutables
      children: <Widget>[
        const SizedBox(
          height: 8,
        ),
        Text(
          '${widget.account.first_name} ${widget.account.last_name}',
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          widget.account.departmentID.toString(),
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            socialIcon(FontAwesomeIcons.github),
            const SizedBox(width: 12),
            socialIcon(FontAwesomeIcons.researchgate),
            const SizedBox(width: 12),
            socialIcon(FontAwesomeIcons.linkedin),
          ],
        ),
        const SizedBox(width: 12),
        const Divider(),
        const SizedBox(width: 12),
        numbersWidget(),
        const SizedBox(width: 12),
        const Divider(),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget numbersWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[],
    );
  }

  Widget socialIcon(IconData icon) {
    return CircleAvatar(
      radius: 25,
      child: Material(
        shape: const CircleBorder(),
        clipBehavior: Clip.hardEdge,
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Center(
            child: Icon(
              icon,
              size: 32,
            ),
          ),
        ),
      ),
    );
  }

  Widget stack() {
    final bottom = profileHeight / 2;
    final top = height - profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(margin: EdgeInsets.only(bottom: bottom), child: coverImage()),
        Positioned(top: top, child: profilePicture()),
        Positioned(
            left: 10,
            top: MediaQuery.of(context).padding.top,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                // ignore: prefer_const_constructors
                child: Icon(Icons.arrow_back),
              ),
            )),
      ],
    );
  }

  Widget coverImage() {
    return Container(
      color: Colors.grey,
      child: Image.asset(
        'assets/usjr2.jpg',
        width: double.infinity,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget profilePicture() {
    return CircleAvatar(
      radius: profileHeight / 2,
      backgroundColor: Colors.grey.shade800,
      // ignore: prefer_const_constructors
      backgroundImage: NetworkImage(
          "https://drive.google.com/uc?export=view&id=1U_BiAs3u3Nuz4d8BBtjSISWWEoYo-dzK"),
    );
  }
}
