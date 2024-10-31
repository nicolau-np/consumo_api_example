import 'package:consumo_api_example/models/estudante.dart';
import 'package:consumo_api_example/models/pessoa.dart';
import 'package:consumo_api_example/provider/estudante_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Edit extends StatefulWidget {
  final Estudante estudante;

  const Edit(this.estudante, {super.key});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  int id = 0;
  TextEditingController nome = TextEditingController();
  String? turmaSelecionada;
  String? generoSelecionado;
  final List<String> turmas = ['Turma A', 'Turma B', 'Turma C', 'Turma D'];
  final List<String> generos = ['Masculino', 'Femenino'];

  @override
  void initState() {
    id = widget.estudante.id;
    nome.text = widget.estudante.pessoa.nome;
    turmaSelecionada = widget.estudante.turma;
    generoSelecionado = widget.estudante.pessoa.genero;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final estudanteProvider = Provider.of<EstudanteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar'),
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
              update(estudanteProvider, id);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  void update(EstudanteProvider estudanteProvider, int id) async {
    final newEstudante = Estudante(
      id: id,
      turma: turmaSelecionada.toString(),
      pessoa:
          Pessoa(id: 0, nome: nome.text, genero: generoSelecionado.toString()),
    );

    if (nome.text.isEmpty ||
        generoSelecionado == null ||
        turmaSelecionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Deve preencher os campos obrigatórios.'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      await estudanteProvider.updateEstudante(newEstudante);
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
