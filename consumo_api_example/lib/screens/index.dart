import 'package:consumo_api_example/provider/estudante_provider.dart';
import 'package:consumo_api_example/screens/edit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  @override
  void initState() {
    super.initState();
    // Carregar estudantes uma vez ao iniciar a tela
    Provider.of<EstudanteProvider>(context, listen: false).loadEstudantes();
  }

  @override
  Widget build(BuildContext context) {
    final estudanteProvider = Provider.of<EstudanteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Estudantes'),
      ),
      body: estudanteProvider.estudantes.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: estudanteProvider.estudantes.length,
              itemBuilder: (context, index) {
                final estudante = estudanteProvider.estudantes[index];
                return ListTile(
                  title: Text('Estudante: ${estudante.pessoa.nome}'),
                  subtitle: Text('Turma: ${estudante.turma}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Edit(estudante),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          estudanteProvider.removeEstudante(estudante.id);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/create');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
