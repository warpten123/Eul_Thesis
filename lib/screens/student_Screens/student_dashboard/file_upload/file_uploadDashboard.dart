// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: file_names
// ignore_for_file: prefer_const_constructors

import 'dart:collection';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:thesis_eul/api_service/algorithn_service.dart';
import 'package:thesis_eul/api_service/file_service.dart';
import 'package:thesis_eul/models/AccountModel.dart';
import 'package:thesis_eul/models/research_details.dart';
import 'package:thesis_eul/screens/student_Screens/student_dashboard/file_upload/dialog.dart';
import 'package:thesis_eul/screens/student_Screens/student_dashboard/file_upload/review.dart';
import 'package:thesis_eul/screens/utilities/utilities.dart';

import '../../../../api_service/api_response.dart';
import '../../../../api_service/research_service.dart';
import '../../../../api_service/user_service.dart';
import '../../../../models/Files.dart';

List<String> author_title = ["author", "adviser", "co-author"];

class TempAccount {
  String name;
  String title;
  Uint8List url;
  String account_id;
  int idType;
  TempAccount({
    required this.name,
    required this.title,
    required this.url,
    required this.account_id,
    required this.idType,
  });
}

class File_Upload extends StatefulWidget {
  File_Upload(this.account, {super.key});
  Account account;
  @override
  State<File_Upload> createState() => _File_UploadState();
}

class _File_UploadState extends State<File_Upload> {
  Color universal = Colors.red;
  @override
  void initState() {
    super.initState();
    currentStep = 0;
  }

  String? date = "Date Published";
  showDatePicker(BuildContext context) async {
    bool go = false;
    //DateTime date;
    newDateTime = await showRoundedDatePicker(
      context: context,
      initialDate: DateTime.now(),
      // initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(DateTime.now().year),
      //lastDate: DateTime(DateTime.now().year),
      borderRadius: 16,
      theme: ThemeData(
        accentColor: Colors.green,
        dialogBackgroundColor: Colors.green[50],
        disabledColor: Colors.red,
      ),
      imageHeader: const AssetImage("assets/usjr2.jpg"),
      textPositiveButton: "SAVE",
      textNegativeButton: "",
    );

    setState(() {
      researchDate = DateFormat("yyyy-MM-dd").format(newDateTime!);
    });
  }

  late APIResponse<bool> _apiResponse;
  int currentStep = 0;
  final researchTitle = TextEditingController();
  final researchDepartment = TextEditingController();
  late String researchDate = " ";
  final researchAdviser = TextEditingController();
  final researchAbstract = TextEditingController();
  final researchAuthors = TextEditingController();
  final findAccount = TextEditingController();
  final keyPhrases = TextEditingController();
  final searchAccountContoller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<Color> color = [];
  List<String> url = [];
  String titleAuthor = " ";
  List<dynamic> finalGoal = [];

  bool upload = false;
  var baseName;
  var file = null;
  var resultResearch;
  List<TempAccount> tempAccounts = [];
  List<MapEntry<String, dynamic>> sortedEntries = [];
  DateTime? newDateTime;
  String resID = "";
  ResearchService get resService => GetIt.instance<ResearchService>();
  FileService get fileService => GetIt.instance<FileService>();
  AlgorithmService get algoService => GetIt.instance<AlgorithmService>();
  bool isExtractNames = false;
  bool isExtractAbstract = false;
  bool isExtractPhrases = false;
  bool isClassify = false;
  bool isAddResearch = false;
  bool isAccept = false;
  bool isFoundAccount = false;
  bool submitDisplay = false;
  int idType = 0;
  UserService get userService => GetIt.instance<UserService>();
  final _formKeyForAccount = GlobalKey<FormState>();
  // ignore: unused_field
  late APIResponse<Account> _apiResponseAccount;
  Future<APIResponse<bool>> fileUploadFlask(Files file) async {
    APIResponse<bool> reponse;
    return await fileService.fileUploadToFlask(file);
  }

