import 'dart:convert';

import 'package:sis_hospital/controllers/api.dart';
import 'package:sis_hospital/models/paciente.dart';

import 'package:http/http.dart' as http;

class PacienteController {
  static final String url = "${ApiController.baseUrl}/pacientes";

  static Future<List<Paciente>> listarPacientes() async {
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
      return dados.map((json) => Paciente.fromJson(json)).toList();
    }
    throw Exception("Erro ao listar os pacientes: ${respose.statusCode}");
  }
}
