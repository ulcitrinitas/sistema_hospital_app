import 'package:flutter/material.dart';
import 'package:sis_hospital/screens/medicos/listar_medicos.dart';
import 'package:sis_hospital/screens/pacientes/listar_pacientes.dart';

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Detecta a largura da tela (consideramos mobile se for menor que 600px)
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    // Lista de dados para os cards, evitando duplicação de código
    final menuItems = [
      {
        "title": "Pacientes",
        "icon": Icons.person,
        "color": Colors.blue,
        "onTap": () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ListarPacientes()),
        ),
      },
      {
        "title": "Médicos",
        "icon": Icons
            .local_hospital, // Mudei para um ícone de médico para diferenciar!
        "color": Colors.blue,
        "onTap": () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ListarMedicos()),
        ),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sistema do Hospital"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tela Principal",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // O conteúdo principal se adapta ao tamanho da tela
            Expanded(
              child: isMobile
                  ? ListView.separated(
                      itemCount: menuItems.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final item = menuItems[index];
                        return _buildMenuListTile(
                          context,
                          title: item["title"] as String,
                          icon: item["icon"] as IconData,
                          color: item["color"] as Color,
                          onTap: item["onTap"] as VoidCallback,
                        );
                      },
                    )
                  : GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      children: menuItems.map((item) {
                        return _buildMenuCard(
                          context,
                          title: item["title"] as String,
                          icon: item["icon"] as IconData,
                          color: item["color"] as Color,
                          onTap: item["onTap"] as VoidCallback,
                        );
                      }).toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Layout 1: Card em formato de bloco (para Desktop/Tablet em Grid)
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

  // Layout 2: Card em formato de linha/lista (para Mobile empilhado)
  Widget _buildMenuListTile(
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: color.withValues(alpha: 0.1),
                child: Icon(icon, size: 28, color: color),
              ),
              const SizedBox(width: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
