import 'package:flutter/material.dart';

import 'package:wallet_app/module/home/controller/home_controller.dart';
import 'package:wallet_app/global/utils/global.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final HomeController _homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Color(0xff648ddb),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      "${_homeController.authService.getCurrentUser()!.photoURL}") // Replace with your own image URL
                  ),
              SizedBox(height: 20),
              Text(
                '${_homeController.authService.getCurrentUser()!.displayName}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Software Developer',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              SizedBox(height: 20),
              Text(
                'About Me',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Icon(Icons.mail_outlined, size: 50),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  '${_homeController.authService.getCurrentUser()!.email}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Icon(Icons.phone, size: 50),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child:
                    _homeController.authService.getCurrentUser()!.phoneNumber ==
                            null
                        ? Text(
                            'Phone number not available',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          )
                        : Text(
                            '${_homeController.authService.getCurrentUser()!.phoneNumber}',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
              ),
              Row(
                children: [
                  SizedBox(width: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}