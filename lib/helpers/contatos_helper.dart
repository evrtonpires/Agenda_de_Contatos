import 'package:sqflite/sqflite.dart';

final String idColuna = "idColuna";
final String idadeColuna = "idadeColuna";
final String nomeColuna = "nomeColuna";
final String emailColuna = "emailColuna";
final String telefoneColuna = "telefoneColuna";
final String imgColuna = "imgColuna";

class ContatoHelper {}

class Contato {
  int id;
  int idade;
  String nome;
  String email;
  String telefone;
  String img;

  //Mapa de Contato : Pegando do Map e inserindo no Contato
  Contato.fromMap(Map map) {
    id = map[idColuna];
    idade = map[idadeColuna];
    nome = map[nomeColuna];
    email = map[emailColuna];
    telefone = map[telefoneColuna];
    img = map[imgColuna];
  }

//Contato : Pegando do Contato e inserindo no Mapa
  Map toMap() {
    Map<String, dynamic> map = {
      nomeColuna: nome,
      idadeColuna: idade,
      emailColuna: email,
      telefoneColuna: telefone,
      imgColuna: img,
    };
    if (id != null) {
      map[idColuna] = id;
    }
    return map;
  }
}
