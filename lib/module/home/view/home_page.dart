import 'package:flutter/material.dart';
import 'package:wallet_app/global/components/app_drawer.dart';
import 'package:wallet_app/module/home/controller/home_controller.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
         backgroundColor: Color(0xff648ddb),
        title: const Text("Home"),
      ),
      body: Center(
        child: Text("${_homeController.authService.getCurrentUser()!.email}"),
      ),
      drawer: const MyDrawer(),
    );
  }
}
