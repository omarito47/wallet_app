import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wallet_app/global/theme/light_mode.dart';
import 'package:wallet_app/main.dart';
import 'package:wallet_app/module/splashscreen/view/splash_screen.dart';
export 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(//2 notifier l'app si il y'a de changement 
      //instance pour observer le changement dans ThemeProvider
      create: (_) => ThemeProvider(), //1 Creates an instance of ThemeProvider and provides it to the widget tree
      child: Consumer<ThemeProvider>(
        // Listens to changes in the provided ThemeProvider instance from changeNotifierProvider
        // & rebuild the widget tree below it whenever the notified value changes
        builder: (context, themeProvider, _) {
          return MaterialApp(//
            themeMode: themeProvider.themeMode, 
            theme: themeProvider.lightTheme, 
            darkTheme: themeProvider.darkTheme,
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',//title of the app when the app on background 
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
