import 'package:flutter/material.dart';

import 'beach_data.dart';
import 'sizes.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  BeachData beachData = BeachData.instance;
  Sizes sizes = Sizes.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: sizes.colorBackground,
      appBar: AppBar(
        toolbarHeight: sizes.heightToolbar,
        backgroundColor: sizes.colorBackground,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            size: 0.05 * sizes.screenHeight,
            color: sizes.colorTitle,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          "LOGIN BEACH",
          style: TextStyle(
              color: sizes.colorTitle,
              fontSize: sizes.sizeFontTitle,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: TextFormField(
                  controller: emailController,
                  cursorColor: Colors.yellow,
                  decoration: InputDecoration(
                    iconColor: Colors.yellow,
                    focusColor: Colors.cyan,
                    border: const OutlineInputBorder(),
                    labelText: "Email adres",
                    labelStyle: TextStyle(
                        color: Colors.yellow, fontSize: sizes.sizeFontLogin),
                  ),
                  validator: (value) {
//                    if (value == null || value.isEmpty) {
                    //                    return 'Voer emailadres in';
                    //                }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Wachtwoord",
                    labelStyle: TextStyle(
                        color: Colors.yellow, fontSize: sizes.sizeFontLogin),
                  ),
                  validator: (value) {
//                    if (value == null || value.isEmpty) {
                    //                    return 'Voer wachtwoord in';
                    //                }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(sizes.buttonWidth, sizes.buttonHeight),
                        shape: const StadiumBorder(),
                        side: BorderSide(
                            color: Colors.black,
                            width: sizes.buttonBorderWidth),
                        backgroundColor: sizes.colorButton),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Navigate the user to the Home page
                        debugPrint(passwordController.text.toString());
                        if (passwordController.text == "t") {
                          beachData.setAccess(true);
                          Navigator.pop(context);
                        }
                      } else {
                        instruction(context);
                      }
                    },
                    child: Text(
                      'INLOGGEN',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: sizes.sizeFontButton,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void instruction(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Colors.cyan,
          content: Text(
            'Voer email adres en wachtwoord van jouw account op de ABEACH website in',
            style:
                TextStyle(color: Colors.yellow, fontSize: sizes.sizeFontBeach),
          )),
    );
  }
}
