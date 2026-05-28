class Leitos {
  int? id;
  String numero;
  String ala;
  String tipo;
  StatusLeito status;

  Leitos({
    this.id,
    required this.numero,
    required this.ala,
    required this.tipo,
    required this.status,
  });
}

enum StatusLeito { ocupado, disponivel }
