// ignore: file_names
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
import 'package:thesis_eul/screens/student_Screens/student_dashboard/file_upload/review.dart';
import 'package:thesis_eul/screens/utilities/utilities.dart';
import 'package:path/path.dart';
import '../../../../api_service/api_response.dart';
import '../../../../api_service/research_service.dart';
import '../../../../models/Files.dart';

class File_Upload extends StatefulWidget {
  File_Upload(this.account, {super.key});
  Account account;
  @override
  State<File_Upload> createState() => _File_UploadState();
}

class _File_UploadState extends State<File_Upload> {
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
        backgroundColor: Colors.greenAccent.shade100,
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
      });
    }
  }

  void extractAbstractFromPDF(String fileName) async {
    final result = await extractAbstract(fileName);

    if (result.data != null) {
      researchAbstract.text = result.data!['abstract'];
    }
  }

  List<dynamic> finalKeyPhrases = [];
  void extractKeyPhrasesFunc(String fileName) async {
    final result = await extractKeyPhrases(fileName);

    if (result.data != null) {
      finalKeyPhrases = result.data!;
      keyPhrases.text = finalKeyPhrases.join(', ');
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
    //     resID, widget.account.school_id!);
    if (result.data != null) {
      // ignore: use_build_context_synchronously

      showSnackBarSuccess(context, "Research Uploaded Sucessfully!");
    } else {
      // ignore: use_build_context_synchronously

      showSnackBarError(context, "Error Uploading your research!");
    }
    // ignore: use_build_context_synchronously
  }

  var data = {};
  late Files payload;
  List<Step> getSteps(context) => [
        Step(
          isActive: currentStep >= 0,
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          title: const Text('Upload'),
          content: Column(
            children: <Widget>[
              TextButton(
                  onPressed: () async {
                    file = await FileService.pickFile();
                    if (file == null) return;
                    setState(() {
                      baseName = basename(file!.path);
                    });

                    // if (result.data == null) {
                    //   showSnackBar(context, result.errorMessage.toString());
                    // } else {
                    //   upload = true;
                    //   showSnackBar(context, 'File Uploaded!');
                    // }
                  },
                  child: const Text('Upload PDF')),
              baseName != null
                  ? Text('Filename: $baseName')
                  : const Text('Filename: '),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        // if (file != null) {
                        //   bool test = false;
                        //   resID = generateID();
                        //   payload = uploadFunc(file);
                        //   final result = await fileUploadFlask(payload);
                        //   extractNamesFromPDF(baseName);
                        //   extractAbstractFromPDF(baseName);
                        //   extractKeyPhrasesFunc(baseName);
                        //   test = true;
                        //   // final resultNode = await fileUploadNode(payload);
                        //   setState(() {
                        //     if (result.data != null) {
                        //       // ignore: unrelated_type_equality_checks
                        //       print("TEST: $test");
                        //       // ignore: unrelated_type_equality_checks
                        //       showSnackBarSuccess(
                        //           context, 'Research Information Extracted');
                        //     } else {
                        //       showSnackBarError(
                        //           context, 'Error Extracting Information!');
                        //     }
                        //     currentStep += 1;
                        //   });
                        // } else {
                        //   showSnackBarError(
                        //       context, "Try uploading a pdf file.");
                        // }
                        setState(() {
                          ///uncomment if actual
                          currentStep += 1;
                        });
                      },
                      child: const Text('CONTINUE'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (file != null) {
                          openPDF(context, file.path);
                        } else {
                          showSnackBarError(context, "No PDF to be viewed.");
                        }
                      },
                      child: const Text('VIEW PDF'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            title: const Text('Information'),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Please Enter Text';
                    //   }
                    //   return null;
                    // },
                    controller: researchTitle,
                    decoration: const InputDecoration(labelText: 'Paper Title'),
                  ),
                  TextFormField(
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Please Enter Text';
                    //   }
                    //   return null;
                    // },
                    controller: researchDepartment,
                    decoration: const InputDecoration(labelText: 'Department'),
                  ),
                  TextFormField(
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Please Enter Text';
                    //   }
                    //   return null;
                    // },
                    controller: researchAdviser,
                    decoration:
                        const InputDecoration(labelText: 'Paper Adviser'),
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
                    decoration:
                        const InputDecoration(labelText: 'Paper Abstract'),
                  ),
                  TextFormField(
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Please Enter Text';
                    //   }
                    //   return null;
                    // },
                    controller: researchAuthors,
                    decoration:
                        const InputDecoration(labelText: 'Paper Authors'),
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
                    decoration: const InputDecoration(labelText: 'Key Phrases'),
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
                            if (_formKey.currentState!.validate() &&
                                researchDate != "Date Published") {
                              Map<String, Float> finalClassify = HashMap();
                              Map<String, dynamic> test = HashMap();
                              final dataTest = {
                                'Goal 1: No Poverty': 20.8,
                                'Goal 17: Partnership for the Goals': 45.3,
                                'Goal 14: Life Below Water': 67.2,
                              };
                              test.addEntries(dataTest.entries);
                              // final classifyResult =
                              //     await classifyResearch(baseName);

                              // final test = classifyResult.data;
                              setState(() {
                                test!.forEach((key, value) {
                                  test[key] = (value.toDouble() / 100);
                                });
                                sortedEntries = test.entries.toList()
                                  ..sort((a, b) => b.value.compareTo(a.value));
                                currentStep += 1;
                              });

                              for (int i = 0; i < sortedEntries.length; i++) {
                                url.add(getImageUrl(sortedEntries[i].key));
                                color.add(getColor(sortedEntries[i].key));
                                finalGoal.add(sortedEntries[i].key);
                              }
                              print(finalGoal);
                              print(url);
                            } else {
                              showSnackBarError(context, "Complete the form!");
                            }
                          },
                          child: const Text('CONTINUE'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
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
            isActive: currentStep >= 1),
        Step(
            state: currentStep > 2 ? StepState.complete : StepState.indexed,
            title: const Text('Classify'),
            content: Column(
              children: <Widget>[
                Upload_Review(sortedEntries, url, color),
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
                      //     number_of_views: 69);
                      // print(details);
                      // addResDetails(details, context);
                      // final resultNode = await fileUploadNode(payload);
                      // final resultAuthored =
                      //     await addAuthored(resID, widget.account.school_id!);
                      // if (resultNode.data != null &&
                      //     resultAuthored.data != null) {
                      //   showSnackBarSuccess(context, "Uploaded to Node!");
                      // } else {
                      //   showSnackBarError(
                      //       context, resultNode.errorMessage.toString());
                      // }
                    },
                    child: Text("Add Research")),
              ],
            ),
            isActive: currentStep >= 2),
      ];
}
