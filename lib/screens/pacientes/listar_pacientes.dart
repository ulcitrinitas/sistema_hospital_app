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

  void _abrirForm({Paciente? paciente}) async {
    final atualizado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => FormPacientes(paciente: paciente)),
    );

    if (atualizado == true) _carregar();
  }
}
