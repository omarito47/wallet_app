import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:wallet_app/global/utils/global.dart';

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
            CustomButton(
                onTap: () => login(context),
                text: "Login",
                backgroundColor: Color.fromARGB(255, 43, 119, 170)),
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
            SizedBox(
              height: ConstantHelper.sizex25,
            ),
            // Sign in with google button
            CustomButton(
                onTap: () async {
                  final GoogleSignInAccount? gUser =
                      await GoogleSignIn().signIn();

                  final GoogleSignInAuthentication gAuth =
                      await gUser!.authentication;
                  final credential = GoogleAuthProvider.credential(
                    accessToken: gAuth.accessToken,
                    idToken: gAuth.idToken,
                  );
                  await FirebaseAuth.instance
                      .signInWithCredential(credential)
                      .then((value) {
                    if (FirebaseAuth.instance.currentUser != null) {
                      //create a logic if the email is omartaamallah4@gmail.com go to welcome screen if not go to welcomescreen withn the email the user will sign in with
                      print(
                          "Info=====${FirebaseAuth.instance.currentUser!.email}");
                      print(
                          "Info=====${FirebaseAuth.instance.currentUser!.displayName}");
                      print(
                          "Info=====${FirebaseAuth.instance.currentUser!.phoneNumber}");
                      print(
                          "Info=====${FirebaseAuth.instance.currentUser!.photoURL}");
                      print(
                          "Info=====${FirebaseAuth.instance.currentUser!.metadata}");
                    }
                  });
                },
                text: "Sign in with    ",
                imagePath: "assets/google_logo.png",
                backgroundColor: Color.fromARGB(255, 186, 188, 188)),
          ],
        ),
      ),
    );
  }
}
