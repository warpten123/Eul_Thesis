import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../models/AccountModel.dart';
import 'file_upload/file_uploadDashboard.dart';

class Test extends StatefulWidget {
  Test(this.account, {super.key});

  Account account;

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Spacer(),
                Image.asset(
                  "assets/upload5.png",
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Start your journey \nwith EUL",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Upload and let your paper be \nSDG Classified!",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 18),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          //file upload
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  File_Upload(widget.account)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 8.0)),
                      child: const Text("Get Started"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
