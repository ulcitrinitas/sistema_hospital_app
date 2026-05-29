import 'package:flutter/material.dart';
import 'package:sis_hospital/screens/home_sample.dart';
import 'package:sis_hospital/screens/nav_sample.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sistema do Hospital",
      debugShowCheckedModeBanner: true,
      initialRoute: "/home",
      routes: {"/home": (context) => HomeScreen()},
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  int _indexFor(String title) {
    switch (title) {
      case "Leitos":
        return 1;
      case "Internações":
        return 2;
      case "Prontuários":
        return 3;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.title)),
      body: Center(
        child: Text(
          "${this.title}\n(em breve)",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, color: Colors.grey),
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(currentIndex: _indexFor(this.title)),
    );
  }
}
