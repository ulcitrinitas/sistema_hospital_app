import 'package:sis_hospital/models/internacao.dart';
import 'package:sis_hospital/models/medico.dart';
import 'package:sis_hospital/models/model.dart';

class Prontuario extends Model {
  int? id;
  DateTime? dt_registro;
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

  @override
  Map<String, dynamic> toJson() {
    if (id != null) {
      return {
        "id": id,
        "dt_registro": dt_registro,
        "descricao": descricao,
        "tipo": tipo,
        "medico": medico.toJson(),
        "internacao": internacao.toJson(),
      };
    }

    return {
      "dt_registro": dt_registro,
      "descricao": descricao,
      "tipo": tipo,
      "medico": medico.toJson(),
      "internacao": internacao.toJson(),
    };
  }

  @override
  Prontuario fromJson(Map<String, dynamic> json) {
    return Prontuario(
      id: parseId(json["id"]),
      dt_registro: parseDateTime(json["dt_registro"]),
      descricao: json["descricao"] ?? "",
      tipo: json["tipo"] ?? "",
      medico: medico.fromJson(json["medico"]),
      internacao: internacao.fromJson(json["internacao"]),
    );
  }
}
