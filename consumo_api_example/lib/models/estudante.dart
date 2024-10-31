import 'package:consumo_api_example/models/pessoa.dart';

class Estudante {
  final int id;
  final String turma;
  final Pessoa pessoa;

  Estudante({required this.id, required this.turma, required this.pessoa});

  factory Estudante.fromJson(Map<String, dynamic> json) {
    return Estudante(
      id: json['id'],
      turma: json['turma'],
      pessoa: Pessoa.fromJson(json['pessoa']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'turma': turma,
      'pessoa': pessoa.toJson(),
    };
  }

  Map<String, dynamic> toJsonEstudante() {
    return {
      'nome': pessoa.nome,
      'genero': pessoa.genero,
      'turma': turma,
    };
  }

  @override
  String toString() {
    return 'Estudante{id: $id, turma: $turma, pessoa: $pessoa}';
  }
}
