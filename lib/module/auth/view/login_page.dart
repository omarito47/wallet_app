import 'package:flutter/material.dart';
import 'package:wallet_app/global/components/custom_button.dart';
import 'package:wallet_app/global/components/custom_text_field.dart';
import 'package:wallet_app/global/services/auth/auth_service.dart';
import 'package:wallet_app/global/utils/constant_helper.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwControlller = TextEditingController();
  void login(BuildContext context) async {
    //auth service
    final authService = AuthService();
    // try login
    try {
      await authService.signInWithEmailAndPassword(
          _emailController.text, _pwControlller.text);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            Icon(
              Icons.wallet,
              size: ConstantHelper.sizex60,
              color: Theme.of(context).colorScheme.primary,
            ),
            Text(
              'My wallet',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: ConstantHelper.sizex14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: ConstantHelper.sizex30,
            ),

            // welcome back message
            Text(
              'Login',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: ConstantHelper.sizex14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: ConstantHelper.sizex20,
            ),
            // email textFiled
            CustomTextFiled(
              hintText: "Email",
              obsucureText: false,
              controller: _emailController,
            ),
            SizedBox(
              height: ConstantHelper.sizex10,
            ),
            // password textFiled
            CustomTextFiled(
              hintText: "Password",
              obsucureText: true,
              controller: _pwControlller,
            ),
            SizedBox(
              height: ConstantHelper.sizex25,
            ),
            // login button
            CustomButton(onTap: () => login(context), text: "Login"),
            SizedBox(
              height: ConstantHelper.sizex25,
            ),
            // register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a member? ",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    "Register now",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
