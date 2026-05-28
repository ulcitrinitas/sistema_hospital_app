class Leito {
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
}

enum StatusLeito { ocupado, disponivel }
