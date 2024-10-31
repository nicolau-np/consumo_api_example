import 'package:consumo_api_example/provider/estudante_provider.dart';
import 'package:consumo_api_example/screens/creates.dart';
import 'package:consumo_api_example/screens/index.dart';
import 'package:consumo_api_example/services/estudante_service.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
   @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => EstudanteProvider(EstudanteService()),
          // Adicione mais providers aqui
        ),
        // Exemplo de outro provider
        // ChangeNotifierProvider(create: (context) => OutroProvider()),
      ],
      child: MaterialApp(
        title: 'Consumo API',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const Index(),
          '/create': (context) => const Creates(),
          // Adicione mais rotas conforme necessário
        },
      ),
    );
  }
}
