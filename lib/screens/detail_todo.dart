import 'package:flutter/material.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/utils/app_text.dart';

class TodoDetail extends StatefulWidget {
  final Todo todo;
  const TodoDetail({required this.todo, super.key});

  @override
  State<TodoDetail> createState() => _TodoDetailState();
}

class _TodoDetailState extends State<TodoDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const AppText(
          "Detail todo",
          color: Colors.white,
          size: 22,
        ),
      ),
      body: Center(
        child: AppText(widget.todo.title!),
      ),
    );
  }
}
