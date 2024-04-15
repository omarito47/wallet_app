import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:wallet_app/global/utils/global.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentIndex = 0;
  late PageController _controller;
  late SharedPreferences _prefs;
  bool skip = false;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    initSharedPreferences();
    super.initState();
  }

  Future<void> initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    skip = _prefs.getBool('skip') ?? false;
    if (skip) {
      navigateToNextScreen();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _skipOnboarding() async {
    await _prefs.setBool('skip', true);
    navigateToNextScreen();
  }

  void navigateToNextScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => AuthGate(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: const LinearGradient(
                colors: [Colors.blue, Colors.white],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft)),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .8,
              child: PageView.builder(
                controller: _controller,
                itemCount: contents.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, i) {
                  return Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          contents[i].image,
                          height: 300,
                        ),
                        Text(
                          contents[i].title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          contents[i].discription,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  contents.length,
                  (index) => buildDot(index, context),
                ),
              ),
            ),
            Container(
              height: 60,
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text(
                      currentIndex == contents.length - 1 ? "Continue" : "Next",
                    ),
                    onPressed: () {
                      if (currentIndex == contents.length - 1) {
                        _skipOnboarding();
                      } else {
                        _controller.nextPage(
                          duration: Duration(milliseconds: 100),
                          curve: Curves.bounceIn,
                        );
                      }
                    },
                  ),
                  SizedBox(width: 10),
                  TextButton(
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: _skipOnboarding,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
