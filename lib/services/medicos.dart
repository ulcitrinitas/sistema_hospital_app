import 'dart:convert';

import 'package:sis_hospital/services/api.dart';
import 'package:sis_hospital/models/medico.dart';

import 'package:http/http.dart' as http;

class MedicosService {
  static final String url = "${ApiService.baseUrl}/medicos";

  static Future<List<Medico>> listarMedicos() async {
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

  static Future<void> inserirMedico(Medico medico) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode(medico.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception(
        "Erro ao inserir medico: ${response.statusCode}\n${response.body}",
      );
    }
  }

  static Future<void> atualizarMedico(Medico medico) async {
    final response = await http.put(
      Uri.parse("${url}?id=${medico.id}"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(medico.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception(
        "Erro ao atualizar medico: ${response.statusCode}\n${response.body}",
      );
    }
  }

  static Future<void> excluirMedico(Medico medico) async {
    final response = await http.delete(Uri.parse("${url}?id=${medico.id}"));

    if (response.statusCode != 200) {
      throw Exception(
        "Erro ao excluir medico: ${response.statusCode}\n${response.body}",
      );
    }
  }
}
