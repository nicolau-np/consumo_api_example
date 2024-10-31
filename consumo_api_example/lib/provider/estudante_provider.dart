import 'package:consumo_api_example/models/estudante.dart';
import 'package:consumo_api_example/services/estudante_service.dart';
import 'package:flutter/material.dart';

class EstudanteProvider with ChangeNotifier {
  List<Estudante> _estudantes = [];
  final EstudanteService estudanteService;

  EstudanteProvider(this.estudanteService);

  List<Estudante> get estudantes => _estudantes;

  Future<void> loadEstudantes() async {
    _estudantes = await estudanteService.index();
    notifyListeners();
  }

  Future<void> addEstudante(Estudante estudante) async {
    await estudanteService.store(estudante);
    await loadEstudantes();
  }

  Future<void> updateEstudante(Estudante estudante) async {
    await estudanteService.update(estudante);
    await loadEstudantes();
  }

  Future<void> removeEstudante(int id) async {
    await estudanteService.delete(id);
    await loadEstudantes();
  }
}
