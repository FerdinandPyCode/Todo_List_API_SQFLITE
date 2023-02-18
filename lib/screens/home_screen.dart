import 'package:flutter/material.dart';
import 'package:todo_app/screens/liste_todo.dart';
import 'package:todo_app/utils/app_func.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                navigateToNextPage(context, const ListeTodo());
              },
              child: const Text("Voir la liste des tâches")),
        ],
      )),
      appBar: AppBar(
        title: const Text(
          'TodoAPP',
          style: TextStyle(fontSize: 22),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
