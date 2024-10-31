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
  TextEditingController genero = TextEditingController();
  TextEditingController turma = TextEditingController();

  @override
  void initState() {
    id = widget.estudante.id;
    nome.text = widget.estudante.pessoa.nome;
    genero.text = widget.estudante.pessoa.genero;
    turma.text = widget.estudante.turma;
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
      turma: turma.text,
      pessoa: Pessoa(id: 0, nome: nome.text, genero: genero.text),
    );

    await estudanteProvider.updateEstudante(newEstudante);
  }
}
