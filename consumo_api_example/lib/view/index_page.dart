import 'dart:convert';

import 'package:consumo_api_example/view/edit_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List estudanteData = [];
  String baseUrl = "http://api_example.local/api";
  //String baseUrl = "http://192.168.88.23:8000/api";

  @override
  void initState() {
    index();
    super.initState();
  }

  Future<void> delete(int id) async {
    String uri = "$baseUrl/estudantes/$id";
    try {
      var request = await http.delete(Uri.parse(uri));
      if (request.statusCode == 200 || request.statusCode == 201) {
        index();
        print('Feito com sucesso');
      } else {
        print('Ocorreu um erro');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> index() async {
    String uri = "$baseUrl/estudantes";
    try {
      var request = await http.get(Uri.parse(uri));
      setState(() {
        estudanteData = jsonDecode(request.body);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Index'),
      ),
      body: ListView.builder(
        itemCount: estudanteData.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditPage(
                        estudanteData[index]), // Passando o objeto correto
                  ),
                );
              },
              leading: const Icon(
                CupertinoIcons.heart,
                color: Colors.red,
              ),
              title: Text(estudanteData[index]['pessoa']['nome']),
              subtitle: Text(estudanteData[index]['turma']),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  delete(estudanteData[index]['id']);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
