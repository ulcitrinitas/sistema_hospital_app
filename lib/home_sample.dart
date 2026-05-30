import 'package:flutter/material.dart';

// RECOMENDAÇÃO: Substitua esses mocks pelos imports reais das suas telas
// import 'package:seu_projeto/screens/pacientes_page.dart';
// import 'package:seu_projeto/screens/medicos_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // 1. Lista de telas que serão exibidas ao alternar a barra de navegação
  final List<Widget> _abas = [
    const HomeDashboard(), // Aba 0: Painel principal (Pacientes e Médicos)
    const Center(
      child: Text(
        'Tela de Leitos Disponíveis\n(Em desenvolvimento)',
        textAlign: TextAlign.center,
      ),
    ), // Aba 1
    const Center(
      child: Text(
        'Tela de Internações\n(Em desenvolvimento)',
        textAlign: TextAlign.center,
      ),
    ), // Aba 2
    const Center(
      child: Text(
        'Tela de Prontuários\n(Em desenvolvimento)',
        textAlign: TextAlign.center,
      ),
    ), // Aba 3
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Exibe a tela correspondente ao índice selecionado
      body: _abas[_currentIndex],

      // 2. Barra de navegação inferior
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType
            .fixed, // Mantém os ícones e textos visíveis (ideal para mais de 3 itens)
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Atualiza a aba ativa
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Início'),
          BottomNavigationBarItem(
            icon: Icon(Icons.single_bed),
            label: 'Leitos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_ind),
            label: 'Internações',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_shared),
            label: 'Prontuários',
          ),
        ],
      ),
    );
  }
}

// 3. Conteúdo da Aba Inicial (Dashboard)
class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel Hospitalar'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Gerenciamento principal',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Grid com os botões para acessar Pacientes e Médicos
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // 2 colunas
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildMenuCard(
                    context,
                    title: 'Pacientes',
                    icon: Icons.people,
                    color: Colors.blue,
                    onTap: () {
                      // Substitua pelo Navigator correto da sua tela de Pacientes
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => const PacientesPage()));
                    },
                  ),
                  _buildMenuCard(
                    context,
                    title: 'Médicos',
                    icon: Icons.local_hospital,
                    color: Colors.green,
                    onTap: () {
                      // Substitua pelo Navigator correto da sua tela de Médicos
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => const MedicosPage()));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para criar os cartões de acesso rápido
  Widget _buildMenuCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: color.withValues(alpha: 0.1),
                child: Icon(icon, size: 36, color: color),
              ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema Hospitalar',
      debugShowCheckedModeBanner:
          false, // Remove a fita de "Debug" do canto da tela
      theme: ThemeData(
        // Define o padrão de cores do seu aplicativo
        primarySwatch: Colors.blue,
        useMaterial3: true, // Ativa o Material 3 para um visual mais moderno
      ),
      // Define a HomePage como a primeira tela a ser aberta
      home: const HomePage(),
    );
  }
}
