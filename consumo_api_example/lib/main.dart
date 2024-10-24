import 'package:consumo_api_example/auth/login.dart';
import 'package:consumo_api_example/view/create_page.dart';
import 'package:consumo_api_example/view/home_page.dart';
import 'package:consumo_api_example/view/index_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consumo API',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/': (context) => const HomePage(),
        '/create': (context) => const CreatePage(),
        '/index': (context) => const IndexPage(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}
