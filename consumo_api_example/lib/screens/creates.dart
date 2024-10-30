import 'package:consumo_api_example/models/estudante.dart';
import 'package:consumo_api_example/models/pessoa.dart';
import 'package:consumo_api_example/provider/estudante_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Creates extends StatefulWidget {
  const Creates({super.key});

  @override
  State<Creates> createState() => _CreatesState();
}

class _CreatesState extends State<Creates> {
  TextEditingController nome = TextEditingController();
  TextEditingController genero = TextEditingController();
  TextEditingController turma = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final estudanteProvider = Provider.of<EstudanteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Create'),
      ),
      body: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Nome'),
            ),
            controller: nome,
          ),
          const SizedBox(
            height: 16.0,
          ),
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Genero'),
            ),
            controller: genero,
          ),
          const SizedBox(
            height: 16.0,
          ),
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Turma'),
            ),
            controller: turma,
          ),
          const SizedBox(
            height: 16.0,
          ),
          ElevatedButton(
            onPressed: () {
              store(estudanteProvider);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  void store(EstudanteProvider estudanteProvider) {
    final newEstudante = Estudante(
      id: 0,
      turma: turma.text,
      pessoa: Pessoa(id: 0, nome: nome.text, genero: genero.text),
    );

    estudanteProvider.addEstudante(newEstudante);
    Navigator.pop(context);
  }
}
