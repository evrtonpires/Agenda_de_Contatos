import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String StringContatoTable = "StringContatoTable";

final String idColuna = "idColuna";
final String idadeColuna = "idadeColuna";
final String nomeColuna = "nomeColuna";
final String emailColuna = "emailColuna";
final String telefoneColuna = "telefoneColuna";
final String imgColuna = "imgColuna";

class ContatoHelper {
  //padrao Singleton , contem apenas 1 objeto no código
  static final ContatoHelper _instance = ContatoHelper.interno();

  factory ContatoHelper() => _instance;

  ContatoHelper.interno();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return db;
    }
  }

  Future<Database> initDb() async {
    //lugar onde banco de dados é armazenado
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "contatos.db");

    //criar tabela de dados
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int novaVersao) async {
          await db.execute("CREATE TABLE $StringContatoTable ("
              "$idColuna INTEGER PRIMARY KEY, "
              "$idadeColuna INTEGER, "
              "$nomeColuna TEXT, "
              "$emailColuna TEXT, "
              "$telefoneColuna TEXT, "
              "$imgColuna TEXT"
              ")");
        });
  }

  Future<Contato> salvarContato(Contato c) async {
    Database dbContato = await db;
    await dbContato.insert(StringContatoTable, c.toMap());
    return c;
  }

  Future<Contato> getContato(int id) async {
    Database dbContato = await db;
    List<Map> maps = await dbContato.query(StringContatoTable,
        columns: [
          idColuna,
          idadeColuna,
          nomeColuna,
          emailColuna,
          telefoneColuna,
          imgColuna
        ],
        where: "$idColuna = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return Contato.fromMap(maps.first);
    } else {
      return null;
    }
  }
}

//------------------------------------------------

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
