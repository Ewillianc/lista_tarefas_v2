import '../model/tarefa.dart';

class TarefaRepository {
  final List<Tarefa> _tarefas = [];

  Future<void> adicionar(Tarefa tarefa) async {
    //await Future.delayed(const Duration(milliseconds: 100));
    _tarefas.add(tarefa);
  }

  Future<void> alterar(String id, bool concluido) async {
    // await Future.delayed(const Duration(microseconds: 100));
    _tarefas.where((tarefa) => tarefa.id == id).first.concluido = concluido;
//_tarefas   ..da lista tarefas
    // .where((tarefa)     .. onde a tarefa
    // => tarefa.getId() == id)  ..possui o getId igual ao id que foi selecionado
    // .first           .. pega a primeira opção
    // .setConcluido(concluido);  .. e recebe o valor em concluido.
  }

  Future<void> remover(String id) async {
    _tarefas.remove(_tarefas.where((tarefa) => tarefa.id == id).first);
  }

  Future<List<Tarefa>> listar() async {
    //await Future.delayed(const Duration(microseconds: 100));
    return _tarefas;
  }

  Future<List<Tarefa>> listarNaoConcluida() async {
    //await Future.delayed(const Duration(microseconds: 100));
    return _tarefas.where((tarefa) => !tarefa.concluido).toList();
  }

  
}
