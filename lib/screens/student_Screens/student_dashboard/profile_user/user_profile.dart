// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';

import 'package:thesis_eul/screens/utilities/utilities.dart';

import '../../../../api_service/api_response.dart';
import '../../../../api_service/research_service.dart';
import '../../../../api_service/user_service.dart';
import '../../../../models/AccountModel.dart';
import '../../../../models/research_details.dart';

class UserProfile extends StatefulWidget {
  UserProfile(this.account, this.url, {super.key});
  Account account;
  Uint8List url;
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  ResearchService get resService => GetIt.instance<ResearchService>();
  UserService get userService => GetIt.instance<UserService>();
  // ignore: unused_field
  late int numberOfResearch = 0;
  late int numberOfBookmarks = 0;
  late APIResponse<List<Account>> _apiResponse;
  late APIResponse<bool> _apiResponseUpdate;
  late APIResponse<Uint8List> _apiResponseProfile;
  late List<Account> allAccounts;
  Future<APIResponse<List<Account>>> getAllAccounts() async {
    return _apiResponse = await userService.getAllAccounts();
  }

  Future<APIResponse<bool>> updateAccount(Account account) async {
    return _apiResponseUpdate = await userService.updateAccount(account);
  }

  Future<APIResponse<Uint8List>> getProfile(String schoold_id) async {
    return _apiResponseProfile = await userService.getUserProfile(schoold_id);
  }

  late List<ResearchDetails> userBookMarks;
  Future<APIResponse<List<ResearchDetails>>> getUserBookmarks(
      String school_id) async {
    late APIResponse<List<ResearchDetails>> _apiResponseRes;
    return _apiResponseRes = await resService.getUserBookmarks(school_id);
  }

  Future<APIResponse<List<ResearchDetails>>> getUserLibrary(
      String schoolID) async {
    late APIResponse<List<ResearchDetails>> _apiResponseRes;
    return _apiResponseRes = await resService.getUserLibray(schoolID);
  }

  bool isUpdate = false;
  bool isCancel = false;

  late String dept;
  late String test;
  late String test2;
  late String test3;
  String firstName = "";
  String lastName = "";
  String id = "";
  bool testPic = false;

  @override
  void initState() {
    super.initState();

    switch (widget.account.departmentID) {
      case 1:
        dept = "School of Law";
        break;
      case 2:
        dept = "School of Business and Management";
        break;
      case 3:
        dept = "School of Computer Studies";
        break;
      case 4:
        dept = "Senior High School";
        break;
      case 5:
        dept = "School of Arts and Sciences";
        break;
      case 6:
        dept = "RITTC";
        break;
      case 7:
        dept = "School of Allied Medical Sciences";
        break;
      case 8:
        dept = "School of Engineering";
        break;
      case 9:
        dept = "School of Education";
        break;
    }
    getAccounts();
    getAllBookmarks();
    getAllResearch();
  }

  @override
  void dispose() {
    firstName_Controller.dispose();
    lastName_Controller.dispose();
    email_Controller.dispose();

    super.dispose();
  }

  void getAllResearch() async {
    final result = await getUserLibrary(widget.account.school_id!);
    numberOfResearch = result.data!.length;
  }

  void getAllBookmarks() async {
    final result = await getUserBookmarks(widget.account.school_id!);
    numberOfBookmarks = result.data!.length;
  }

  void getAccounts() async {
    try {
      final result = await getAllAccounts();
      allAccounts = result.data!;
      for (int i = 0; i < allAccounts.length; i++) {
        if (allAccounts[i].school_id == widget.account.school_id) {
          finalAccount = allAccounts[i];
        }
      }
      setState(() {
        firstName_Controller.text = finalAccount.first_name;
        lastName_Controller.text = finalAccount.last_name;
        email_Controller.text = finalAccount.email;
        firstName = finalAccount.first_name;
        lastName = finalAccount.last_name;
        id = finalAccount.school_id!;
        test = firstName_Controller.text;
        test2 = lastName_Controller.text;
        test3 = email_Controller.text;
      });
      // ignore: empty_catches
    } catch (e) {
      showSnackBarError(context, "Error Getting User Information!");
    }

    // password_Controller.text = finalAccount.password!;
  }

