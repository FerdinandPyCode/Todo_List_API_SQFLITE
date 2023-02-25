import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/services/todo_service.dart';
import 'package:todo_app/utils/app_func.dart';
import 'package:todo_app/utils/app_text.dart';
import 'package:todo_app/utils/colors.dart';

import '../utils/app_simple_input.dart';

class TodoDetail extends StatefulWidget {
  final Todo todo;
  const TodoDetail({required this.todo, super.key});

  @override
  State<TodoDetail> createState() => _TodoDetailState();
}

class _TodoDetailState extends State<TodoDetail> {
  Todo todo = Todo.initial();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionCOntroller = TextEditingController();

  bool isLoading = false;
  bool isLoading2 = false;

  @override
  void initState() {
    todo = widget.todo;
    super.initState();
    titleController.text = widget.todo.title!;
    descriptionCOntroller.text = widget.todo.description!;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const AppText(
            "Detail todo",
            color: Colors.white,
            size: 22,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: getSize(context).height * .05,
              ),
              //Title
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                color: AppColors.getGreenColor2,
                height: 50.0,
                child: const AppText(
                  "Todo Title",
                  size: 25.0,
                  weight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: AppText(
                        titleController.text,
                        color: AppColors.getBlackColors,
                        size: 20,
                        //weight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          if ((todo.beginedAt != null &&
                                  todo.finishedAt == null) ||
                              todo.beginedAt == null &&
                                  DateTime.now().millisecondsSinceEpoch <
                                      todo.deadlineAt!.millisecondsSinceEpoch) {
                            _showDialog(context, controller: titleController,
                                action: () async {
                              setState(() {
                                isLoading2 = true;
                              });
                              Map<String, String> map = {
                                "title": titleController.text
                              };

                              await TodoService.patch(widget.todo.id, map,
                                      dataLocal: map)
                                  .then(
                                (value) {
                                  setState(() {
                                    todo = value;
                                  });
                                },
                              );

                              setState(() {
                                isLoading2 = false;
                              });
                            });
                          } else {
                            Fluttertoast.showToast(
                                msg: "Vous ne pouvez pas modifier la tâche");
                          }
                        },
                        icon: Icon(
                          Icons.edit,
                          color: AppColors.getGreenColor,
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: getSize(context).height * .09,
              ),

              //Description
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                color: AppColors.getGreenColor2,
                height: 50.0,
                child: const AppText(
                  "Todo Description",
                  size: 25.0,
                  weight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: AppText(
                        descriptionCOntroller.text,
                        color: AppColors.getBlackColors,
                        size: 20,
                        //weight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          if ((todo.beginedAt != null &&
                                  todo.finishedAt == null) ||
                              todo.beginedAt == null &&
                                  DateTime.now().millisecondsSinceEpoch <
                                      todo.deadlineAt!.millisecondsSinceEpoch) {
                            _showDialog(context,
                                controller: descriptionCOntroller,
                                action: () async {
                              setState(() {
                                isLoading2 = true;
                              });
                              Map<String, String> map = {
                                "description": descriptionCOntroller.text
                              };

                              await TodoService.patch(todo.id, map,
                                      dataLocal: map)
                                  .then(
                                (value) {
                                  setState(() {
                                    todo = value;
                                  });
                                },
                              );

                              setState(() {
                                isLoading2 = false;
                              });
                            });
                          } else {
                            Fluttertoast.showToast(
                                msg: "Vous ne pouvez pas modifier la tâche");
                          }
                        },
                        icon: Icon(
                          Icons.edit,
                          color: AppColors.getGreenColor,
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: getSize(context).height * .09,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: [
                    AppText(
                      "Deadline Date",
                      color: AppColors.getGreenColor,
                      weight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: getSize(context).height * .02,
                    ),
                    AppText(todo.deadlineAt.toString().substring(0, 16)),
                  ],
                ),
              ),
              SizedBox(
                height: getSize(context).height * .05,
              ),
              Center(
                child: AppText(
                  "Todo State",
                  color: AppColors.getGreenColor,
                  size: 20,
                  weight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: getSize(context).height * .03,
              ),
              todo.beginedAt == null &&
                      DateTime.now().millisecondsSinceEpoch <
                          todo.deadlineAt!.millisecondsSinceEpoch
                  ? Center(
                      child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            print(todo.user);
                            print(todo);
                            Map<String, String> map = {
                              "begined_at":
                                  DateTime.now().toString().substring(0, 19)
                            };
                            Map<String, String> map2 = {
                              "beginAt":
                                  DateTime.now().toString().substring(0, 19)
                            };
                            await TodoService.patch(todo.id, map,
                                    dataLocal: map2)
                                .then((value) {
                              setState(() {
                                isLoading = false;
                                todo = value;
                              });
                            });
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: AppText("Démarer la tâche"),
                          )),
                    )
                  : todo.finishedAt != null
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: AppText("Tâche accompli"),
                        )
                      : todo.beginedAt != null && todo.finishedAt == null
                          ? ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                Map<String, String> map = {
                                  "finished_at":
                                      DateTime.now().toString().substring(0, 19)
                                };
                                Map<String, String> map2 = {
                                  "finishAt":
                                      DateTime.now().toString().substring(0, 19)
                                };
                                await TodoService.patch(todo.id, map,
                                        dataLocal: map2)
                                    .then((value) {
                                  setState(() {
                                    isLoading = false;
                                    todo = value;
                                  });
                                });
                              },
                              child: isLoading
                                  ? CircularProgressIndicator(
                                      color: AppColors.getWhiteColor,
                                    )
                                  : const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: AppText("Finir la tâche"),
                                    ))
                          : todo.finishedAt == null &&
                                  DateTime.now().millisecondsSinceEpoch >
                                      todo.deadlineAt!.millisecondsSinceEpoch
                              ? const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: AppText("Tâche non accompli"),
                                )
                              : const AppText(""),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context,
      {String title = '',
      required TextEditingController controller,
      required VoidCallback action,
      String hintText = ''}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: AppText(
            title,
            color: AppColors.getBlackColors,
            weight: FontWeight.bold,
            size: 25.0,
          ),
          content: AppSimpleInput(
            hasSuffix: false,
            hintText: hintText,
            textEditingController: controller,
            validator: (value) {
              return null;
            },
          ),
          actions: <Widget>[
            //Cancel
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: AppText(
                  'Cancel',
                  color: AppColors.getBlueNightColor,
                  size: 14.0,
                )),

            //Save
            TextButton(
                onPressed: () async {
                  action();
                  Future.delayed(const Duration(seconds: 2))
                      .then((value) => Navigator.pop(context));
                },
                child: isLoading2
                    ? const CircularProgressIndicator()
                    : AppText(
                        'Save',
                        color: AppColors.getGreenColor,
                        size: 14.0,
                      )),
          ],
        );
      },
    );
  }
}
