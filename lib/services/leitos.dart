import 'dart:convert';

import 'package:sis_hospital/services/api.dart';
import 'package:sis_hospital/models/leito.dart';

import 'package:http/http.dart' as http;

class LeitosService {
  static final String url = "${ApiService.baseUrl}/leitos";

  static Future<List<Leito>> listarMedicos() async {
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
      return dados.map((json) => Leito.fromJson(json)).toList();
    }
    throw Exception("Erro ao listar os pacientes: ${respose.statusCode}");
  }

  static Future<void> inseriMedico(Leito leito) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode(leito.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception(
        "Erro ao inserir leito: ${response.statusCode}\n${response.body}",
      );
    }
  }

  static Future<void> atualizaMedico(Leito leito) async {
    final response = await http.put(
      Uri.parse("${url}?id=${leito.id}"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(leito.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception(
        "Erro ao atualizar leito: ${response.statusCode}\n${response.body}",
      );
    }
  }

  static Future<void> excluiMedico(Leito leito) async {
    final response = await http.delete(Uri.parse("${url}?id=${leito.id}"));

    if (response.statusCode != 200) {
      throw Exception(
        "Erro ao excluir leito: ${response.statusCode}\n${response.body}",
      );
    }
  }
}
