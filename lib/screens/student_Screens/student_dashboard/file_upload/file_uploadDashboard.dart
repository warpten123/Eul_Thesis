// ignore: file_names
// ignore_for_file: prefer_const_constructors

import 'dart:collection';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:thesis_eul/api_service/algorithn_service.dart';
import 'package:thesis_eul/api_service/file_service.dart';
import 'package:thesis_eul/models/AccountModel.dart';
import 'package:thesis_eul/models/research_details.dart';
import 'package:thesis_eul/screens/student_Screens/student_dashboard/file_upload/dialog.dart';
import 'package:thesis_eul/screens/student_Screens/student_dashboard/file_upload/review.dart';
import 'package:thesis_eul/screens/utilities/utilities.dart';
import 'package:path/path.dart';
import '../../../../api_service/api_response.dart';
import '../../../../api_service/research_service.dart';
import '../../../../models/Files.dart';
import 'package:dotted_border/dotted_border.dart';

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
      date = DateFormat("yyyy-MM-dd").format(newDateTime!);
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
  final keyPhrases = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<Color> color = [];
  List<String> url = [];

  List<dynamic> finalGoal = [];
  bool upload = false;
  var baseName;
  var file = null;
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
  Future<APIResponse<bool>> fileUploadFlask(Files file) async {
    APIResponse<bool> reponse;
    return await fileService.fileUploadToFlask(file);
  }

  Future<APIResponse<bool>> fileUploadNode(Files file) async {
    APIResponse<bool> reponse;
    return await fileService.fileUpload(file, widget.account.departmentName!);
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

  Future<APIResponse<bool>> addAuthored(String resID, String schoolID) async {
    // ignore: unused_local_variable
    APIResponse<bool> reponse;
    return reponse = await resService.addAuthored(resID, schoolID);
  }

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
                // children: <Widget>[
                //   ElevatedButton(
                //     onPressed: controls.onStepContinue,
                //     child: const Text('CONTINUE'),
                //   ),
                //   Padding(
                //     padding: const EdgeInsets.only(left: 5.0),
                //     child: ElevatedButton(
                //       onPressed: controls.onStepCancel,
                //       child: const Text('CANCEL'),
                //     ),
                //   ),
                // ],
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
    print("RESULTCHJECK: ${resultCheck.data!['result']}");
    checker = resultCheck.data!['result'];
    setState(() {
      isLoadingAcceptance = true;
    });
    return checker;
  }

  void addResDetails(ResearchDetails details, BuildContext context) async {
    bool go = false;
    final result = await addResearch(details);
    print("DETIALS ${result.data}");
    // final resultAuthored = await addAuthored(
    //     resID, widget.account.school_id!)
    // ignore: use_build_context_synchronously
  }

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
                          child: Image.asset("assets/icon_pdf.png"),
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
                                child: Container(
                                  height: 90,
                                  width: 90,
                                  decoration: BoxDecoration(),
                                  child: Image.asset("assets/icon_pdf.png"),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    // ? Text("File: $baseName",
                    //     textAlign: TextAlign.justify,
                    //     style:
                    //         TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
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
                            resID = generateID();
                            payload = uploadFunc(file);
                            final result = await fileUploadFlask(payload);

                            // final resultNode = await fileUploadNode(payload);
                            setState(() {
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
                baseName != null ? Text("I'm ready to go!") : Text(""),
                // TextButton(
                //     onPressed: () async {
                //       // file = await FileService.pickFile();
                //       // if (file == null) return;
                //       // setState(() {
                //       //   baseName = basename(file!.path);
                //       // });

                //       // if (result.data == null) {
                //       //   showSnackBar(context, result.errorMessage.toString());
                //       // } else {
                //       //   upload = true;
                //       //   showSnackBar(context, 'File Uploaded!');
                //       // }
                //     },
                //     child: const Text('Upload PDF')),
                // baseName != null
                //     ? Text('Filename: $baseName')
                //     : const Text('Filename: '),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     Padding(
                //       padding: const EdgeInsets.all(12.0),
                //       child: ElevatedButton(
                // onPressed: () async {
                //   if (file != null) {
                //     bool test = false;
                //     resID = generateID();
                //     payload = uploadFunc(file);
                //     final result = await fileUploadFlask(payload);
                //     extractNamesFromPDF(baseName);
                //     extractAbstractFromPDF(baseName);
                //     extractKeyPhrasesFunc(baseName);
                //     test = true;
                //     // final resultNode = await fileUploadNode(payload);
                //     setState(() {
                //       if (result.data != null) {
                //         // ignore: unrelated_type_equality_checks
                //         print("TEST: $test");
                //         // ignore: unrelated_type_equality_checks
                //         showSnackBarSuccess(
                //             context, 'Research Information Extracted');
                //       } else {
                //         showSnackBarError(
                //             context, 'Error Extracting Information!');
                //       }
                //       currentStep += 1;
                //     });
                //   } else {
                //     showSnackBarError(
                //         context, "Try uploading a pdf file.");
                //   }
                //   setState(() {
                //     ///uncomment if actual
                //     currentStep += 1;
                //   });
                // },
                //         child: const Text('CONTINUE'),
                //       ),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.all(12.0),
                //       child: ElevatedButton(
                //         onPressed: () async {
                //           if (file != null) {
                //             openPDF(context, file.path);
                //           } else {
                //             showSnackBarError(context, "No PDF to be viewed.");
                //           }
                //         },
                //         child: const Text('VIEW PDF'),
                //       ),
                //     ),
                //   ],
                // )
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
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please Enter Text';
                      //   }
                      //   return null;
                      // },
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
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please Enter Text';
                      //   }
                      //   return null;
                      // },
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
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please Enter Text';
                      //   }
                      //   return null;
                      // },
                      controller: researchAdviser,
                      decoration: const InputDecoration(
                          labelText: 'Adviser',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      maxLines: 8,
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please Enter Text';
                      //   }
                      //   return null;
                      // },
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
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please Enter Text';
                      //   }
                      //   return null;
                      // },
                      controller: researchAuthors,
                      decoration: const InputDecoration(
                          labelText: 'Paper Authors',
                          prefixIcon: Icon(Icons.people),
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      maxLines: 6,
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please Enter Text';
                      //   }
                      //   return null;
                      // },
                      controller: keyPhrases,
                      decoration: const InputDecoration(
                          labelText: 'Keyphrases',
                          prefixIcon: Icon(Icons.book),
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            showDatePicker(context);
                          },
                          icon: const Icon(
                            Icons.calendar_month,
                            size: 40.0,
                            color: Colors.green,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            researchDate,
                            style: const TextStyle(
                                fontSize: 18.0,
                                color: Color.fromARGB(255, 102, 100, 100)),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              print("ISCLASSIFY $isClassify");
                              // if (_formKey.currentState!.validate() &&
                              //     researchDate != "Date Published") {
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
                                setState(() {
                                  test!.forEach((key, value) {
                                    test[key] = (value.toDouble() / 100);
                                  });
                                  sortedEntries = test.entries.toList()
                                    ..sort(
                                        (a, b) => b.value.compareTo(a.value));
                                  for (int i = 0;
                                      i < sortedEntries.length;
                                      i++) {
                                    url.add(getImageUrl(sortedEntries[i].key));
                                    color.add(getColor(sortedEntries[i].key));
                                    finalGoal.add(sortedEntries[i].key);
                                  }
                                  Navigator.pop(context);
                                  currentStep += 1;
                                });
                              }

                              // } else {
                              //   showSnackBarError(context, "Complete the form!");
                              // }

                              //uncomment if actual
                            },
                            child: const Text('CONTINUE'),
                          ),
                        ),
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
                      // final details = ResearchDetails(
                      //     research_id: resID,
                      //     departmentID: widget.account.departmentID,
                      //     topic_category: const ["AI", "ML"],
                      //     sdg_category: finalGoal,
                      //     date_published: researchDate,
                      //     adviser: researchAdviser.text,
                      //     keywords: finalKeyPhrases,
                      //     title: researchTitle.text,
                      //     abstracts: researchAbstract.text,
                      //     qr: "1ss",
                      //     number_of_views: 0);
                      // print(details);
                      // addResDetails(details, context);
                      // final resultNode = await fileUploadNode(payload);
                      // final resultAuthored =
                      //     await addAuthored(resID, widget.account.school_id!);
                      // if (resultNode.data != null &&
                      //     resultAuthored.data != null) {
                      //   showSnackBarSuccess(context, "Research Uploaded Successfully!");
                      //   Navigator.pop(context);
                      // } else {
                      //   showSnackBarError(
                      //       context, resultNode.errorMessage.toString());
                      // }
                    },
                    child: const Text("Add Research")),
              ],
            ),
            isActive: currentStep >= 2),
      ];
}
