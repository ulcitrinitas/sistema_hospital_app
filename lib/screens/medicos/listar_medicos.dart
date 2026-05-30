import 'package:flutter/material.dart';
import 'package:sis_hospital/models/medico.dart';
import 'package:sis_hospital/screens/medicos/form_medico.dart';
import 'package:sis_hospital/services/medicos.dart';

class ListarMedicos extends StatefulWidget {
  const ListarMedicos({super.key});

  @override
  State<StatefulWidget> createState() => _ListarmedicosState();
}

class _ListarmedicosState extends State<ListarMedicos> {
  List<Medico> _medicos = [];
  var _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  Future<void> _carregar() async {
    setState(() => _carregando = true);

    try {
      final lista = await MedicosService.listarMedicos();
      setState(() => _medicos = lista);
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

  Future<void> _excluir(Medico m) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirmar exclusão"),
        content: Text("Deseja excluir ${m.nome}"),
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
        await MedicosService.excluirMedico(m);
        _snack("Medico excluido");
        _carregar();
      } catch (e) {
        _snack("Erro ao excluir: $e", erro: true);
      }
    }
  }

  void _abrirForm({Medico? medico}) async {
    final atualizado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => FormMedico(medico: medico)),
    );

    if (atualizado == true) _carregar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("medicos do hospital"),
        backgroundColor: const Color(0xFF5611E1),
        foregroundColor: const Color(0xFFE8F2F3),
        actions: [IconButton(onPressed: _carregar, icon: Icon(Icons.refresh))],
      ),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : _medicos.isEmpty
          ? const Center(
              child: Text(
                "Nenhum medico cadastrado",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.separated(
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemCount: _medicos.length,
              itemBuilder: (context, i) {
                final m = _medicos[i];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(
                      m.nome[0].toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    m.nome,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("${m.especialidade}"),
                  isThreeLine: true,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => _abrirForm(medico: m),
                        icon: const Icon(Icons.edit, color: Colors.amber),
                      ),
                      IconButton(
                        onPressed: () => _excluir(m),
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirForm(),
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
