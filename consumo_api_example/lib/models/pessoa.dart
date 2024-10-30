class Pessoa {
  final int id; 
  final String nome;
  final String genero;

  Pessoa({required this.id, required this.nome, required this.genero});

  factory Pessoa.fromJson(Map<String, dynamic> json) {
    return Pessoa(
      id: json['id'],
      nome: json['nome'],
      genero: json['genero'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'genero': genero,
    };
  }
}
