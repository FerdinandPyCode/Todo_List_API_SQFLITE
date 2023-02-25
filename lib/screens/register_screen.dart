import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/data/services/users_service.dart';
import 'package:todo_app/screens/login_screen.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/app_func.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool _passwordVisible = false;

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  _register(email, username, password) async {
    setState(() {
      isLoading = true;
    });
    try {
      var result = await UserService.create(
          {'username': username, 'email': email, 'password': password});
      Fluttertoast.showToast(msg: "Utilisateur créé avec succès");
      navigateToNextPage(context, const LoginScreen(), back: false);
    } on DioError catch (e) {
      Map<String, dynamic> error = e.response?.data;
      if (error.containsKey('message')) {
        Fluttertoast.showToast(msg: error['message']);
      } else {
        Fluttertoast.showToast(
            msg: "Une erreur est survenue veuillez rééssayer");
      }
      print(e.response);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30.0,
                ),
                const Center(
                  child: Text(
                    "Inscription",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                SvgPicture.asset(
                  'assets/register.svg',
                  width: MediaQuery.of(context).size.width,
                  height: 320,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Text(
                  "Get Registered From Here",
                  style: TextStyle(fontSize: 12.0),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //Pseudo
                      children: [
                        const Text(
                          "Pseudo",
                          style: TextStyle(fontSize: 12.0),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black12,
                              ),
                              color: Colors.grey[100],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: TextFormField(
                            controller: usernameController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                                hintText: "Entrez votre pseudo",
                                labelText: "Pseudo",
                                icon: Icon(Icons.person)),
                            validator: (value) {
                              return value == null || value == ""
                                  ? "Ce champs est obligatoire"
                                  : null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),

                        // Email
                        const Text(
                          "Email",
                          style: TextStyle(fontSize: 12.0),
                        ),

                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black12,
                              ),
                              color: Colors.grey[100],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                hintText: "Entrez votre e-mail",
                                labelText: "E-mail",
                                icon: Icon(Icons.alternate_email)),
                            validator: (value) {
                              return value == null || value == ""
                                  ? "Ce champs est obligatoire"
                                  : null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),

                        // Password
                        const Text(
                          "Password",
                          style: TextStyle(fontSize: 12.0),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black12,
                              ),
                              color: Colors.grey[100],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                              hintText: "Entrez votre mot de passe",
                              labelText: "Mot de passe",
                              icon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                                icon: _passwordVisible
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                              ),
                            ),
                            validator: (value) {
                              return value == null || value == ""
                                  ? "Ce champs est obligatoire"
                                  : null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Center(
                          child: ElevatedButton(
                              onPressed: () async {
                                if (!isLoading &&
                                    formKey.currentState!.validate()) {
                                  await _register(
                                      emailController.text,
                                      usernameController.text,
                                      passwordController.text);
                                  emailController.text = "";
                                  usernameController.text = "";
                                  passwordController.text = "";
                                }
                              },
                              child: isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 3,
                                      ))
                                  : const Text("S'inscrire")),
                        )
                      ],
                    )),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: const Text(
                      "Vous avez un compte? Connectez vous",
                      style: TextStyle(fontSize: 17, color: Colors.green),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
