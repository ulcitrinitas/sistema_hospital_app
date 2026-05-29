import 'dart:convert';

import 'package:sis_hospital/models/internacao.dart';
import 'package:sis_hospital/services/api.dart';

import 'package:http/http.dart' as http;

class InternacoesService {
  static final String url = "${ApiService.baseUrl}/internacoes";

  static Future<List<Internacao>> listarMInternacoes() async {
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
      return dados.map((json) => Internacao.fromJson(json)).toList();
    }
    throw Exception("Erro ao listar os pacientes: ${respose.statusCode}");
  }

  static Future<void> inseriInternacoes(Internacao internacao) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode(internacao.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception(
        "Erro ao inserir internacao: ${response.statusCode}\n${response.body}",
      );
    }
  }

  static Future<void> atualizaInternacoes(Internacao internacao) async {
    final response = await http.put(
      Uri.parse("${url}?id=${internacao.id}"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(internacao.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception(
        "Erro ao atualizar internação: ${response.statusCode}\n${response.body}",
      );
    }
  }

  static Future<void> excluiInternacoes(Internacao internacao) async {
    final response = await http.delete(Uri.parse("${url}?id=${internacao.id}"));

    if (response.statusCode != 200) {
      throw Exception(
        "Erro ao excluir internação: ${response.statusCode}\n${response.body}",
      );
    }
  }
}