  void checkForChanges(TextEditingController t1, TextEditingController t2,
      TextEditingController t3) {
    if (test != t1.text || test2 != t2.text || test3 != t3.text) {
      listenChanges = true;
    } else {
      listenChanges = false;
    }
  }

  late Account finalAccount;
  final double height = 280;
  final double profileHeight = 144;
  final firstName_Controller = TextEditingController();
  final lastName_Controller = TextEditingController();
  final email_Controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool listenChanges = false;
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
          '$firstName $lastName',
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          dept,
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
        const SizedBox(width: 12),
        const Divider(),
        Visibility(visible: !isUpdate, child: NumbersWidget()),
        const SizedBox(width: 12),
        const Divider(),
        const SizedBox(
          height: 16,
        ),
        Visibility(
          visible: isUpdate,
          child: EditForm(),
        ),
        isUpdate == false
            ? SubmitButton("UPDATE PROFILE")
            : SubmitButton("SUBMIT"),
        const SizedBox(
          height: 16,
        ),
        isUpdate == true ? SubmitButtonCancel("CANCEL") : Container(),
      ],
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
      backgroundImage: MemoryImage(widget.url),
    );
  }

  Widget NumbersWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Divider(),
        NumberButton(text: "Papers", value: numberOfResearch),
        NumberDivider(),
        NumberButton(text: "Bookmarks", value: numberOfBookmarks),
        NumberDivider(),
        NumberButton(text: "Citations", value: 10),
      ],
    );
  }

  Widget NumberButton({required String text, required int value}) {
    return MaterialButton(
      onPressed: () {},
      padding: const EdgeInsets.symmetric(vertical: 4),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[
          Text(
            "$value",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 2),
          Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget NumberDivider() {
    // ignore: sized_box_for_whitespace
    return Container(
      height: 24,
      child: const VerticalDivider(),
    );
  }

  Widget EditForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[
          TextFieldWidget("First Name", false, firstName_Controller),
          const SizedBox(
            height: 12,
          ),
          TextFieldWidget("Last  Name", false, lastName_Controller),
          const SizedBox(
            height: 12,
          ),
          TextFieldWidget("Email", false, email_Controller),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }

  Widget TextFieldWidget(
      String text, bool isObscure, TextEditingController controller) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(left: 40, right: 40),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Required Field';
          }
          return null;
        },
        enableInteractiveSelection: true,
        controller: controller,
        obscureText: isObscure,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          labelText: text,
          labelStyle: TextStyle(color: Colors.grey.shade500),
          filled: true,
          // fillColor: const Color(0xff161d27).withOpacity(0.9),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.green),
          ),
        ),
      ),
    );
  }

  Widget SubmitButton(String text) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      margin: const EdgeInsets.only(left: 40, right: 40),
      child: TextButton(
          onPressed: () async {
            // ignore: use_build_context_synchronously

            checkForChanges(
                firstName_Controller, lastName_Controller, email_Controller);
            setState(() {
              testPic = true;
              if (isUpdate == false) {
                isUpdate = true;
              } else if ((isUpdate)) {
                if (!listenChanges) {
                  showSnackBarSucess(context, "No Changes!");
                  isUpdate = false;
                  listenChanges = false;
                }
              }
              getAccounts();
            });
            if (listenChanges && isUpdate) {
              if (_formKey.currentState!.validate()) {
                Account payload = Account(
                    school_id: finalAccount.school_id,
                    first_name: firstName_Controller.text,
                    last_name: lastName_Controller.text,
                    email: email_Controller.text,
                    departmentID: finalAccount.departmentID,
                    role_roleID: 1);

                final result = await updateAccount(payload);

                // ignore: use_build_context_synchronously
                showSnackBarSucess(context, "Profile Updated! ");
                setState(() {
                  getAccounts();
                  isUpdate = false;
                  listenChanges = false;
                });
              }
            }
          },
          child: Text(text,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18))),
    );
  }

  Widget SubmitButtonCancel(String text) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      margin: const EdgeInsets.only(left: 40, right: 40),
      child: TextButton(
          onPressed: () async {
            print(listenChanges);
            setState(() {
              isUpdate = false;
              getAccounts();
            });
          },
          child: Text(text,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18))),
    );
  }
}
