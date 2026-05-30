import 'package:flutter/material.dart';
import 'package:sis_hospital/models/medico.dart';
import 'package:sis_hospital/services/medicos.dart';

class FormMedico extends StatefulWidget {
  final Medico? medico;

  const FormMedico({super.key, this.medico});

  @override
  State<FormMedico> createState() => _FormMedicoState();
}

class _FormMedicoState extends State<FormMedico> {
  final _formKey = GlobalKey<FormState>();
  final _nomeCtrl = TextEditingController();
  final _crm = TextEditingController();
  final _especialidade = TextEditingController();

  var _salvando = false;

  @override
  void initState() {
    super.initState();

    if (widget.medico != null) {
      _nomeCtrl.text = widget.medico!.nome;
      _crm.text = widget.medico!.crm;
      _especialidade.text = widget.medico!.especialidade;
    }
  }

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _crm.dispose();
    _especialidade.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _salvando = true;
    });

    final medico = Medico(
      nome: _nomeCtrl.text.trim(),
      crm: _crm.text.trim(),
      especialidade: _especialidade.text.trim(),
    );

    try {
      if (widget.medico == null) {
        await MedicosService.inserirMedico(medico);
        if (mounted) _mostrarMsg("Médico Cadastrado");
      } else {
        await MedicosService.atualizarMedico(medico);
        if (mounted) _mostrarMsg("Médico Atualizado");
      }
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      if (mounted) _mostrarMsg("Erro: $e", erro: true);
    } finally {
      if (mounted) {
        setState(() {
          _salvando = false;
        });
      }
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

  @override
  Widget build(BuildContext context) {
    final editando = widget.medico != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(editando ? "Editar Médico" : "Novo Médico"),
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
                controller: _crm,
                decoration: const InputDecoration(
                  labelText: "CPF",
                  prefixIcon: Icon(Icons.document_scanner),
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? "Informe o cpf" : null,
              ),
              const SizedBox(height: 16),

              // Campo Alergias
              TextFormField(
                controller: _especialidade,
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