  late APIResponse<Uint8List> _apiResponseProfile;
  Future<APIResponse<bool>> fileUploadNode(Files file) async {
    APIResponse<bool> reponse;
    return await fileService.fileUpload(
        file, widget.account.departmentName!, widget.account.schoolName!);
  }

  Future<APIResponse<Uint8List>> getProfile(
      String schoold_id, String department, String schoolName) async {
    return _apiResponseProfile =
        await userService.getUserProfile(schoold_id, department, schoolName);
  }

  Future<APIResponse<Map<String, dynamic>>> extractInformation(
      String fileName) async {
    return await algoService.extractInformation(fileName);
  }

  Future<APIResponse<List<dynamic>>> extractKeyPhrases(String fileName) async {
    return await algoService.getKeyPhrases(fileName);
  }

  Future<APIResponse<Map<String, dynamic>>> extractAbstract(
      String fileName) async {
    return await algoService.extractAbstract(fileName);
  }

  Future<APIResponse<Map<String, dynamic>>> classifyResearch(
      String fileName) async {
    return await algoService.classifyResearch(fileName);
  }

  Future<APIResponse<Map<String, dynamic>>> checkAcceptance(
      String fileName) async {
    return await algoService.checkAcceptance(fileName);
  }

  Future<APIResponse<bool>> addResearch(ResearchDetails researchDetails) async {
    // ignore: unused_local_variable
    APIResponse<bool> reponse;
    return reponse = await resService.addResearch(researchDetails);
  }

  Future<APIResponse<bool>> addResearchList(
      String research_id, String student_id) async {
    // ignore: unused_local_variable
    APIResponse<bool> reponse;
    return reponse = await resService.addResearchList(research_id, student_id);
  }

  Future<APIResponse<bool>> addAuthored(
      String resID, String schoolID, int idType) async {
    // ignore: unused_local_variable
    APIResponse<bool> reponse;
    return reponse = await resService.addAuthored(resID, schoolID, idType);
  }

  Future<APIResponse<bool>> addSDG(
      String resID, int sdgID, double sdgScore) async {
    // ignore: unused_local_variable
    APIResponse<bool> reponse;
    return reponse = await resService.addSDGs(resID, sdgID, sdgScore);
  }

  Future<APIResponse<Account>> getStudentByID(String id) async {
    return _apiResponseAccount = await userService.getStudentByID(id);
  }

  bool check = false;
  bool display = false;
  void searchAccount() async {
    bool go = false;
    final resultAccount = await getStudentByID(findAccount.text);
    if (resultAccount.data != null) {
      print("huh");
      setState(() {
        check = true;
        isFoundAccount = true;
        var temp =
            // ignore: prefer_interpolation_to_compose_strings
            resultAccount.data!.last_name +
                " " +
                resultAccount.data!.first_name;
        searchAccountContoller.text = temp;
      });
    } else {
      display = true;
      submitDisplay = true;
    }
  }

  void addInTemp(BuildContext context) async {
    final resultAccountNew = await getStudentByID(findAccount.text);
    bool go = false;
    final resultUrl = await getProfile(
        resultAccountNew.data!.account_id!,
        resultAccountNew.data!.departmentName!,
        resultAccountNew.data!.schoolName!);
    setState(() {
      final temp = TempAccount(
        name: searchAccountContoller.text,
        title: titleAuthor,
        url: resultUrl.data!,
        account_id: resultAccountNew.data!.account_id!,
        idType: idType,
      );
      if (tempAccounts.isNotEmpty) {
        for (int i = 0; i < tempAccounts.length; i++) {
          if (tempAccounts[i].name == searchAccountContoller.text) {
            print("${tempAccounts[i].name} == ${searchAccountContoller.text}");
            go = false;
            break;
          } else {
            go = true;
          }
        }
      } else {
        go = true;
      }

      if (go == false) {
        showAlertDialogRegistration(context, "User already added!");
      } else {
        tempAccounts.add(temp);
      }

      // Wrap the relevant code with setState to trigger rebuild
    });
  }

