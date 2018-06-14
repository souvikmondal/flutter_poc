import 'package:path/path.dart';
import 'package:poc/model/formdata.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io' as io;

final String dbName = "poc.db";
final String tableName = "FORM_DATA";
final String columnName = "name";
final String columnEmail = "email";
final String columnMobile = "mobile";
final String columnAge = "age";
final String columnImagePath = "imagepath";
final String columnLatitude = "latitude";
final String columnLongitude = "longitude";

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  DatabaseHelper.internal();

  static DatabaseHelper get instance => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, dbName);
    var pocDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return pocDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tableName($columnName TEXT, $columnEmail TEXT, $columnMobile TEXT, $columnAge TEXT, $columnImagePath TEXT, $columnLatitude TEXT, $columnLongitude TEXT)");
    print("Table is Created ");
  }

  //insert data
  Future<int> saveFormData(FormData form) async {
    var dbClient = await db;
    int res = await dbClient.insert(tableName, form.toMap());
    return res;
  }

  //fetch Data
  Future<List<FormData>> getAllData() async {
    List<FormData> result = new List<FormData>() ;
    var dbClient = await db;
    List<Map> maps = await dbClient.query(tableName, columns: [
      columnName,
      columnEmail,
      columnMobile,
      columnAge,
      columnImagePath,
      columnLatitude,
      columnLongitude
    ]);
    int length = maps.length;
    if (length > 0) {
      for (int i = 0; i < length; i++) {
        FormData data = new FormData.fromMap(maps.elementAt(i));
        result.add(data);

      }
      return result;
    }
    return null;
  }
}
