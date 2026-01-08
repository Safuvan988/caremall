import 'package:caremall/cartprovider.dart';
import 'package:caremall/home/homescreen.dart';
import 'package:caremall/onbordingscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: isLoggedIn ? const Homescreen() : const OnboardingScreen(),
      routes: {
        '/home': (context) => const Homescreen(),
        '/onboarding': (context) => const OnboardingScreen(),
      },
    );
  }
}
