import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  // Método para obtener la base de datos
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  // Inicializar la base de datos
  Future<Database> _initDB() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'market_app.db');

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE sucursales(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT NOT NULL      
          )
        ''');
        await db.insert('sucursales', {'nombre': 'Sucursal Centro'});
        await db.insert('sucursales', {'nombre': 'Sucursal Norte'});
        await db.insert('sucursales', {'nombre': 'Sucursal Sur'});
      },
    );
  }  
}
