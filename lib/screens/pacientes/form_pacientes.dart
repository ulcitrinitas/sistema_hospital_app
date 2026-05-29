import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sis_hospital/models/paciente.dart';
import 'package:sis_hospital/services/pacientes.dart';

class FormPacientes extends StatefulWidget {
  final Paciente? paciente;

  const FormPacientes({super.key, this.paciente});

  @override
  State<FormPacientes> createState() => _FormPacientesState();
}

class _FormPacientesState extends State<FormPacientes> {
  final _formKey = GlobalKey<FormState>();
  final _nomeCtrl = TextEditingController();
  final _cpfCtrl = TextEditingController();
  final _nascCtrl = TextEditingController();
  final _alergiasCtrl = TextEditingController();

  var _salvando = false;

  @override
  void initState() {
    super.initState();

    if (widget.paciente != null) {
      _nomeCtrl.text = widget.paciente!.nome;
      _cpfCtrl.text = widget.paciente!.cpf;
      _nascCtrl.text = widget.paciente!.nasc.toString();
      _alergiasCtrl.text = widget.paciente!.alergias;
    }
  }

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _cpfCtrl.dispose();
    _nascCtrl.dispose();
    _alergiasCtrl.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _salvando = true;
    });

    final paciente = Paciente(
      id: widget.paciente?.id,
      nome: _nomeCtrl.text.trim(),
      cpf: _cpfCtrl.text.trim(),
      nasc: widget.paciente!.parseDateTime(_nascCtrl.text.trim()),
      alergias: _alergiasCtrl.text.trim(),
    );

    try {
      if (widget.paciente == null) {
        await PacientesService.inserirPaciente(paciente);
        if (mounted) _mostrarMsg("Paciente Cadastrado");
      } else {
        await PacientesService.atualizarPaciente(paciente);
        if (mounted) _mostrarMsg("Paciente Atualizado");
      }
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      if (mounted) _mostrarMsg("Erro: $e", erro: true);
    } finally {
      if (mounted)
        setState(() {
          _salvando = false;
        });
    }
  }

  void _mostrarMsg(String msg, {var erro = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: erro ? Colors.red : Colors.green,
      ),
    );
  }

  Future<void> _selectDate(BuildContext ctx) async {
    // abre o seletor de data
    final DateTime? dt_escolhida = await showDatePicker(
      context: ctx,
      initialDate: DateTime.now(),
      firstDate: DateTime(1930),
      lastDate: DateTime(2030),
      locale: const Locale("pt", "BR"),
    );

    if (dt_escolhida != null) {
      setState(() {
        _nascCtrl.text = DateFormat("dd/MM/yyyy").format(dt_escolhida);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final editando = widget.paciente != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(editando ? "Editar Paciente" : "Novo Paciente"),
        backgroundColor: const Color(0xFF5611E1),
        foregroundColor: const Color(0xFFE8F2F3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Campo de nome
              TextFormField(
                controller: _nomeCtrl,
                decoration: const InputDecoration(
                  labelText: "Nome *",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? "Informe o nome" : null,
              ),
              const SizedBox(height: 16),

              // Campo CPF
              TextFormField(
                controller: _cpfCtrl,
                decoration: const InputDecoration(
                  labelText: "CPF",
                  prefixIcon: Icon(Icons.document_scanner),
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? "Informe o cpf" : null,
              ),
              const SizedBox(height: 16),

              // Campo data de nascimento
              // Campo CPF
              TextFormField(
                controller: _nascCtrl,
                decoration: const InputDecoration(
                  labelText: "Data de nascimento",
                  prefixIcon: Icon(Icons.date_range_rounded),
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
              ),
              const SizedBox(height: 16),

              // Campo Alergias
              TextFormField(
                controller: _alergiasCtrl,
                decoration: const InputDecoration(
                  labelText: "Alergias",
                  prefixIcon: Icon(Icons.health_and_safety_sharp),
                  border: OutlineInputBorder(),
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? "Informe as alergias"
                    : null,
              ),
              const SizedBox(height: 16),

              // Botão Salvar
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: _salvando ? null : _salvar,
                  icon: _salvando
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Icon(Icons.save),
                  label: Text(_salvando ? "Salvando..." : "Salvar"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