  showAlertDialogRegistration(BuildContext context, String message) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Okay"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Error",
        style: TextStyle(color: Colors.red),
      ),
      content: Text(message),
      actions: [
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  List<Account> listOfAccounts = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   title: const Text('Research Upload'),
        // ),
        body: Stepper(
          controlsBuilder: (BuildContext context, ControlsDetails controls) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            );
          },
          type: StepperType.horizontal,
          steps: getSteps(context),
          currentStep: currentStep,
          onStepContinue: () {
            final isLastStep = currentStep == getSteps(context).length - 1;
            setState(() {
              if (isLastStep) {
              } else {
                currentStep += 1;
              }
            });
          },
          onStepCancel: () {
            setState(() {
              if (currentStep != 0) {
                currentStep -= 1;
              }
            });
          },
        ),
      ),
    );
  }

  Files uploadFunc(File files) {
    Files payload = Files(file: files.path, research_id: resID, url: file.path);
    return payload;
  }

  void extractNamesFromPDF(String fileName) async {
    final result = await extractInformation(fileName);

    if (result.data != null) {
      setState(() {
        researchTitle.text = result.data!['title'];
        researchDepartment.text = result.data!['department'];
        researchDate = result.data!['published_date'];
        researchAuthors.text = result.data!['authors'];
        researchDate = convertDate(researchDate);
        isExtractNames = true;
      });
    }
  }

  void extractAbstractFromPDF(String fileName) async {
    final result = await extractAbstract(fileName);

    if (result.data != null) {
      researchAbstract.text = result.data!['abstract'];
      isExtractAbstract = true;
    }
  }

  List<dynamic> finalKeyPhrases = [];
  void extractKeyPhrasesFunc(String fileName, BuildContext context) async {
    final result = await extractKeyPhrases(fileName);

    if (result.data != null) {
      finalKeyPhrases = result.data!;
      keyPhrases.text = finalKeyPhrases.join(', ');
      isExtractPhrases = true;
      // ignore: use_build_context_synchronously
      setState(() {
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        showSnackBarSuccess(context, 'Research Information Extracted');
        currentStep += 1;
      });
    }
  }

  bool isLoadingAcceptance = false;
  Future<bool> checkPDF(String fileName) async {
    bool checker;
    final resultCheck = await checkAcceptance(baseName);
    checker = resultCheck.data!['result'];
    setState(() {
      isLoadingAcceptance = true;
    });
    return checker;
  }

  void addResDetails(ResearchDetails details, BuildContext context) async {
    bool go = false;

    resultResearch = await addResearch(details);

    // final resultAuthored = await addAuthored(
    //     resID, widget.account.school_id!)
    // ignore: use_build_context_synchronously
  }

  Map<String, dynamic> shit = {};
  var data = {};
  late Files payload;
  List<Step> getSteps(context) => [
        Step(
          isActive: currentStep >= 0,
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          title: const Text('Upload'),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  "The first step of your journey with us!",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () async {
                    file = await FileService.pickFile();
                    if (file == null) return;
                    setState(() {
                      baseName = basename(file!.path);
                    });
                  },
                  child: baseName == null
                      ? Container(
                          height: 300,
                          width: 300,
                          decoration: BoxDecoration(),
                          child: Image.asset("assets/new_upload.png"),
                        )
                      : Container(),
                ),
                SizedBox(
                  height: 50,
                ),
                baseName != null
                    ? InkWell(
                        onTap: () async {
                          file = await FileService.pickFile();
                          if (file == null) return;
                          setState(() {
                            baseName = basename(file!.path);
                          });
                        },
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(15),
                          padding: EdgeInsets.all(6),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            child: Container(
                              height: 200,
                              width: 300,
                              color: Colors.grey,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 90,
                                      width: 90,
                                      decoration: BoxDecoration(),
                                      child: Image.asset("assets/icon_pdf.png"),
                                    ),
                                    Text(
                                      "$baseName",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Text(
                        "Click the icon to start uploading!",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                SizedBox(
                  height: 20,
                ),
                baseName != null
                    ? Center(
                        child: Text("Great! You're PDF is now ready!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      )
                    : Text(""),
                baseName != null
                    ? ElevatedButton(
                        onPressed: () async {
                          if (file != null) {
                            openPDF(context, file.path);
                          } else {
                            showSnackBarError(context, "No PDF to be viewed.");
                          }
                        },
                        child: Text("View PDF"))
                    : Container(),
                SizedBox(
                  height: 100,
                ),
                baseName != null
                    ? InkWell(
                        onTap: () async {
                          if (file != null) {
                            resID = generateResID();
                            payload = uploadFunc(file);
                            final result = await fileUploadFlask(payload);
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return DialogPopup("Checking Paper...",
                                      "assets/acceptance.png");
                                });
                            final resultCheck = await checkAcceptance(baseName);

                            // final resultNode = await fileUploadNode(payload);
                            if (resultCheck.data!['result'] == false) {
                              showSnackBarError(context,
                                  "Paper not accepted. Endorsement may not be included.");
                              Navigator.pop(context);
                              isAccept = false;
                            } else {
                              setState(() {
                                Navigator.pop(context);
                                isAccept = false;
                                if (isExtractNames == false &&
                                    isExtractAbstract == false &&
                                    isExtractPhrases == false) {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return DialogPopup(
                                            "Extracting Information...",
                                            "assets/loading_un_2.gif");
                                      });
                                }
                                extractNamesFromPDF(baseName);
                                extractAbstractFromPDF(
                                  baseName,
                                );
                                extractKeyPhrasesFunc(baseName, context);
                              });
                            }
                          } else {
                            showSnackBarError(
                                context, "Try uploading a pdf file.");
                          }
                          // setState(() {
                          //   ///uncomment if actual
                          //   currentStep += 1;
                          // });
                        },
                        child: SizedBox(
                          height: 200,
                          width: 200,
                          child: Image.asset("assets/loading_un_2.gif"),
                        ),
                      )
                    : Container(),
                // baseName != null ? Text("I'm ready to go!") : Text(""),
              ],
            ),
          ),
        ),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            title: const Text('Information'),
            content: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Text';
                        }
                        return null;
                      },
                      controller: researchTitle,
                      decoration: const InputDecoration(
                          labelText: 'Paper Title',
                          prefixIcon: Icon(Icons.title),
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Text';
                        }
                        return null;
                      },
                      controller: researchDepartment,
                      decoration: const InputDecoration(
                          labelText: 'Department',
                          prefixIcon: Icon(Icons.school),
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      maxLines: 8,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Text';
                        }
                        return null;
                      },
                      controller: researchAbstract,
                      decoration: const InputDecoration(
                          labelText: 'Paper Abstract',
                          prefixIcon: Icon(Icons.document_scanner),
                          border: OutlineInputBorder(),
                          fillColor: Colors.green),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      maxLines: 6,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Text';
                        }
                        return null;
                      },
                      controller: keyPhrases,
                      decoration: const InputDecoration(
                          labelText: 'Keyphrases',
                          prefixIcon: Icon(Icons.book),
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ExpansionTile(
                      title: Text('Authors'),
                      leading: Icon(Icons.people),
                      children: <Widget>[
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: tempAccounts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      MemoryImage(tempAccounts[index].url),
                                ),
                                title: Text(
                                  tempAccounts[index].name,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(tempAccounts[index].title),
                                trailing: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      tempAccounts.removeAt(index);
                                    });
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        // Card(
                        //   child: ListTile(
                        //     leading: CircleAvatar(
                        //       backgroundImage: AssetImage('assets/vincent.png'),
                        //     ),
                        //     title: Text(
                        //       "Lorna D. Miro",
                        //       style: TextStyle(fontWeight: FontWeight.bold),
                        //     ),
                        //     subtitle: Text("Co Author"),
                        //     trailing: IconButton(
                        //       onPressed: () {},
                        //       icon: Icon(
                        //         Icons.delete,
                        //         color: Colors.red,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // Card(
                        //   child: ListTile(
                        //     leading: CircleAvatar(
                        //       backgroundImage: AssetImage('assets/vincent.png'),
                        //     ),
                        //     title: Text("Vincent Patalita",
                        //         style: TextStyle(fontWeight: FontWeight.bold)),
                        //     subtitle: Text("Author"),
                        //     trailing: IconButton(
                        //       onPressed: () {},
                        //       icon: Icon(
                        //         Icons.delete,
                        //         color: Colors.red,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isFoundAccount = false;
                              check = false;
                              display = false;
                              submitDisplay = false;
                              titleAuthor = " ";
                              findAccount.text = "";
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                    builder: (BuildContext context,
                                        StateSetter setState) {
                                      return AlertDialog(
                                        content: Stack(
                                          children: <Widget>[
                                            Positioned(
                                              right: -40.0,
                                              top: -40.0,
                                              child: InkResponse(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: CircleAvatar(
                                                  child: Icon(Icons.close),
                                                  backgroundColor: Colors.red,
                                                ),
                                              ),
                                            ),
                                            Form(
                                              key: _formKeyForAccount,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  display
                                                      ? Text(
                                                          "Account Not Found!",
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20),
                                                        )
                                                      : Text(
                                                          "Find Account!",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20.0),
                                                        ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: TextFormField(
                                                      onChanged: (value) {
                                                        setState(() {
                                                          display = false;
                                                          // Wrap the relevant code with setState to trigger rebuild
                                                        });
                                                      },
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Really?';
                                                        }
                                                        return null;
                                                      },
                                                      controller: findAccount,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'Account ID',
                                                        border:
                                                            OutlineInputBorder(),
                                                        suffixIcon: Icon(Icons
                                                            .perm_identity_sharp),
                                                      ),
                                                    ),
                                                  ),
                                                  Visibility(
                                                    visible: isFoundAccount,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: TextFormField(
                                                        controller:
                                                            searchAccountContoller,
                                                        enabled: false,
                                                        // Set the controller to display the fetched name
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              'Author Name',
                                                          border:
                                                              OutlineInputBorder(),
                                                          suffixIcon: Icon(
                                                              Icons.person),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Visibility(
                                                    visible: isFoundAccount,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child:
                                                          DropdownButtonFormField<
                                                              String>(
                                                        items: author_title.map(
                                                            (String value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        }).toList(),
                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            // Wrap the relevant code with setState to trigger rebuild
                                                            titleAuthor =
                                                                newValue!;
                                                            for (int i = 0;
                                                                i <
                                                                    author_title
                                                                        .length;
                                                                i++) {
                                                              if (titleAuthor ==
                                                                  author_title[
                                                                      i]) {
                                                                idType = i + 1;
                                                              }
                                                            }
                                                          });
                                                          print(idType);
                                                          // Handle dropdown value change
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              'Author Title',
                                                          border:
                                                              OutlineInputBorder(),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  isFoundAccount == true
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: ElevatedButton(
                                                            child:
                                                                Text("Submit"),
                                                            onPressed:
                                                                () async {
                                                              print(
                                                                  "title author$titleAuthor");
                                                              if (_formKeyForAccount
                                                                  .currentState!
                                                                  .validate()) {
                                                                if (titleAuthor !=
                                                                    " ") {
                                                                  addInTemp(
                                                                      context);
                                                                  // final addAuthor = await addAuthored(
                                                                  //     "2000626578",
                                                                  //     findAccount
                                                                  //         .text,
                                                                  //     idType);
                                                                  // if (addAuthor
                                                                  //         .data !=
                                                                  //     null) { /// remove this shit after
                                                                  //   Navigator.pop(
                                                                  //       context);
                                                                  //   showSnackBarSuccess(
                                                                  //       context,
                                                                  //       "SEHESSH!");
                                                                  // }

                                                                } else {
                                                                  showAlertDialogRegistration(
                                                                      //rework
                                                                      context,
                                                                      "Account Title is empty!");
                                                                }
                                                              } else {}
                                                              // Form submission logic
                                                            },
                                                          ),
                                                        )
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: ElevatedButton(
                                                            child:
                                                                Text("Search"),
                                                            onPressed: () {
                                                              setState(() {
                                                                // Wrap the relevant code with setState to trigger rebuild
                                                                if (_formKeyForAccount
                                                                    .currentState!
                                                                    .validate()) {
                                                                  searchAccount();
                                                                  if (check) {
                                                                    setState(
                                                                        () {
                                                                      isFoundAccount =
                                                                          true;
                                                                    });
                                                                  }
                                                                } else {
                                                                  // Handle case when resultAccount.data is null
                                                                }
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            });
                          },
                          child: Text("Add Authors"),
                        ),
                      ],
                    ),

                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Divider(
                    //         color: Colors.black,
                    //         thickness: 1,
                    //       ),
                    //     ),
                    //     Padding(
                    //       padding: EdgeInsets.symmetric(horizontal: 8.0),
                    //       child: Text(
                    //         'Authors',
                    //         style: TextStyle(fontSize: 16),
                    //       ),
                    //     ),
                    //     Expanded(
                    //       child: Divider(
                    //         color: Colors.black,
                    //         thickness: 1,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // TextFormField(
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please Enter Text';
                    //     }
                    //     return null;
                    //   },
                    //   controller: researchAuthors,
                    //   decoration: const InputDecoration(
                    //       labelText: 'Paper Authors',
                    //       prefixIcon: Icon(Icons.person_add_rounded),
                    //       border: OutlineInputBorder()),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),

                    // Row(
                    //   children: <Widget>[
                    //     IconButton(
                    //       onPressed: () {
                    //         showDatePicker(context);
                    //       },
                    //       icon: const Icon(
                    //         Icons.calendar_month,
                    //         size: 40.0,
                    //         color: Colors.green,
                    //       ),
                    //     ),
                    //     Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Text(
                    //         researchDate,
                    //         style: const TextStyle(
                    //             fontSize: 18.0,
                    //             color: Color.fromARGB(255, 102, 100, 100)),
                    //       ),
                    //     ),
                    //   ],
                    // ),

                    // Divider(
                    //   height: 1, // Adjust the height of the line as needed
                    //   color: Colors.black, // Specify the color of the line
                    //   thickness: 1, // Adjus
                    // ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isExtractAbstract = false;
                                isExtractNames = false;
                                isExtractPhrases = false;
                                currentStep -= 1;
                              });
                            },
                            child: const Text('BACK'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              print("ISCLASSIFY $isClassify");
                              if (_formKey.currentState!.validate() &&
                                  researchDate != "Date Published") {
                                //   Map<String, Float> finalClassify = HashMap();
                                // Map<String, dynamic> test = HashMap();
                                // final dataTest = {
                                //   'Goal 1: No Poverty': 20.86677,
                                //   'Goal 17: Partnership for the Goals': 45.323232,
                                //   'Goal 14: Life Below Water': 67.29999,
                                //   'Goal 15: Life on Land': 56.2921,
                                // };
                                // test.addEntries(dataTest.entries);
                                if (isClassify == false) {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return DialogPopup(
                                            "Classifying your paper!",
                                            "assets/loading_un.gif");
                                      });
                                }
                                final classifyResult =
                                    await classifyResearch(baseName);

                                if (classifyResult.data != null) {
                                  final test = classifyResult.data;
                                  shit = test!;
                                  setState(() {
                                    test.forEach((key, value) {
                                      test[key] = (value.toDouble() / 100);
                                    });
                                    sortedEntries = test.entries.toList()
                                      ..sort(
                                          (a, b) => b.value.compareTo(a.value));
                                    for (int i = 0;
                                        i < sortedEntries.length;
                                        i++) {
                                      url.add(
                                          getImageUrl(sortedEntries[i].key));
                                      color.add(getColor(sortedEntries[i].key));
                                      finalGoal.add(sortedEntries[i].key);
                                    }
                                    Navigator.pop(context);
                                    currentStep += 1;
                                  });
                                }
                              } else {
                                showSnackBarError(
                                    context, "Complete the form!");
                              }

                              //uncomment if actual
                            },
                            child: const Text('CONTINUE'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            isActive: currentStep >= 1),
        Step(
            state: currentStep > 2 ? StepState.complete : StepState.indexed,
            title: const Text('Classify'),
            content: Column(
              children: <Widget>[
                Upload_Review(sortedEntries, url, color),
                const SizedBox(
                  height: 100,
                ),
                ElevatedButton(
                    onPressed: () async {
                      // Map<String, dynamic> map = {shit.key: shit.value};
                      // String json = jsonEncode(shit);
                      if (isAddResearch == false) {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return DialogPopup(
                                  "Adding to repository!", "assets/add.gif");
                            });
                      }
                      List<double> listOfSDG = [];
                      List<String> listOfSDGNames = [];
                      for (int i = 0; i < sortedEntries.length; i++) {
                        double temp = sortedEntries[i].value * 100;

                        print(
                            "${sortedEntries[i].key} == ${sortedEntries[i].value}");

                        String formattedValue = temp.toStringAsFixed(2);
                        double parsedValue = double.parse(formattedValue);
                        listOfSDG.add(parsedValue);
                        listOfSDGNames.add(sortedEntries[i].key);
                      }

                      //START UPLOADING
                      final resultNode =
                          await fileUploadNode(payload); //goods step 1
                      final details = ResearchDetails(
                          research_id: resID,
                          departmentID: widget.account.departmentID,
                          date_published: researchDate,
                          keywords: finalKeyPhrases,
                          title: researchTitle.text,
                          abstracts: researchAbstract.text,
                          number_of_views: 0,
                          approved: 0,
                          file: baseName);
                      addResDetails(details, context); // goods step 2
                      bool goAuthors = false;
                      for (int i = 0; i < tempAccounts.length; i++) {
                        print("ACCOUNT NAME: ${tempAccounts[i].name}");
                        final resultAuthored = await addAuthored(
                            // check step 3

                            resID,
                            tempAccounts[i].account_id,
                            tempAccounts[i].idType);
                        if (resultAuthored.data != null) {
                          goAuthors = true;
                        } else {
                          goAuthors = false;
                        }
                      }
                      bool goSDG = false;
                      for (int i = 0; i < listOfSDG.length; i++) {
                        int id = getSDGID(listOfSDGNames[i]);
                        final resultSDG = await addSDG(resID, id, listOfSDG[i]);
                        if (resultSDG.data != null) {
                          goSDG = true;
                        } else {
                          goSDG = false;
                        }
                      }
                      // final resultAuthored =
                      //     await addAuthored(resID, widget.account.account_id!);
                      if (resultNode.data != null &&
                          goAuthors &&
                          resultResearch.data != null &&
                          goSDG) {
                        showSnackBarSuccess(
                            context, "Research Uploaded Successfully!");
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      } else {
                        showSnackBarError(
                            context, resultNode.errorMessage.toString());
                      }

                      //END UPLOADING
                    },
                    child: const Text("Add Research")),
              ],
            ),
            isActive: currentStep >= 2),
      ];
}
