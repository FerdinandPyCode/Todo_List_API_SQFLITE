import 'package:flutter/material.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/services/todo_service.dart';
import 'package:todo_app/utils/app_func.dart';
import 'package:todo_app/utils/app_text.dart';
import 'package:todo_app/utils/colors.dart';

class TodoDetail extends StatefulWidget {
  final Todo todo;
  const TodoDetail({required this.todo, super.key});

  @override
  State<TodoDetail> createState() => _TodoDetailState();
}

class _TodoDetailState extends State<TodoDetail> {
  Todo todo = Todo.initial();

  bool isLoading = false;

  @override
  void initState() {
    todo = widget.todo;
    super.initState();
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
                child: AppText(
                  todo.title!,
                  size: 20,
                  //weight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: getSize(context).height * .09,
              ),
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
                child: AppText(
                  todo.description!,
                  size: 20,
                  //weight: FontWeight.bold,
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
}
