// ignore_for_file: use_build_context_synchronously

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/screens/add_todo.dart';
import 'package:todo_app/screens/liste_todo.dart';
import 'package:todo_app/screens/login_screen.dart';
import 'package:todo_app/utils/app_func.dart';
import 'package:todo_app/utils/app_text.dart';
import 'package:todo_app/utils/providers.dart';

class HomeState extends ConsumerStatefulWidget {
  const HomeState({super.key});

  @override
  ConsumerState<HomeState> createState() => _HomeState();
}

class _HomeState extends ConsumerState<HomeState> {
  bool isLoadingTodos = false;
  List<Todo> liste = [];

  Map<String, double> dataMap = {
    "Commencer": 2,
    "En cours": 3,
    "Finir": 4,
  };
  Map<String, double> dMap = {
    "Finir Tôt": 2,
    "Finir en retard": 8,
  };

  int commencer = 0;
  int enCours = 0;
  int fini = 0;
  int finiTot = 0;
  int finiRetard = 0;

  final gradientList = <Color>[
    const Color.fromRGBO(223, 250, 92, 1),
    const Color.fromRGBO(91, 253, 199, 1),
    const Color.fromRGBO(254, 154, 92, 1)
  ];

  final colorList = <Color>[
    const Color.fromRGBO(223, 250, 92, 1),
    const Color.fromRGBO(91, 253, 199, 1)
  ];

  loadTodo(List<Todo> liste) {
    print("looooooooooooooooooo");
    for (Todo t in liste) {
      if (t.beginedAt != null) {
        commencer += 1;

        if (t.finishedAt == null) {
          enCours += 1;
        } else {
          fini += 1;

          if (t.finishedAt!.millisecondsSinceEpoch <
              t.deadlineAt!.millisecondsSinceEpoch) {
            finiTot += 1;
          } else {
            finiRetard += 1;
          }
        }
      }
    }

    setState(() {
      dataMap = {
        "Commencer": commencer.toDouble(),
        "En cours": enCours.toDouble(),
        "Finir": fini.toDouble(),
      };

      dMap = {
        "Finir Tôt": finiTot.toDouble(),
        "Finir en retard": finiRetard.toDouble(),
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          navigateToNextPage(context, const CreateStackScreem());
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: ref.watch(fetchAllTodo).when(
            data: (data) {
              commencer = 0;
              enCours = 0;
              fini = 0;
              finiTot = 0;
              finiRetard = 0;
              loadTodo(data);
              return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        "${data.length} Tâches crées",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.green),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    PieChart(
                      dataMap: dataMap,
                      animationDuration: const Duration(milliseconds: 800),
                      chartLegendSpacing: 32,
                      chartRadius: MediaQuery.of(context).size.width / 3.2,
                      colorList: gradientList,
                      initialAngleInDegree: 0,
                      chartType: ChartType.ring,
                      ringStrokeWidth: 32,
                      centerText: "TÂCHES",
                      legendOptions: const LegendOptions(
                        showLegendsInRow: false,
                        legendPosition: LegendPosition.right,
                        showLegends: true,
                        // legendShape: _BoxShape.circle,
                        legendTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      chartValuesOptions: const ChartValuesOptions(
                        showChartValueBackground: true,
                        showChartValues: true,
                        showChartValuesInPercentage: false,
                        showChartValuesOutside: false,
                        decimalPlaces: 0,
                      ),
                      // gradientList: ---To add gradient colors---
                      // emptyColorGradient: ---Empty Color gradient---
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    PieChart(
                      dataMap: dMap,
                      animationDuration: const Duration(milliseconds: 800),
                      chartLegendSpacing: 32,
                      chartRadius: MediaQuery.of(context).size.width / 3.2,
                      colorList: colorList,
                      initialAngleInDegree: 0,
                      chartType: ChartType.ring,
                      ringStrokeWidth: 32,
                      centerText: "TÂCHES",
                      legendOptions: const LegendOptions(
                        showLegendsInRow: false,
                        legendPosition: LegendPosition.right,
                        showLegends: true,
                        // legendShape: _BoxShape.circle,
                        legendTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      chartValuesOptions: const ChartValuesOptions(
                          showChartValueBackground: true,
                          showChartValues: true,
                          showChartValuesInPercentage: false,
                          showChartValuesOutside: false,
                          decimalPlaces: 0),
                      // gradientList: ---To add gradient colors---
                      // emptyColorGradient: ---Empty Color gradient---
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                          onPressed: () {
                            ref.refresh(fetchAllTodo);
                            navigateToNextPage(context, const ListeTodo());
                          },
                          child: const Text("Voir la liste")),
                    )
                  ]);
            },
            error: (error, stackTrace) {
              return const Center(
                child: AppText("Une erreur est survenue"),
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }
}
