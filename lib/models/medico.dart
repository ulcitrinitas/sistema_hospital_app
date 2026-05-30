import 'package:sis_hospital/models/model.dart';

class Medico extends Model {
  int? id;
  String nome;
  String crm;
  String especialidade;

  Medico({
    this.id,
    required this.nome,
    required this.crm,
    required this.especialidade,
  });

  @override
  Map<String, dynamic> toJson() {
    if (id != null) {
      return {
        "id": id,
        "nome": nome,
        "crm": crm,
        "especialidade": especialidade,
      };
    }

    return {"nome": nome, "crm": crm, "especialidade": especialidade};
  }

  @override
  Medico fromJson(Map<String, dynamic> json) {
    return Medico(
      id: parseId(json["id"]),
      nome: json["nome"] ?? "",
      crm: json["crm"] ?? "",
      especialidade: json["especialidade"] ?? "",
    );
  }

  factory Medico.fromJson(Map<String, dynamic> json) {
    return Medico(
      id: int.tryParse((json["id"] ?? "").toString()),
      nome: json["nome"] ?? "",
      crm: json["crm"] ?? "",
      especialidade: json["especialidade"] ?? "",
    );
  }
}
