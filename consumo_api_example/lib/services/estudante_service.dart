import 'dart:convert';
import 'package:consumo_api_example/models/estudante.dart';
import 'package:http/http.dart' as http;

class EstudanteService {
  final String baseUrl =
      'http://api_example.local/api'; // Substitua pela URL da sua API

  Future<List<Estudante>> index() async {
    final response = await http.get(Uri.parse('$baseUrl/estudantes'));

    if (response.statusCode == 200) {
      print(response.body);
      List<dynamic> json = jsonDecode(response.body);
      return json.map((estudante) => Estudante.fromJson(estudante)).toList();
    } else {
      throw Exception('Failed to load estudantes');
    }
  }

  Future<void> store(Estudante estudante) async {
    await http.post(
      Uri.parse('$baseUrl/estudantes'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(estudante.toJson()),
    );
  }

  Future<void> update(Estudante estudante) async {
    await http.put(
      Uri.parse('$baseUrl/estudantes/${estudante.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(estudante.toJson()),
    );
  }

  Future<void> delete(int id) async {
    await http.delete(Uri.parse('$baseUrl/estudantes/$id'));
  }
}
