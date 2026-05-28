import 'package:sis_hospital/models/model.dart';

class Paciente extends Model {
  int? id;
  String nome;
  String cpf;
  DateTime? nasc;
  String alergias;

  Paciente({
    this.id,
    required this.nome,
    required this.cpf,
    required this.nasc,
    required this.alergias,
  });

  @override
  Map<String, dynamic> toJson() {
    if (id != null) {
      return {
        "id": id,
        "nome": nome,
        "cpf": cpf,
        "dt_nascimento": nasc,
        "alergias": alergias,
      };
    }

    return {
      "nome": nome,
      "cpf": cpf,
      "dt_nascimento": nasc,
      "alergias": alergias,
    };
  }

  @override
  Paciente fromJson(Map<String, dynamic> json) {
    return Paciente(
      id: parseId(json["id"]),
      nome: json["nome"] ?? "",
      cpf: json["cpf"] ?? "",
      nasc: parseDateTime(json["nasc"]),
      alergias: json["alergias"] ?? "",
    );
  }

  factory Paciente.fromJson(Map<String, dynamic> json) {
    return Paciente.fromJson(json);
  }
}
