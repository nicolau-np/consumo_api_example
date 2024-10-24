import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController nome = TextEditingController();
  TextEditingController genero = TextEditingController();
  TextEditingController turma = TextEditingController();
  String baseUrl = "http://api_example.local/api";
    //String baseUrl = "http://192.168.88.23:8000/api";

  Future<void> store() async {
    if (nome.text == "" || genero.text == "" || turma.text == "") {
      print('Deve preencher os campos');
    } else {
      try {
        String uri = "$baseUrl/estudantes";
        var request = await http.post(Uri.parse(uri), body: {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create'),
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
                store();
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
