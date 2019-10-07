import 'dart:io';

import 'package:agendacontatos/helpers/contatos_helper.dart';
import 'package:agendacontatos/ui/contato_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContatoHelper helper = ContatoHelper();

  List<Contato> listContatos = List();

  @override
  void initState() {
    super.initState();
    _getAllContatos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contatos",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _exibirPaginaContato();
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: listContatos.length,
          itemBuilder: (context, index) {
            return _contatoCard(context, index);
          }),
    );
  }

  Widget _contatoCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: listContatos[index].img != null
                            ? FileImage(File(listContatos[index].img))
                            : AssetImage("images/iconpadrao.png")),
                    border: Border.all(color: Colors.red)),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 10.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      listContatos[index].nome ?? "",
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Idade: " + listContatos[index].idade.toString() ?? "",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      "Email:",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      listContatos[index].email ?? "",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      "Telefone:",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      listContatos[index].telefone ?? "",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        _exibirPaginaContato(contato: listContatos[index]);
      },
    );
  }

  _exibirPaginaContato({Contato contato}) async {
    final recebendoContato = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ContatoPage(contato: contato)));
    if (recebendoContato != null) {
      if (contato != null) {
        await helper.updateContato(contato);
      } else {
        await helper.salvarContato(recebendoContato);
      }
      _getAllContatos();
    }
  }

  void _getAllContatos() {
    helper.getAllContatos().then((list) {
      setState(() {
        listContatos = list;
      });
    });
  }
}
