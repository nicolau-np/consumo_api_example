import 'dart:convert';

import 'package:consumo_api_example/services/token_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String baseUrl = "http://api_example.local/api";
  final TokenService tokenService = TokenService();

  Future<void> login() async {
    try {
      String uri = "$baseUrl/auth/login";
      var request = await http.post(Uri.parse(uri),
          body: {"email": email.text, "password": password.text});
      if (request.statusCode == 200 || request.statusCode == 201) {
        var authData = jsonDecode(request.body);
        await tokenService.saveToken(authData['token_name']['token']);
        Navigator.pushNamed(context, '/');
      } else {
        print('Erro nas credenciais');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('E-mail'),
              ),
              controller: email,
            ),
            const SizedBox(
              height: 16.0,
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Palavra-Passe'),
              ),
              controller: password,
            ),
            const SizedBox(
              height: 16.0,
            ),
            ElevatedButton(
              onPressed: () {
                login();
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
