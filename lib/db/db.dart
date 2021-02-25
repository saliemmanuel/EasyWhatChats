import 'package:easywhatchat/Pages/models/callLogModels.dart';
import 'package:easywhatchat/Pages/models/numeroModels.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Database db;
Future<void> initDatabase() async {
  var path = await getDatabasePath('request.db');
  db = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
    var tableNumeros =
        "CREATE TABLE `numeros` (`id` int(2) NOT NULL,`dialcode` varchar(255) UNIQUE NOT NULL, `numero` varchar(255) UNIQUE NOT NULL, `message` varchar(255) NOT NULL)";
    var tableCallLogs =
        "CREATE TABLE `calllogs` (`id` int(2) NOT NULL,`number` varchar(255) UNIQUE NOT NULL, `name` varchar(255) )";
    await db.execute(tableNumeros);
    await db.execute(tableCallLogs);
  });
}

Future<String> getDatabasePath(String dbName) async {
  var dataPath = await getDatabasesPath();
  var path = join(dataPath, dbName);
  return path;
}

// Numero //
//Inserstion numero
Future<int> saveItem(Numero nouveauNumero) async {
  int res = await db.insert(
    "numeros",
    nouveauNumero.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  return res;
}

//get all numero
Future<List> getItems() async {
  var result = await db.rawQuery("SELECT * FROM numeros ORDER BY numero ASC");
  return result.toList();
}

// Comptage
Future<int> getCount() async {
  return Sqflite.firstIntValue(
      await db.rawQuery("SELECT COUNT(*) FROM numeros"));
}

// Mise a jours
update(Numero nouveauNumero) async {
  var result = await db.update("numeros", nouveauNumero.toMap(),
      where: "numero = ?", whereArgs: [nouveauNumero.numero]);
  return result;
}

// Suppression par numero
deleteOneItem(String numero) async {
  var result = await db.delete("numeros", where: "numero = $numero");
  return result;
}

// Suppression complet*
Future<int> deleteItem() async {
  return await db.delete("numeros");
}

// Call_Logs //
// get all call_logs
Future<List> getCallLogs() async {
  var result = await db.rawQuery("SELECT * FROM calllogs ORDER BY number ASC");
  return result.toList();
}

//Inserstion CallLogs
Future<int> saveCallLogs(CallLogModels callLogModels) async {
  int res = await db.insert(
    "calllogs",
    callLogModels.toMap(),
    conflictAlgorithm: ConflictAlgorithm.ignore,
  );
  return res;
}
