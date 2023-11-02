import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lista_tarefas_v2/model/tarefa.dart';
import 'package:lista_tarefas_v2/repository/tarefas_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var tarefaRepository = TarefaRepository();
  var _Itens = <Tarefa>[];
  TextEditingController descricaoControle = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obterTarefa();
  }

  void obterTarefa() async {
    _Itens = await tarefaRepository.listar();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Lista de Compras",
            style: GoogleFonts.arvo(
                textStyle: const TextStyle(
                    color: Colors.amber, fontWeight: FontWeight.w600)),
          ),

          backgroundColor: const Color.fromARGB(255, 13, 150, 138), //cor do app
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              descricaoControle.text = " ";
              showDialog(
                  context: context,
                  builder: (BuildContext bc) {
                    return AlertDialog(
                        title: const Text("Adicionar Item"),
                        content: TextField(controller: descricaoControle),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancelar")),
                          TextButton(
                              onPressed: () async {
                                await tarefaRepository.adicionar(
                                    Tarefa(descricaoControle.text, false));
                                Navigator.pop(context);
                                setState(() {});
                              },
                              child: const Text("Salvar"))
                        ]);
                  });
            }),
        body: ListView.builder(
            itemCount: _Itens.length,
            itemBuilder: (BuildContext bc, int index) {
              var tarefa = _Itens[index];
              return Container(
                child: Text(tarefa.getDescricao()),
              );
            }),
      ),
    );
  }
}
