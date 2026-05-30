import 'package:intl/intl.dart';
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
    final dtNascimento = nasc != null ? DateFormat('yyyy-MM-dd').format(nasc!) : null;

    if (id != null) {
      return {
        "id": id,
        "nome": nome,
        "cpf": cpf,
        "dt_nascimento": dtNascimento,
        "alergias": alergias,
      };
    }

    return {
      "nome": nome,
      "cpf": cpf,
      "dt_nascimento": dtNascimento,
      "alergias": alergias,
    };
  }

  @override
  Paciente fromJson(Map<String, dynamic> json) {
    return Paciente(
      id: parseId(json["id"]),
      nome: json["nome"] ?? "",
      cpf: json["cpf"] ?? "",
      nasc: parseDateTime((json["dt_nascimento"] ?? json["nasc"] ?? "").toString()),
      alergias: json["alergias"] ?? "",
    );
  }

  factory Paciente.fromJson(Map<String, dynamic> json) {
    final id = int.tryParse((json["id"] ?? "").toString());
    final nome = (json["nome"] ?? "").toString();
    final cpf = (json["cpf"] ?? "").toString();
    final nascRaw = (json["dt_nascimento"] ?? json["nasc"] ?? "").toString();
    DateTime? nasc;
    try {
      nasc = DateFormat('yyyy-MM-dd').parseStrict(nascRaw);
    } catch (_) {
      nasc = DateTime.tryParse(nascRaw);
    }
    final alergias = (json["alergias"] ?? "").toString();

    return Paciente(
      id: id,
      nome: nome,
      cpf: cpf,
      nasc: nasc,
      alergias: alergias,
    );
  }
}
