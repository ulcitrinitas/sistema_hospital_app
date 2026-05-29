import 'dart:convert';

import 'package:sis_hospital/services/api.dart';
import 'package:sis_hospital/models/medico.dart';

import 'package:http/http.dart' as http;

class MedicoService {
  static final String url = "${ApiService.baseUrl}/medicos";

  static Future<List<Medico>> listarPacientes() async {
    final respose = await http.get(Uri.parse(url));

    if (respose.statusCode == 200) {
      final body = respose.body.trim();

      if (body.startsWith("<")) {
        throw Exception(
          "A API retornou HTML ao invés de JSON.\n"
          "Verifique se a API está retornando um json",
        );
      }

      final List<dynamic> dados = json.decode(body);
      return dados.map((json) => Medico.fromJson(json)).toList();
    }
    throw Exception("Erro ao listar os pacientes: ${respose.statusCode}");
  }

  static Future<void> inserirPaciente(Medico paciente) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode(paciente.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception(
        "Erro ao inserir paciente: ${response.statusCode}\n${response.body}",
      );
    }
  }

  static Future<void> atualizarPaciente(Medico paciente) async {
    final response = await http.put(
      Uri.parse("${url}?id=${paciente.id}"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(paciente.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception(
        "Erro ao atualizar paciente: ${response.statusCode}\n${response.body}",
      );
    }
  }

  static Future<void> excluirPaciente(Medico paciente) async {
    final response = await http.delete(Uri.parse("${url}?id=${paciente.id}"));

    if (response.statusCode != 200) {
      throw Exception(
        "Erro ao excluir paciente: ${response.statusCode}\n${response.body}",
      );
    }
  }
}
