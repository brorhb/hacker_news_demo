import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'dart:async';
import 'package:hacker_news/src/models/item_model.dart';
import 'package:hacker_news/src/resources/repository.dart';

class NewsDBProvider implements Source, Cache {
  Database db;

  NewsDBProvider() {
    init();
  }
  
  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, 'items.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
          CREATE TABLE Items
            (
              id INTEGER PRIMARY KEY,
              deleted INTEGER,
              type TEXT,
              by TEXT,
              time INTEGER,
              text TEXT,
              dead INTEGER,
              parent INTEGER,
              kids BLOB,
              url TEXT,
              score INTEGER,
              title TEXT,
              descendants INTEGER
            )
        """);
      }
    );
  }

  Future<List<int>> fetchTopIds () {
    return null;
  }

  Future<ItemModel> fetchItem (int id) async {
    // db.query sanitizes the SQL, making sql injections harder
    final List<Map<String, dynamic>> items = await db.query(
      'Items',
      where: 'id = ?',
      // question marks matches up with whereArgs
      whereArgs: [id]
    );
    if (items.length > 0) {
      return ItemModel.fromDB(items.first);
    }
    return null;
  }

  Future<int> addItem (ItemModel item) {
    return db.insert(
      'items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<int> clear () async {
    return db.delete('items');
  }

}

// We declare newsDbProvider as a global varibale to prevent us from creating multiple instances of the same class.
final NewsDBProvider newsDBProvider = NewsDBProvider();