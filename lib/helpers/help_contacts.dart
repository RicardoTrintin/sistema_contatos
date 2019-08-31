import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String contactTable = "contacTable";
final String columnId = "columnId";
final String columnNome = "columnNome";
final String columnCargo = "columnCargo";
final String columnEmpresa = "columnEmpresa";
final String columnTipoEmpresa = "columnTipoEmpresa";
final String columnTelefone = "columnTelefone";
final String columnEmail = "columnEmail";
final String columnAssunto = "columnAssunto";
final String columnImg = "columnImg";


class ContactHelper {

  static final ContactHelper _instance = ContactHelper.internal();

  factory ContactHelper() => _instance;

  ContactHelper.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }


  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "contact.db");

    return await openDatabase(
        path, version: 1, onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $contactTable($columnId INTEGER PRIMARY KEY, $columnNome TEXT, $columnCargo TEXT, $columnEmpresa TEXT,"
              "$columnTipoEmpresa TEXT, $columnTelefone TEXT, $columnEmail TEXT, $columnAssunto TEXT, $columnImg TEXT)"
      );
    });
  }

  Future<Contact> saveContact(Contact contact) async {
    Database dbContact = await db;
    contact.id = await dbContact.insert(contactTable, contact.toMap());
    return contact;
  }

  Future<Contact> getContact(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(contactTable,
        columns: [
          columnId,
          columnNome,
          columnCargo,
          columnEmpresa,
          columnTipoEmpresa,
          columnTelefone,
          columnEmail,
          columnAssunto,
          columnImg
        ], where: "$columnId = ?", whereArgs: [id]);
    if (maps.length > 0) {
      return Contact.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteContact(int id) async {
    Database dbContact = await db;
    return await dbContact
        .delete(contactTable, where: "$columnId = ?", whereArgs: [id]);
  }

  Future<int> editContact(Contact contact) async {
    Database dbContact = await db;
    return await dbContact.update(contactTable, contact.toMap(),
        where: "$columnId = ?", whereArgs: [contact.id]);
  }

  Future<List> getAllContacts() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $contactTable");
    List<Contact> listContact = List();
    for (Map m in listMap) {
      listContact.add(Contact.fromMap(m));
    }
    return listContact;
  }

  Future<int> getNumber() async {
    Database dbContact = await db;
    return Sqflite.firstIntValue(
        await dbContact.rawQuery("SELECT COUNT(*) FROM $contactTable"));
  }

  Future close() async {
    Database dbContact = await db;
    dbContact.close();
  }

}


class Contact{

  int id;
  String nome;
  String cargo;
  String empresa;
  String tipoEmpresa;
  String telefone;
  String email;
  String assunto;
  String img;

  Contact();

  //Contructor contacts
  Contact.fromMap(Map map){
      id = map[columnId];
      nome = map[columnNome];
      cargo = map[columnCargo];
      empresa = map[columnEmpresa];
      tipoEmpresa = map[columnTipoEmpresa];
      telefone = map[columnTelefone];
      email = map[columnEmail];
      assunto = map[columnAssunto];
      img = map[columnImg];

  }

  //function for returning map
  Map toMap() {
    Map<String, dynamic> map = {
        columnNome: nome,
        columnCargo: cargo,
        columnEmpresa: empresa,
        columnTipoEmpresa: tipoEmpresa,
        columnTelefone: telefone,
        columnEmail: email,
        columnAssunto: assunto,
        columnImg: img
    };
    if(id != null){
        map[columnId] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Contact(id: $id, nome: $nome, cargo: $cargo, empresa: $empresa, "
        "tipoEmpresa: $tipoEmpresa, telefone: $telefone, email: $email, assunto: $assunto, imagem: $img)";
  }


}
