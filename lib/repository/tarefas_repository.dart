import '../model/tarefa.dart';

class TarefaRepository {
  final List<Tarefa> _tarefas = [];

  Future<void> adicionar(Tarefa tarefa) async {
    await Future.delayed(const Duration(seconds: 1));
    _tarefas.add(tarefa);
  }

  void alterar(String id, bool concluido) async {
    await Future.delayed(const Duration(seconds: 1));
    _tarefas
        .where((tarefa) => tarefa.getId() == id)
        .first
        .setConcluido(concluido);
//_tarefas   ..da lista tarefas
    // .where((tarefa)     .. onde a tarefa
    // => tarefa.getId() == id)  ..possui o getId igual ao id que foi selecionado
    // .first           .. pega a primeira opção
    // .setConcluido(concluido);  .. e recebe o valor em concluido.
  }

  Future<List<Tarefa>> listar() async {
    await Future.delayed(const Duration(seconds: 1));
    return _tarefas;
  }
}
