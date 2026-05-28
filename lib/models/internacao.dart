import 'paciente.dart';
import 'medico.dart';
import 'leito.dart';

class Internacao {
  int? id;
  DateTime dt_entrada;

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
}
