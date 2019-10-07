import 'dart:io';

import 'package:agendacontatos/helpers/contatos_helper.dart';
import 'package:flutter/material.dart';

class ContatoPage extends StatefulWidget {
  final Contato contato;

  ContatoPage({this.contato});

  @override
  _ContatoPageState createState() => _ContatoPageState();
}

class _ContatoPageState extends State<ContatoPage> {
  final _nomeController = TextEditingController();
  final _idadeController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();

  bool _editandoUsuarioTrueOrFalse = false;

  Contato _editarContato;

  @override
  void initState() {
    super.initState();
    if (widget.contato == null) {
      _editarContato = Contato();
    } else {
      _editarContato = Contato.fromMap(widget.contato.toMap());

      _nomeController.text = _editarContato.nome;
      _idadeController.text = _editarContato.idade.toString();
      _emailController.text = _editarContato.email;
      _telefoneController.text = _editarContato.telefone;
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            GestureDetector(
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: _editarContato.img != null
                            ? FileImage(File(_editarContato.img))
                            : AssetImage("images/iconpadrao.png")),
                    border: Border.all(color: Colors.red)),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 10), child: Text("Nome")),
            textField(function: testeEditing, controller: _nomeController),
            Padding(padding: EdgeInsets.only(left: 10), child: Text("Idade")),
            textField(keyboardtype: true, controller: _idadeController),
            Padding(padding: EdgeInsets.only(left: 10), child: Text("Email")),
            textField(controller: _emailController),
            Padding(
                padding: EdgeInsets.only(left: 10), child: Text("Telefone")),
            textField(keyboardtype: true, controller: _telefoneController),
          ],
        ),
      ),
    );
  }

  Widget textField({Function function,
    bool keyboardtype,
    TextEditingController controller}) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextField(
          controller: controller,
          keyboardType: keyboardtype == true
              ? TextInputType.number
              : TextInputType.emailAddress,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent))),
          onChanged: function),
    );
  }

  void testeEditing(String t) {
    _editandoUsuarioTrueOrFalse = true;
    setState(() {
      _editarContato.nome = t;
    });
  }
}
