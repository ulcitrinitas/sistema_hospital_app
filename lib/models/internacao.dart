import 'package:sis_hospital/models/model.dart';

import 'paciente.dart';
import 'medico.dart';
import 'leito.dart';

class Internacao extends Model {
  int? id;
  DateTime? dtEntrada;

  Paciente paciente;
  Medico medico;
  Leito leito;

  Internacao({
    this.id,
    required this.dtEntrada,
    required this.paciente,
    required this.medico,
    required this.leito,
  });

  @override
  Map<String, dynamic> toJson() {
    if (id != null) {
      return {
        "id": id,
        "dtEntrada": dtEntrada,
        "paciente": paciente.toJson(),
        "medico": medico.toJson(),
        "leito": leito.toJson(),
      };
    }

    return {
      "dtEntrada": dtEntrada,
      "paciente": paciente.toJson(),
      "medico": medico.toJson(),
      "leito": leito.toJson(),
    };
  }

  @override
  Internacao fromJson(Map<String, dynamic> json) {
    return Internacao(
      id: parseId(json["id"]),
      dtEntrada: parseDateTime(json["dtEntrada"]),
      paciente: paciente.fromJson(json["paciente"]),
      medico: medico.fromJson(json["medico"]),
      leito: leito.fromJson(json["leito"]),
    );
  }

  factory Internacao.fromJson(Map<String, dynamic> json) {
    return Internacao.fromJson(json);
  }
}
