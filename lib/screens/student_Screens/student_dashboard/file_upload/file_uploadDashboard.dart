import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_it/get_it.dart';
import 'package:thesis_eul/models/AccountModel.dart';
import 'package:thesis_eul/models/research_details.dart';
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
  late APIResponse<bool> _apiResponse;
  int currentStep = 0;
  final researchTitle = TextEditingController();
  final researchDate = TextEditingController();
  final researchAdviser = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool upload = false;
  var baseName;
  var file = null;
  String resID = "";
  ResearchService get resService => GetIt.instance<ResearchService>();

  Future<APIResponse<bool>> fileUpload(Files file) async {
    APIResponse<bool> reponse;
    return await resService.fileUpload(file);
  }

  Future<APIResponse<bool>> addResearch(ResearchDetails researchDetails) async {
    // ignore: unused_local_variable
    APIResponse<bool> reponse;
    return reponse = await resService.addResearch(researchDetails);
  }

  Future<APIResponse<bool>> addAuthored(String resID, String schoolID) async {
    // ignore: unused_local_variable
    APIResponse<bool> reponse;
    return reponse = await resService.addAuthored(resID, schoolID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Research Upload'),
      ),
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
              print("Compeleted");
            } else {
              currentStep += 1;
            }
            print(currentStep);
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
    );
  }

  Files uploadFunc(File files) {
    Files payload = Files(file: files.path, research_id: resID, url: file.path);
    return payload;
  }

  List<Step> getSteps(context) => [
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            title: const Text('Upload'),
            content: Column(
              children: <Widget>[
                TextButton(
                    onPressed: () async {
                      file = await ResearchService.pickFile();
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
                      padding: EdgeInsets.all(12.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (file != null) {
                            resID = generateID();
                            Files payload = uploadFunc(file);
                            final result = await fileUpload(payload);
                            setState(() {
                              if (result.data != null) {
                                currentStep += 1;
                                showSnackBar(context, 'PDF Uploaded!');
                              } else {
                                showSnackBar(context, 'Error Uploading!');
                              }
                            });
                          } else {
                            showSnackBar(context, "Try uploading a pdf file.");
                          }
                        },
                        child: const Text('CONTINUE'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (file != null) {
                            openPDF(context, file);
                          } else {
                            showSnackBar(context, "No PDF to be viewed.");
                          }
                        },
                        child: const Text('VIEW PDF'),
                      ),
                    ),
                  ],
                )
              ],
            ),
            isActive: currentStep >= 0),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            title: const Text('Information'),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Text';
                      }
                      return null;
                    },
                    controller: researchTitle,
                    decoration: const InputDecoration(labelText: 'Paper Title'),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Text';
                      }
                      return null;
                    },
                    controller: researchAdviser,
                    decoration:
                        const InputDecoration(labelText: 'Paper Adviser'),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Text';
                      }
                      return null;
                    },
                    controller: researchDate,
                    decoration:
                        const InputDecoration(labelText: 'Date Accepted'),
                  ),
                  // TextFormField(
                  //   controller: researchTitle,
                  //   decoration: const InputDecoration(labelText: ''),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final payload = ResearchDetails(
                                  research_id: resID,
                                  departmentID: widget.account.departmentID,
                                  topic_category: const ["AI", "ML"],
                                  sdg_category: const ["Goal 1", "Goal 2"],
                                  date_published: researchDate.text,
                                  adviser: researchAdviser.text,
                                  keywords: const ["shit", "ficlers"],
                                  title: researchTitle.text,
                                  abstracts:
                                      "A research digital research motherfucker",
                                  qr: "1ss",
                                  number_of_views: 69);

                              final result = await addResearch(payload);
                              if (result.data != null) {
                                showSnackBar(
                                    context, "Research Uploaded Successfully!");
                              } else {
                                showSnackBar(context, result.errorMessage!);
                              }
                              final resultAuthored = await addAuthored(
                                  resID, widget.account.school_id!);
                              if (resultAuthored.data != null) {
                                showSnackBar(
                                    context, "Authors Added Successfully!");
                              } else {
                                showSnackBar(
                                    context, resultAuthored.errorMessage!);
                              }
                              currentStep += 1;
                            }
                          },
                          child: const Text('CONTINUE'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.0),
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
            title: const Text('Review'),
            content: Container(),
            isActive: currentStep >= 2),
      ];
}
