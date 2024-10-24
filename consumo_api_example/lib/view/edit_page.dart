import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditPage extends StatefulWidget {
  final Map<String, dynamic> estudanteData;

  const EditPage(this.estudanteData, {super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  int id = 0;
  TextEditingController nome = TextEditingController();
  TextEditingController genero = TextEditingController();
  TextEditingController turma = TextEditingController();
  String baseUrl = "http://api_example.local/api";
   //String baseUrl = "http://192.168.88.23:8000/api";

  Future<void> update() async {
    if (nome.text == "" || genero.text == "" || turma.text == "") {
      print('Deve preencher os campos');
    } else {
      try {
        String uri = "$baseUrl/estudantes/$id";
        var request = await http.put(Uri.parse(uri), body: {
          "nome": nome.text,
          "genero": genero.text,
          "turma": turma.text
        });
        if (request.statusCode == 200 || request.statusCode == 201) {
          print('Salvou com sucesso');
        } else {
          print('Ocorreu um problema ao salvar');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    id = widget.estudanteData['id'];
    nome.text = widget.estudanteData['pessoa']['nome'];
    genero.text = widget.estudanteData['pessoa']['genero'];
    turma.text = widget.estudanteData['turma'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
                update();
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
