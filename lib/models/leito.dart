import 'package:sis_hospital/models/model.dart';

class Leito extends Model {
  int? id;
  String numero;
  String ala;
  String tipo;
  StatusLeito status;

  Leito({
    this.id,
    required this.numero,
    required this.ala,
    required this.tipo,
    required this.status,
  });

  @override
  Map<String, dynamic> toJson() {
    if (id != null) {
      return {
        "id": id,
        "numero": numero,
        "ala": ala,
        "tipo": tipo,
        "status": status,
      };
    }
    return {"numero": numero, "ala": ala, "tipo": tipo, "status": status};
  }

  @override
  Leito fromJson(Map<String, dynamic> json) {
    return Leito(
      id: parseId(json["id"]),
      numero: json["numero"] ?? "",
      ala: json["ala"] ?? "",
      tipo: json["tipo"] ?? "",
      status: json["status"] ?? "",
    );
  }

  factory Leito.fromJson(Map<String, dynamic> json) {
    return Leito.fromJson(json);
  }
}

enum StatusLeito { ocupado, disponivel }
