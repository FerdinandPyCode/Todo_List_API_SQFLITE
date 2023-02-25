import 'package:flutter/material.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/services/todo_service.dart';
import 'package:todo_app/screens/detail_todo.dart';
import 'package:todo_app/utils/app_func.dart';
import 'package:todo_app/utils/app_text.dart';
import 'package:todo_app/utils/colors.dart';

import '../data/services/sql_database.dart';

class ListeTodo extends StatefulWidget {
  const ListeTodo({super.key});

  @override
  State<ListeTodo> createState() => _ListeTodoState();
}

class _ListeTodoState extends State<ListeTodo> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const AppText(
          "List of todos",
          color: Colors.white,
          size: 22,
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future:  TodoService.fetch(),
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
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10.0),
                      width: double.infinity,
                      height: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: AppColors.getWhiteColor, 
                        boxShadow: [
                            BoxShadow(
                              color: AppColors.getGreenColor, 
                              spreadRadius: 2.0,
                              offset: Offset(0, 1), 
                              blurRadius: 3.0,

                            )
                        ]
                      ),
                      child: ListTile(
                        /*  voici les couleurs du text:
                          -Bleue:La tâche est en cours  
                          -Rouge:Délai expiré 
                          -Bleu pas encore demarré
                         */
                        trailing: AppText("Starting",color: AppColors.getGreenColor,size: 13.0,isNormal: false,),
                        onTap: () {
                          navigateToNextPage(context, TodoDetail(todo: todo));
                        },
                        title: AppText(
                          todo.title!,
                          size: 20,
                          weight: FontWeight.bold,
                        ),
                        subtitle: AppText(todo.description!),
                      ),
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
