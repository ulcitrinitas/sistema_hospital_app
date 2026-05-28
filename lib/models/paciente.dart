class Paciente {
  int? id;
  String nome;
  String cpf;
  DateTime nasc;
  String alergias;

  Paciente({
    this.id,
    required this.nome,
    required this.cpf,
    required this.nasc,
    required this.alergias,
  });
}
