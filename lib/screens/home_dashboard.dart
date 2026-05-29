import 'package:flutter/material.dart';

class HomeDashboard extends StatelessWidget {
  HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sistema do Hospital"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
    );
  }
}
