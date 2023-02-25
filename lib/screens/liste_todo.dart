import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/screens/detail_todo.dart';
import 'package:todo_app/utils/app_func.dart';
import 'package:todo_app/utils/app_text.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/providers.dart';

class ListeTodo extends ConsumerStatefulWidget {
  const ListeTodo({super.key});

  @override
  ConsumerState<ListeTodo> createState() => _ListeTodoState();
}

class _ListeTodoState extends ConsumerState<ListeTodo> {
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
        child: ref.watch(fetchAllTodo).when(
          data: (data) {
            if (data.isEmpty) {
              return const Center(
                child: AppText("No task found !"),
              );
            } else {
              return ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                clipBehavior: Clip.none,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  Todo todo = data[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 10.0),
                    width: double.infinity,
                    height: 80.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: AppColors.getWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.getGreenColor,
                            spreadRadius: 2.0,
                            offset: const Offset(0, 1),
                            blurRadius: 3.0,
                          )
                        ]),
                    child: ListTile(
                      trailing: AppText(
                        todo.beginedAt == null &&
                                DateTime.now().millisecondsSinceEpoch <
                                    todo.deadlineAt!.millisecondsSinceEpoch
                            ? "En attente"
                            : todo.finishedAt != null
                                ? "Fini"
                                : todo.beginedAt != null &&
                                        todo.finishedAt == null
                                    ? "En cours"
                                    : todo.finishedAt == null &&
                                            DateTime.now()
                                                    .millisecondsSinceEpoch >
                                                todo.deadlineAt!
                                                    .millisecondsSinceEpoch
                                        ? "Expiré"
                                        : "",
                        color: todo.beginedAt == null &&
                                DateTime.now().millisecondsSinceEpoch <
                                    todo.deadlineAt!.millisecondsSinceEpoch
                            ? AppColors.getBlackColors
                            : todo.finishedAt != null
                                ? AppColors.getGreenColor
                                : todo.beginedAt != null &&
                                        todo.finishedAt == null
                                    ? AppColors.getblueColor
                                    : todo.finishedAt == null &&
                                            DateTime.now()
                                                    .millisecondsSinceEpoch >
                                                todo.deadlineAt!
                                                    .millisecondsSinceEpoch
                                        ? AppColors.getRedColor
                                        : AppColors.getblueColor,
                        size: 13.0,
                        isNormal: false,
                      ),
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
          },
          error: (error, stackTrace) {
            return const Center(
              child: AppText("An error occured"),
            );
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
// FutureBuilder(
        //   future: TodoService.fetch(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasError) {
        //       return const Center(
        //         child: AppText("An error occured"),
        //       );
        //     } else if (snapshot.hasData) {
        //       List<Todo> allTodos = snapshot.data ?? [];
              
        //       if (allTodos.isEmpty) {
        //         return const Center(
        //           child: AppText("No task found !"),
        //         );
        //       } else {
        //         return ListView.separated(
        //           padding: const EdgeInsets.symmetric(vertical: 5.0),
        //           physics: const BouncingScrollPhysics(),
        //           shrinkWrap: true,
        //           clipBehavior: Clip.none,
        //           itemCount: allTodos.length,
        //           itemBuilder: (context, index) {
        //             Todo todo = allTodos[index];
        //             return Container(
        //               margin: const EdgeInsets.symmetric(
        //                   horizontal: 8.0, vertical: 10.0),
        //               width: double.infinity,
        //               height: 80.0,
        //               decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.circular(10.0),
        //                   color: AppColors.getWhiteColor,
        //                   boxShadow: [
        //                     BoxShadow(
        //                       color: AppColors.getGreenColor,
        //                       spreadRadius: 2.0,
        //                       offset: const Offset(0, 1),
        //                       blurRadius: 3.0,
        //                     )
        //                   ]),
        //               child: ListTile(
        //                 /*  voici les couleurs du text:
        //                   -Bleue:La tâche est en cours  
        //                   -Rouge:Délai expiré 
        //                   -Bleu pas encore demarré
        //                  */
        //                 trailing: AppText(
        //                   "Starting",
        //                   color: AppColors.getGreenColor,
        //                   size: 13.0,
        //                   isNormal: false,
        //                 ),
        //                 onTap: () {
        //                   navigateToNextPage(context, TodoDetail(todo: todo));
        //                 },
        //                 title: AppText(
        //                   todo.title!,
        //                   size: 20,
        //                   weight: FontWeight.bold,
        //                 ),
        //                 subtitle: AppText(todo.description!),
        //               ),
        //             );
        //           },
        //           separatorBuilder: (context, index) {
        //             return const Divider();
        //           },
        //         );
        //       }
        //     } else {
        //       return const Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }
        //   },
        // ),