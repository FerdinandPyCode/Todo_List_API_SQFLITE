import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/data/services/todo_service.dart';

import '../utils/app_input.dart';
import '../utils/app_text.dart';
import '../utils/colors.dart';

enum Level { Low, Medium, High }

class CreateStackScreem extends StatefulWidget {
  const CreateStackScreem({super.key});

  @override
  State<CreateStackScreem> createState() => _CreateStackScreemState();
}

class _CreateStackScreemState extends State<CreateStackScreem> {
  // variable permettant de stocker l'image de l'utilisateur

  TextEditingController tileController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController beginDateController = TextEditingController();
  TextEditingController deadLineDateController = TextEditingController();

  String niveau = 'low';
  DateTime? currenteDta = DateTime.now();
  bool readOnly = false;
  bool typeDevice = true;

  Level _levelTask = Level.Low;
  int level = 1;
  String beginDate = '';
  String deadDate = '';

  // @override
  // void initState() {}

  @override
  void dispose() {
    beginDateController.dispose();
    tileController.dispose();
    descriptionController.dispose();
    deadLineDateController.dispose();

    super.dispose();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const AppText(
          "Ajouter une tâche",
          color: Colors.white,
          size: 20,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Form(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: width * .03, vertical: height * .01),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppInput(
                        hint: 'Ecrire ...',
                        reeadOnly: false,
                        hasSuffix: false,
                        label: 'Title',
                        controller: tileController,
                        validator: (value) {
                          return null;
                        }),
                    SizedBox(
                      height: height * .03,
                    ),

                    //description
                    AppInput(
                        hint: 'write something ..',
                        label: 'Description',
                        reeadOnly: false,
                        hasSuffix: false,
                        controller: descriptionController,
                        validator: (value) {
                          return null;
                        }),

                    SizedBox(
                      height: height * .03,
                    ),

                    const Padding(
                        padding: EdgeInsets.only(top: 5.0, left: 8, bottom: 5),
                        child: AppText(
                          'Deadline',
                          color: Colors.green,
                          size: 20.0,
                          weight: FontWeight.bold,
                        )),

                    DateTimePicker(
                      //controller: deadLineDateController,
                      type: DateTimePickerType.dateTimeSeparate,
                      dateMask: 'd MMM, yyyy',
                      initialValue: DateTime.now().toString(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      icon: const Icon(Icons.event),
                      dateLabelText: 'Deadline Date',
                      timeLabelText: "Hour",
                      onChanged: (value) {
                        deadDate = value;
                        print(value);
                      },
                    ),
                    SizedBox(
                      height: height * .03,
                    ),

                    //Priority

                    Column(
                      children: [
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            child: AppText(
                              'Priority',
                              color: Colors.green,
                              size: 20.0,
                              weight: FontWeight.bold,
                            )),
                        Column(
                          children: [
                            ListTile(
                              leading: Radio(
                                value: Level.Low,
                                groupValue: _levelTask,
                                onChanged: (value) {
                                  setState(() {
                                    level = 0;
                                    _levelTask = value!;
                                  });
                                },
                              ),
                              title: AppText(
                                'Low',
                                color: AppColors.getBlueNightColor,
                                size: 20.0,
                                weight: FontWeight.bold,
                              ),
                            ),
                            ListTile(
                              leading: Radio(
                                value: Level.Medium,
                                groupValue: _levelTask,
                                onChanged: (value) {
                                  setState(() {
                                    level = 1;
                                    _levelTask = value!;
                                  });
                                },
                              ),
                              title: AppText(
                                'Medium',
                                color: AppColors.getBlueNightColor,
                                size: 20.0,
                                weight: FontWeight.bold,
                              ),
                            ),
                            ListTile(
                              leading: Radio(
                                value: Level.High,
                                groupValue: _levelTask,
                                onChanged: (value) {
                                  setState(() {
                                    level = 2;
                                    _levelTask = value!;
                                  });
                                },
                              ),
                              title: AppText(
                                'High',
                                color: AppColors.getBlueNightColor,
                                size: 20.0,
                                weight: FontWeight.bold,
                              ),
                            )
                          ],
                        )
                      ],
                    ),

                    SizedBox(
                      height: height * .04,
                    ),
                    //Button of option "modify"
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: (() async {
                          setState(() {
                            isLoading = true;
                          });
                          if (level == 0) {
                            niveau = 'low';
                          } else if (level == 1) {
                            niveau = 'medium';
                          } else {
                            niveau = 'high';
                          }

                          Map<String, String> map = {
                            "description": descriptionController.text,
                            "title": tileController.text,
                            "begined_at": "2022-12-27 12:00:00",
                            "finished_at": "2022-12-28 12:00:00",
                            "deadline_at": '$deadDate:00',
                            "priority": niveau
                          };

                          await TodoService.create(map);
                          setState(() {
                            isLoading = false;
                          });
                          Fluttertoast.showToast(
                              msg: "Todo added sucessfully !",
                              toastLength: Toast.LENGTH_LONG);
                        }),
                        child: Container(
                          alignment: Alignment.center,
                          width: width * .3,
                          height: height * .06,
                          decoration: BoxDecoration(
                              color: AppColors.getGreenColor,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(0, 3),
                                    color: AppColors.getGreyColor)
                              ]),
                          child: isLoading
                              ? CircularProgressIndicator(
                                  color: AppColors.getWhiteColor,
                                )
                              : AppText(
                                  'Ajouter',
                                  color: AppColors.getWhiteColor,
                                  size: 20.0,
                                  weight: FontWeight.bold,
                                ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: height * .03,
                    ),
                    SizedBox(
                      height: height * .05,
                    ),
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}


// Post Format
/**
 * {
 "description": "Gazo et Tiako en concert! je ne dois pas rater",
  "title": "Aller au concert 2",
  "begined_at": "2022-12-27 12:00:00",
  "finished_at": "2022-12-28 12:00:00",
  "deadline_at": "2022-12-29 12:00:00",
  "priority": "medium"
}
 */