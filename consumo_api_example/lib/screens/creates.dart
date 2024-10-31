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
  String? turmaSelecionada;
  String? generoSelecionado;
  final List<String> turmas = ['Turma A', 'Turma B', 'Turma C', 'Turma D'];
  final List<String> generos = ['Masculino', 'Femenino'];

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
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Gênero',
            ),
            value: generoSelecionado,
            items: generos.map((genero) {
              return DropdownMenuItem<String>(
                value: genero,
                child: Text(genero),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                generoSelecionado = value;
              });
            },
            validator: (value) {
              if (value == null) {
                return 'Selecione um Gênero';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16.0,
          ),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Turma',
            ),
            value: turmaSelecionada,
            items: turmas.map((turma) {
              return DropdownMenuItem<String>(
                value: turma,
                child: Text(turma),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                turmaSelecionada = value;
              });
            },
             validator: (value) {
              if (value == null) {
                return 'Selecione uma turma';
              }
              return null;
            },
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

  void store(EstudanteProvider estudanteProvider) async {
    final newEstudante = Estudante(
      id: 0,
      turma: turmaSelecionada.toString(),
      pessoa:
          Pessoa(id: 0, nome: nome.text, genero: generoSelecionado.toString()),
    );
    if (nome.text.isEmpty || generoSelecionado == null || turmaSelecionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Deve preencher todos os campos obrigatórios'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      await estudanteProvider.addEstudante(newEstudante);
      clearFields();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Feito com sucesso'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void clearFields() {
    nome.clear();
    generoSelecionado = null;
    turmaSelecionada = null;
  }
}
