import 'package:flutter/material.dart';
import 'package:sis_hospital/models/paciente.dart';
import 'package:sis_hospital/screens/pacientes/form_pacientes.dart';
import 'package:sis_hospital/services/pacientes.dart';

class ListarPacientes extends StatefulWidget {
  const ListarPacientes({super.key});

  @override
  State<StatefulWidget> createState() => _ListarPacientesState();
}

class _ListarPacientesState extends State<ListarPacientes> {
  List<Paciente> _pacientes = [];
  var _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  Future<void> _carregar() async {
    setState(() => _carregando = true);

    try {
      final lista = await PacientesService.listarPacientes();
      setState(() => _pacientes = lista);
    } catch (e) {
      _snack("Erro ao carregar: $e", erro: true);
    } finally {
      setState(() {
        _carregando = false;
      });
    }
  }

  void _snack(String msg, {var erro = false}) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: erro ? Colors.red : Colors.green,
      ),
    );
  }

  Future<void> _excluir(Paciente p) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirmar exclusão"),
        content: Text("Deseja excluir ${p.nome}"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Excluir", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmar == true) {
      try {
        await PacientesService.excluirPaciente(p);
        _snack("Paciente excluido");
        _carregar();
      } catch (e) {
        _snack("Erro ao excluir: $e", erro: true);
      }
    }
  }

  void _abrirForm({Paciente? paciente}) async {
    final atualizado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => FormPacientes(paciente: paciente)),
    );

    if (atualizado == true) _carregar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pacientes do hospital"),
        backgroundColor: const Color(0xFF5611E1),
        foregroundColor: const Color(0xFFE8F2F3),
        actions: [IconButton(onPressed: _carregar, icon: Icon(Icons.refresh))],
      ),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : _pacientes.isEmpty
          ? const Center(
              child: Text(
                "Nenhum paciente cadastrado",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.separated(
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemCount: _pacientes.length,
              itemBuilder: (context, i) {
                final p = _pacientes[i];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(
                      p.nome[0].toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    p.nome,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("${p.nasc}\n${p.alergias}"),
                  isThreeLine: true,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => _abrirForm(paciente: p),
                        icon: const Icon(Icons.edit, color: Colors.amber),
                      ),
                      IconButton(
                        onPressed: () => _excluir(p),
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
