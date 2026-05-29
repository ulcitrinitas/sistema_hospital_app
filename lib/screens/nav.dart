import 'package:flutter/material.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const AppBottomNavBar({super.key, required this.currentIndex});

  void _onTap(BuildContext ctx, int index) {
    final routes = ["/home", "/leitos", "/internacoes", "/prontuarios"];

    if (index != currentIndex) {
      Navigator.pushReplacementNamed(ctx, routes[index]);
    }
  }

  @override
  Widget build(BuildContext context) {

    return BottomAppBarTheme();


  }

}
