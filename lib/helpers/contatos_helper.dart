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

  Future<int> deletarContato(int id) async {
    Database dbContato = await db;
    return await dbContato
        .delete(StringContatoTable, where: "$idColuna = ? ", whereArgs: [id]);
  }

  Future<int> updateContato(Contato c) async {
    Database dbContato = await db;
    return await dbContato.update(StringContatoTable, c.toMap(),
        where: "$idColuna = ?", whereArgs: [c.id]);
  }

  Future<List> getAllContatos() async {
    Database dbContato = await db;
    List listMap = await dbContato.rawQuery(
        "SELECT * FROM $StringContatoTable");

    List<Contato> listContato = List();

    for (Map m in listMap) {
      listContato.add(Contato.fromMap(m));
    }
    return listContato;
  }

  Future<int> getNumero() async {
    Database dbContato = await db;
    return Sqflite.firstIntValue(
        await dbContato.rawQuery("SELECT COUNT(*) FROM $StringContatoTable"));
  }

  Future close() async {
    Database dbContato = await db;
    dbContato.close();
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

  Contato();

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

  @override
  String toString() {
    return "\n$id , $idade , $nome , $email , $telefone , $img \n";
  }


}
