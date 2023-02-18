import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/utils/app_text.dart';
import 'package:todo_app/utils/colors.dart';

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
        child: SingleChildScrollView(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            clipBehavior: Clip.none,
            itemCount: allTodos.length,
            itemBuilder: (context, index) {
              Todo todo = allTodos[index];
              return Slidable(
                key: Key(todo.title!),
                startActionPane: ActionPane(
                  dismissible: DismissiblePane(
                    onDismissed: (() => null),
                  ),
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                        backgroundColor: AppColors.getGreenColor,
                        icon: Icons.edit,
                        label: 'Modifier',
                        onPressed: (context) => null),
                    SlidableAction(
                        backgroundColor: AppColors.getblueColor,
                        icon: Icons.archive,
                        label: 'SMS',
                        onPressed: (context) => null)
                  ],
                ),
                endActionPane: ActionPane(
                  dismissible: DismissiblePane(
                    onDismissed: (() => null),
                  ),
                  motion: const BehindMotion(),
                  children: [
                    SlidableAction(
                      label: 'Delete',
                      backgroundColor: AppColors.getRedColor,
                      icon: Icons.delete,
                      onPressed: (context) => null,
                    )
                  ],
                ),
                child: ListTile(
                  title: AppText(
                    allTodos[index].title!,
                    size: 20,
                    weight: FontWeight.bold,
                  ),
                  subtitle: AppText(allTodos[index].description!),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          ),
        ),
      ),
    );
  }
}
