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
    return Scaffold(
      appBar: AppBar(
        title: const AppText(
          "Detail todo",
          color: Colors.white,
          size: 22,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: getSize(context).width * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: getSize(context).height * .05,
            ),
            Center(
              child: AppText(
                todo.title!,
                size: 22,
                weight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: getSize(context).height * .09,
            ),
            AppText(todo.description!),
            SizedBox(
              height: getSize(context).height * .09,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Column(
                children: [
                  const AppText("Deadline Date"),
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
            AppText(
              "Todo State",
              color: AppColors.getGreenColor,
              size: 20,
            ),
            SizedBox(
              height: getSize(context).height * .03,
            ),
            (todo.beginedAt == null || todo.beginedAt == '') &&
                    DateTime.now().millisecondsSinceEpoch <
                        todo.deadlineAt!.millisecondsSinceEpoch
                ? ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      logd(todo.user);
                      logd(todo);

                      Map<String, String> map = {
                        "begined_at": DateTime.now().toString().substring(0, 19)
                      };

                      Map<String, String> map2 = {
                        "beginedAt": DateTime.now().toString().substring(0, 19)
                      };
                      await TodoService.patch(todo.id, map, dataLocal: map2)
                          .then((value) {
                        setState(() {
                          isLoading = false;
                          todo = value;
                        });
                      });
                    },
                    child: const AppText("Démarer la tâche"))
                : (todo.finishedAt != null || todo.finishedAt != '')
                    ? const AppText("Tâche accompli ")
                    : (todo.beginedAt != null || todo.beginedAt != '') &&
                            (todo.deadlineAt == null || todo.deadlineAt == '')
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
                                "finishedAt":
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
                                : const AppText("Finir la tâche"))
                        : todo.finishedAt == null &&
                                DateTime.now().millisecondsSinceEpoch >
                                    todo.deadlineAt!.millisecondsSinceEpoch
                            ? const AppText("Tâche non accompli")
                            : Container(),
          ],
        ),
      ),
    );
  }
}
