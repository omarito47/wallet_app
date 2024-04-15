import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:wallet_app/global/utils/global.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Onboarding(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.white],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.wallet,
                size: 80,
              ),
              Text(
                "My wallet",
                style: TextStyle(fontSize: ConstantHelper.sizex30),
              )
            ],
          ),
        ),
      ),
    );
  }
}
