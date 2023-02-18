import 'package:flutter/material.dart';

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

  final TextEditingController _tileController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _deadLineDateController = TextEditingController();
  final TextEditingController _niveauController = TextEditingController();

  DateTime? currenteDta = DateTime.now();

  String imageUrl = "";
  bool readOnly = false;
  bool typeDevice = true;

  Level _levelTask = Level.Low;
  int level = 1;

  @override
  void initState() {}

  @override
  void dispose() {
    super.dispose();
  }

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
            child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: width * .03, vertical: height * .1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppInput(
                      hint: 'Ecrire ...',
                      reeadOnly: false,
                      hasSuffix: false,
                      label: 'Title',
                      controller: _tileController,
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
                      controller: _descriptionController,
                      validator: (value) {
                        return null;
                      }),

                  SizedBox(
                    height: height * .03,
                  ),

                  //Day of birth
                  AppInput(
                      hint: currenteDta.toString(),
                      label: 'Dead line date',
                      reeadOnly: true,
                      hasSuffix: true,
                      suffixIcon: IconButton(
                          onPressed: () async {
                            _showDatePicker();
                          },
                          icon: const Icon(Icons.calendar_month)),
                      controller: _deadLineDateController,
                      validator: (value) {
                        return null;
                      }),
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
                    height: height * .03,
                  ),
                  //Button of option "modify"
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: (() {
                        setState(() {
                          if (level == 0) {
                            _niveauController.text = 'Low';
                          } else if (level == 1) {
                            _niveauController.text = 'Medium';
                          } else {
                            _niveauController.text = 'High';
                          }
                        });

                        /*ContactDataBase.createPersonne(personne).then((value){
                      print(personne.tojson(personne));
                      if(value!=-1){
                        Navigator.pushNamed(context,"home");
                      }
                    });*/
                      }),
                      child: Container(
                        alignment: Alignment.center,
                        width: width * .3,
                        height: height * .06,
                        decoration: BoxDecoration(
                            color: AppColors.getblueColor,
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 3),
                                  color: AppColors.getBlueNightColor)
                            ]),
                        child: AppText(
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
        )),
      ),
    );
  }

  Future<void> _showDatePicker() async {
    /* This fonction display the Date picker and  help to have the Person date
    setting:No setting for this function
     */

    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(), //get today's date
        firstDate: DateTime(
            2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));
    if (pickedDate != null) {
      /*setState(() {
        _deadLineDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate!);
      });*/
    } else {
      _deadLineDateController.text = currenteDta.toString();
    }
  }
}
