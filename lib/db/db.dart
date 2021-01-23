import 'package:easywhatchat/Pages/helper/models/numeroModels.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Database db;
Future<void> initDatabase() async {
  var path = await getDatabasePath('request.db');
  db = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
    var tableNumeros =
        "CREATE TABLE `numeros` (`id` int(2) NOT NULL,`numero` varchar(255) UNIQUE NOT NULL, `message` varchar(255) NOT NULL)";
    await db.execute(tableNumeros);
  });
}

//
Future<String> getDatabasePath(String dbName) async {
  var dataPath = await getDatabasesPath();
  var path = join(dataPath, dbName);
  return path;
}

//Inserstion
Future<int> saveItem(Numero nouveauNumero) async {
  int res = await db.insert(
    "numeros",
    nouveauNumero.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  return res;
}

//get
Future<List> getItems() async {
  var result = await db.rawQuery("SELECT * FROM numeros ORDER BY numero ASC");
  return result.toList();
}

Future<int> getCount() async {
  return Sqflite.firstIntValue(
      await db.rawQuery("SELECT COUNT(*) FROM numeros"));
}
update(Numero nouveauNumero)async{
  var result = await db.update("numeros", nouveauNumero.toMap(),
  where: "numero = ?", whereArgs: [nouveauNumero.numero]
  );
  return result;
}

deleteOneItem(String numero) async {
  var result = await db.delete("numeros", where: "numero = $numero");
  return result;
}

Future<int> deleteItem() async {
  return await db.delete("numeros");
}
