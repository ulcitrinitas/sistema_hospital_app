class Paciente {
  int? id;
  String nome;
  String cpf;
  String dt_nascimento;
  String alergias;

  Paciente({
    required this.nome,
    this.id,
    required this.cpf,
    required this.dt_nascimento,
    required this.alergias,
  });

  DateTime converter_nasc() {
    var nasc = DateTime.tryParse(dt_nascimento);

    if (nasc == null) {
      print("Erro! Problema ao formatar a data");
      return DateTime.now();
    } else {
      return nasc;
    }
  }
}
