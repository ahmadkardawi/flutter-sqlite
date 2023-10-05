// ignore: file_names
import 'dart:io';
import 'package:belajarulang/models/student_models.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:intl/intl.dart';

DateTime now = DateTime.now();
String formattedDate = DateFormat('dd MMMM yyyy').format(now);

class DatabaseInstance extends GetxController {
  final String _databasename = 'catatanku.db';
  final int _databaseversion = 5;
  // final Student student = Student();
  final String table = 'catatan';
  final String id = 'id';
  final String judul = 'judul';
  final String isi = 'isi';
  final String createdAt = 'cretedAt';
  final String updatedAt = 'updatedAt';

  Database? _database;
  Future<Database> database() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databasename);
    return await openDatabase(path,
        version: _databaseversion, onCreate: _onCreate);
  }

  Future _onCreate(Database database, int version) async {
    await database.execute(
        'CREATE TABLE $table ($id INTEGER PRIMARY KEY, $judul TEXT NULL, $isi TEXT NULL, $createdAt TEXT NULL, $updatedAt TEXT NULL)');
  }

  Future<List<Student>> all() async {
    final db = await database();
    final dataku = await db.query(table);
    // final data = await _database!.query(table);
    List<Student> result = dataku.map((e) => Student.fromMap(e)).toList();
    return result;
  }

  Future<int> insert(Map<String, dynamic> row) async {
    final query = await _database!.insert(table, row);
    return query;
  }

  Future<int> updateStudent(int idPrams, Map<String, dynamic> row) async {
    final db = await _database!.update(
      table,
      row,
      where: '$id = ?',
      whereArgs: [idPrams],
    );
    return db;
  }

  Future delete(int idParams) async {
    await _database!.delete(
      table,
      where: '$id = ?',
      whereArgs: [idParams],
    );
  }
}
