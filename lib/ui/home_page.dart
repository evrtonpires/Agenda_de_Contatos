import 'package:agendacontatos/helpers/contatos_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContatoHelper helper = ContatoHelper();

  @override
  void initState() {
    super.initState();
/*
  Contato c = Contato();
  c.idade = 23;
  c.nome = "Lael";
  c.email = "lael.santos@sgs.com.br";
  c.telefone = "62983092013";
  c.img = "imgTest";

  helper.salvarContato(c);*/

    helper.getAllContatos().then((list) {
      print(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
