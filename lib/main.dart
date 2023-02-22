import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/utils/constants.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  String token = prefs.getString(Constant.TOKEN_PREF_KEY) ?? '';

  String firstPage = 'LOGIN';

  print(token);
  if (token != '') {
    DateTime? expiryDate = Jwt.getExpiryDate(token);

    if (expiryDate!.millisecondsSinceEpoch >
        DateTime.now().millisecondsSinceEpoch) {
      firstPage = "HOME";
    }
  }

  runApp(MyApp(firstPage: firstPage));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.firstPage});

  final String firstPage;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: firstPage == 'LOGIN' ? const LoginScreen() : const HomeState(),
    );
  }
}
