import 'package:flutter/material.dart';
import 'package:wallet_app/module/auth/view/login_page.dart';
import 'package:wallet_app/module/auth/view/register_page.dart';


class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => LoginOrRegisterState();
}

class LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;
  // toggle between login and register
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onTap: togglePages,
      );
    } else {
      return RegisterPage(
        onTap: togglePages,
      );
    }
  }
}
