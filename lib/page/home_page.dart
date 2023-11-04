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
  var naoMarcados = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obterTarefa();
  }

  void obterTarefa() async {
    _Itens = await tarefaRepository.listar();
    if (naoMarcados) {
      _Itens = await tarefaRepository.listarNaoConcluida();
    } else {
      _Itens = await tarefaRepository.listar();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 8,
          shadowColor: Colors.amber,
          title: Text(
            "Lista de Compras",
            style: GoogleFonts.arvo(
                textStyle: const TextStyle(
                    color: Colors.amber, fontWeight: FontWeight.w600)),
          ),

          backgroundColor: const Color.fromARGB(255, 13, 150, 138), //cor do app
        ),
        floatingActionButton: FloatingActionButton(
            elevation: 8,
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
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                                setState(() {});
                              },
                              child: const Text("Salvar"))
                        ]);
                  });
            }),
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Apenas os que Faltam",
                    style: TextStyle(fontSize: 15),
                  ),
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                        activeColor: Colors.amber,
                        value: naoMarcados,
                        onChanged: (bool value) {
                          naoMarcados = value;
                          obterTarefa();
                        }),
                  )
                ],
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: _Itens.length,
                    itemBuilder: (BuildContext bc, int index) {
                      var tarefa = _Itens[index];
                      return Dismissible(
                        onDismissed: (DismissDirection dismissDirection) {
                          tarefaRepository.remover(tarefa.id);
                          obterTarefa();
                        },
                        key: Key(tarefa.id),
                        child: ListTile(
                          title: Text(tarefa.descricao,
                              style: const TextStyle(fontSize: 22)),
                          trailing: Switch(
                              activeThumbImage: const NetworkImage(
                                  'https://cdn-icons-png.flaticon.com/512/3144/3144456.png'),
                              value: tarefa.concluido,
                              onChanged: (bool value) async {
                                await tarefaRepository.alterar(
                                    tarefa.id, value);
                                obterTarefa();
                              }),
                        ),
                      );
                      // return Container(
                      //   child: Text(tarefa.getDescricao()),
                      // );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
