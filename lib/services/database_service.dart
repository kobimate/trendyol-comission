import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/category.dart';

class DatabaseService {
  DatabaseService._();
  static final instance = DatabaseService._();
  Database? _db;
  Future<Database> get database async => _db ??= await _open();

  Future<Database> _open() async {
    final db = await openDatabase(join(await getDatabasesPath(), 'trendyol_commission.db'), version: 1, onCreate: (db, _) async {
      await db.execute('CREATE TABLE categories (id INTEGER PRIMARY KEY, parent_id INTEGER, name TEXT NOT NULL, commission REAL NOT NULL DEFAULT 0)');
      await db.execute('CREATE TABLE shipment (id INTEGER PRIMARY KEY AUTOINCREMENT, mp_uuid TEXT, name TEXT NOT NULL, desi REAL NOT NULL, price REAL NOT NULL)');
      await db.execute('CREATE TABLE history (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, url TEXT NOT NULL, category_id INTEGER, price REAL NOT NULL, currency TEXT, image TEXT, rating REAL, order_count TEXT, commission REAL, searched_at TEXT NOT NULL)');
      await db.insert('categories', {'id': 1909, 'parent_id': null, 'name': 'Koşu Bandı', 'commission': 12});
      await db.insert('categories', {'id': 100, 'parent_id': null, 'name': 'Elektronik', 'commission': 10});
      await db.insert('categories', {'id': 101, 'parent_id': 100, 'name': 'Aksesuar', 'commission': 15});
    });
    return db;
  }

  Future<Category?> category(int id) async { final rows = await (await database).query('categories', where: 'id = ?', whereArgs: [id], limit: 1); return rows.isEmpty ? null : Category.fromMap(rows.first); }
  Future<List<Category>> roots([String query = '']) async { final rows = await (await database).query('categories', where: 'parent_id IS NULL AND name LIKE ?', whereArgs: ['%$query%'], orderBy: 'name'); return rows.map(Category.fromMap).toList(); }
  Future<List<Category>> children(int parentId) async { final rows = await (await database).query('categories', where: 'parent_id = ?', whereArgs: [parentId], orderBy: 'name'); return rows.map(Category.fromMap).toList(); }
  Future<void> saveHistory(Map<String, Object?> values) async => (await database).insert('history', values);
  Future<List<Map<String, Object?>>> history() async => (await database).query('history', orderBy: 'searched_at DESC');
  Future<List<Map<String, Object?>>> shipments() async => (await database).query('shipment', orderBy: 'desi');
}
