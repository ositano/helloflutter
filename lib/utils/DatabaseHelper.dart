import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hello_flutter/models/Developer.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tableDeveloper = 'developersTable';

  final String columnLogin = 'login';
  final String columnId = 'id';
  final String columnNode_id = 'node_id';
  final String columnAvatar_url = 'avatar_url';
  final String columnGravatar_id = 'gravatar_id';
  final String columnUrl = 'url';
  final String columnHtml_url = 'html_url';
  final String columnFollowers_url = 'followers_url';
  final String columnFollowing_url = 'following_url';
  final String columnGists_url = 'gists_url';
  final String columnStarred_url = 'starred_url';
  final String columnSubscriptions_url = 'subscriptions_url';
  final String columnOrganizations_url = 'organizations_url';
  final String columnRepos_url = 'repos_url';
  final String columnEvents_url = 'events_url';
  final String columnReceived_events_url = 'received_events_url';
  final String columnType = 'type';

  static Database _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'developers.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableDeveloper($columnId INTEGER PRIMARY KEY, $columnLogin TEXT, $columnNode_id TEXT, $columnAvatar_url TEXT, $columnGravatar_id TEXT, $columnUrl TEXT, $columnHtml_url TEXT, $columnFollowers_url TEXT, $columnFollowing_url, $columnGists_url TEXT, $columnStarred_url TEXT, $columnSubscriptions_url TEXT, $columnOrganizations_url TEXT, $columnRepos_url TEXT, $columnEvents_url TEXT, $columnReceived_events_url TEXT, $columnType TEXT)');
  }

  Future<int> saveDeveloper(Developer developer) async {
    var dbClient = await db;
    var count = Sqflite.firstIntValue(await dbClient.rawQuery(
        "SELECT COUNT(*) FROM $tableDeveloper WHERE $columnId = ?",
        [developer.id]));
    if (count == 0) {
      return await dbClient.insert(tableDeveloper, developer.toMap());
    } else {
      return await dbClient.update(tableDeveloper, developer.toMap(),
          where: "$columnId = ?", whereArgs: [developer.id]);
    }
  }

  Future<List<Developer>> getAllDevelopers() async {
    var dbClient = await db;
    String sql;
    sql = "SELECT * FROM $tableDeveloper";
    var result = await dbClient.rawQuery(sql);
    if (result.length == 0) return new List<Developer>();
    List<Developer> list = result.map((item) {
      return Developer.fromMap(item);
    }).toList();
    return list;
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM $tableDeveloper'));
  }

  Future<Developer> getDeveloper(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableDeveloper,
        columns: [
          columnId,
          columnLogin,
          columnNode_id,
          columnNode_id,
          columnAvatar_url,
          columnGravatar_id,
          columnUrl,
          columnHtml_url,
          columnFollowers_url,
          columnFollowing_url,
          columnGists_url,
          columnStarred_url,
          columnSubscriptions_url,
          columnOrganizations_url,
          columnRepos_url,
          columnEvents_url,
          columnReceived_events_url,
          columnType
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (result.length > 0) {
      return new Developer.fromMap(result.first);
    }
    return null;
  }

  Future<int> deleteDeveloper(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableDeveloper, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> updateDeveloper(Developer developer) async {
    var dbClient = await db;
    return await dbClient.update(tableDeveloper, developer.toMap(),
        where: "$columnId = ?", whereArgs: [developer.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
