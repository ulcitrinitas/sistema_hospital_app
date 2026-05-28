import 'package:sis_hospital/models/internacao.dart';
import 'package:sis_hospital/models/medico.dart';

class Prontuario {
  int? id;
  DateTime dt_registro;
  String descricao;
  String tipo;

  Internacao internacao;
  Medico medico;

  Prontuario({
    this.id,
    required this.dt_registro,
    required this.descricao,
    required this.tipo,
    required this.medico,
    required this.internacao,
  });
}
