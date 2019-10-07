import 'package:agendacontatos/helpers/contatos_helper.dart';
import 'package:flutter/material.dart';

class ContatoPage extends StatefulWidget {
  final Contato contato;

  ContatoPage({this.contato});

  @override
  _ContatoPageState createState() => _ContatoPageState();
}

class _ContatoPageState extends State<ContatoPage> {
  Contato _editarContato;

  @override
  void initState() {
    super.initState();
    if (widget.contato == null) {
      _editarContato = Contato();
    } else {
      _editarContato = Contato.fromMap(widget.contato.toMap());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(_editarContato.nome ?? "Novo Contato"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save, color: Colors.white),
          backgroundColor: Colors.red,
          onPressed: () {}),
    );
  }
}
