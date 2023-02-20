import 'package:flutter/material.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/services/todo_service.dart';
import 'package:todo_app/utils/app_text.dart';

class ListeTodo extends StatefulWidget {
  const ListeTodo({super.key});

  @override
  State<ListeTodo> createState() => _ListeTodoState();
}

class _ListeTodoState extends State<ListeTodo> {
  List<Todo> allTodos = [
    Todo(
        description: 'Oui oui je me lave',
        title: 'Se laver',
        beginedAt: DateTime.now(),
        finishedAt: DateTime.now().add(const Duration(hours: 10))),
    Todo(description: 'Oui oui je me lave', title: 'Se laver'),
    Todo(description: 'Oui oui je me lave', title: 'Se laver'),
    Todo(description: 'Oui oui je me lave', title: 'Se laver'),
    Todo(description: 'Oui oui je me lave', title: 'Se laver'),
    Todo(
        description: 'Oui oui la vie est belle',
        title: 'Life life is verry good'),
    Todo(
        description: 'Oui oui la vie est belle',
        title: 'Life life is verry good'),
    Todo(
        description: 'Oui oui la vie est belle',
        title: 'Life life is verry good'),
    Todo(
        description: 'Oui oui la vie est belle',
        title: 'Life life is verry good'),
    Todo(
        description: 'Oui oui la vie est belle',
        title: 'Life life is verry good'),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const AppText(
          "Liste des tâches",
          color: Colors.white,
          size: 22,
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: TodoService.fetch(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: AppText("An error occured"),
              );
            } else if (snapshot.hasData) {
              List<Todo> allTodos = snapshot.data ?? [];

              if (allTodos.isEmpty) {
                return const Center(
                  child: AppText("No task found !"),
                );
              } else {
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  clipBehavior: Clip.none,
                  itemCount: allTodos.length,
                  itemBuilder: (context, index) {
                    Todo todo = allTodos[index];
                    return ListTile(
                      title: AppText(
                        allTodos[index].title!,
                        size: 20,
                        weight: FontWeight.bold,
                      ),
                      subtitle: AppText(allTodos[index].description!),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
