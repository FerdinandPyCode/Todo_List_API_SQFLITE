import 'package:flutter/material.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/utils/app_func.dart';
import 'package:todo_app/utils/app_text.dart';

class TodoDetail extends StatefulWidget {
  final Todo todo;
  const TodoDetail({required this.todo, super.key});

  @override
  State<TodoDetail> createState() => _TodoDetailState();
}

class _TodoDetailState extends State<TodoDetail> {
  Todo todo = Todo.initial();

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
                  AppText(todo.deadlineAt.toString()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
