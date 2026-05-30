import 'package:flutter/material.dart';
import 'package:sis_hospital/screens/home_dashboard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _abas = [
    HomeDashboard(),
    Center(child: Text("Leitos\n(Em breve)", textAlign: TextAlign.center)),
    Center(child: Text("Internações\n(Em breve)", textAlign: TextAlign.center)),
    Center(child: Text("Prontuários\n(Em breve)", textAlign: TextAlign.center)),
  ];

  void _tapIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _abas[_currentIndex],
      drawer: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Text("Sistema do Hospital"),
            decoration: BoxDecoration(color: Colors.blue),
          ),
          ListTile(
            title: Text("Página Principal"),
            selected: _currentIndex == 0,
            onTap: () {
              _tapIndex(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text("Leitos"),
            selected: _currentIndex == 1,
            onTap: () {
              _tapIndex(1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text("Internações"),
            selected: _currentIndex == 2,
            onTap: () {
              _tapIndex(2);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text("Prontuários"),
            selected: _currentIndex == 3,
            onTap: () {
              _tapIndex(3);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
