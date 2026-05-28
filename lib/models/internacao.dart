import 'package:sis_hospital/models/model.dart';

import 'paciente.dart';
import 'medico.dart';
import 'leito.dart';

class Internacao extends Model {
  int? id;
  DateTime? dt_entrada;

  Paciente paciente;
  Medico medico;
  Leito leito;

  Internacao({
    this.id,
    required this.dt_entrada,
    required this.paciente,
    required this.medico,
    required this.leito,
  });

  @override
  Map<String, dynamic> toJson() {
    if (id != null) {
      return {
        "id": id,
        "dt_entrada": dt_entrada,
        "paciente": paciente.toJson(),
        "medico": medico.toJson(),
        "leito": leito.toJson(),
      };
    }

    return {
      "dt_entrada": dt_entrada,
      "paciente": paciente.toJson(),
      "medico": medico.toJson(),
      "leito": leito.toJson(),
    };
  }

  @override
  Internacao fromJson(Map<String, dynamic> json) {
    return Internacao(
      id: parseId(json["id"]),
      dt_entrada: parseDateTime(json["dt_entrada"]),
      paciente: paciente.fromJson(json["paciente"]),
      medico: medico.fromJson(json["medico"]),
      leito: leito.fromJson(json["leito"]),
    );
  }

  factory Internacao.fromJson(Map<String, dynamic> json) {
    return Internacao.fromJson(json);
  }
}
