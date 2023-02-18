import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:todo_app/screens/add_todo.dart';
import 'package:todo_app/screens/liste_todo.dart';
import 'package:todo_app/screens/login_screen.dart';
import 'package:todo_app/utils/app_func.dart';

class HomeState extends StatefulWidget {
  const HomeState({super.key});

  @override
  State<HomeState> createState() => _HomeState();
}

class _HomeState extends State<HomeState> {
  bool isLoadingPosts = false;
  Map<String, double> dataMap = {
    "Commencer": 5,
    "En cours": 3,
    "Finir": 2,
  };
  Map<String, double> dMap = {
    "Finir Tôt": 5,
    "Finir en retard": 3,
  };
  final gradientList = <Color>[
    const Color.fromRGBO(223, 250, 92, 1),
    const Color.fromRGBO(91, 253, 199, 1),
    const Color.fromRGBO(254, 154, 92, 1)
  ];

  final colorList = <Color>[
    const Color.fromRGBO(223, 250, 92, 1),
    const Color.fromRGBO(91, 253, 199, 1)
  ];

  loadPost() async {
    setState(() {
      isLoadingPosts = true;
    });
    try {
      // posts = await PostService.fetch();
    } on DioError catch (e) {
      print(e);
      Map<String, dynamic> error = e.response?.data;
      if (error.containsKey('message')) {
        Fluttertoast.showToast(msg: error['message']);
      } else {
        Fluttertoast.showToast(
            msg: "Une erreur est survenue veuillez rééssayer");
      }
    } finally {
      isLoadingPosts = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
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
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Center(
                  child: Text(
                    "40 Tâches crées",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.green),
                  ),
                ),
                const SizedBox(
                  height: 50,
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
                  height: 50,
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
                const SizedBox(
                  height: 70,
                ),
                ElevatedButton(
                    onPressed: () {
                      navigateToNextPage(context, const ListeTodo());
                    },
                    child: const Text("Voir la liste"))
              ]),
        ));
  }
}
