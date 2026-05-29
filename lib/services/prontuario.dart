import 'dart:convert';

import 'package:sis_hospital/services/api.dart';
import 'package:sis_hospital/models/prontuario.dart';

import 'package:http/http.dart' as http;

class ProntuarioService {
  static final String url = "${ApiService.baseUrl}/prontuarios";

  static Future<List<Prontuario>> listarMedicos() async {
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
      return dados.map((json) => Prontuario.fromJson(json)).toList();
    }
    throw Exception("Erro ao listar os pacientes: ${respose.statusCode}");
  }

  static Future<void> inseriMedico(Prontuario prontuario) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode(prontuario.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception(
        "Erro ao inserir prontuario: ${response.statusCode}\n${response.body}",
      );
    }
  }

  static Future<void> atualizaMedico(Prontuario prontuario) async {
    final response = await http.put(
      Uri.parse("${url}?id=${prontuario.id}"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(prontuario.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception(
        "Erro ao atualizar prontuario: ${response.statusCode}\n${response.body}",
      );
    }
  }

  static Future<void> excluiMedico(Prontuario prontuario) async {
    final response = await http.delete(Uri.parse("${url}?id=${prontuario.id}"));

    if (response.statusCode != 200) {
      throw Exception(
        "Erro ao excluir prontuario: ${response.statusCode}\n${response.body}",
      );
    }
  }
}
