import 'package:flutter/material.dart';

class Tarefa {
  String _id = UniqueKey().toString();
  String _descricao = "";
  bool _concluido = false;

  Tarefa(this._descricao, this._concluido);

  String get id => _id;

  // String getId() {
  //   return _id;
  // }

  String get descricao => _descricao;
  // String getDescricao() {
  //   return _descricao;
  // }

  void set descricao(String descricao) {
    _descricao = descricao;
  }

  // void setDescricao(String descricao) {
  //   _descricao = descricao;
  // }

  bool get concluido => _concluido;

  // bool getConcluido() {
  //   return _concluido;
  // }

  set concluido(bool concluido) {
    _concluido = concluido;
  }

  // void setConcluido(bool concluido) {
  //   _concluido = concluido;
  // }
}
