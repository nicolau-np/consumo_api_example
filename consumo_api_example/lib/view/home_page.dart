import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CONSUMO API EXAMPLE'),
      ),
      body: const Column(
        children: [
          Center(
            child: Text('hello'),
          )
        ],
      ),
    );
  }
}
