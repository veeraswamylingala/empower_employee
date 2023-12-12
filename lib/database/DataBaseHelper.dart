// import 'package:qurinom_learnings/Models/notes_model.dart';
import 'dart:developer';

import 'package:empower_employees/models/EmployeModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 1;
  static const table = 'emp_list';

// this opens the database (and creates it if it doesn't exist)
  Future<Database> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  //SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $table(id INTEGER PRIMARY KEY,name TEXT NOT NULL,gender TEXT NOT NULL,mobileNumber TEXT NOT NULL,designation TEXT NOT NULL,country TEXT NOT NULL,state TEXT NOT NULL,city TEXT NOT NULL,about TEXT NOT NULL)',
    );
  }

  // Inserts a row in the database
  Future<int> insert(Map<String, dynamic> row) async {
    final Database db = await init();
    return await db.insert(table, row);
  }

  // Inserts a row in the database
  Future<int> update(
      {required EmployeeModel employeData, required int? id}) async {
    final Database db = await init();
    return await db
        .update(table, employeData.toJson(), where: 'id = ?', whereArgs: [id]);
  }

  // get all rows
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    final Database db = await init();
    return await db.query(table);
  }

  // get single row
  Future<List<Map<String, dynamic>>> querySingleRow(
      {required String mobileNumber}) async {
    final Database db = await init();
    return await db
        .query(table, where: 'mobileNumber = ?', whereArgs: [mobileNumber]);
  }

  // get single row
  Future<List<Map<String, dynamic>>> filterRecords(
      {required Map filterMap}) async {
    final Database db = await init();

    String filterKeys = "";
    List<String> filterValues = [];

    //based on filter mapp add colum names and column values to wherekey and wherevalues
    filterMap.forEach((key, value) {
      //set where key-----
      if (filterKeys.isEmpty) {
        filterKeys = "$key = ?";
      } else {
        filterKeys = "$filterKeys and $key = ? ";
      }

      //set where value-----
      filterValues.add(value);
    });
    log(filterKeys.toString(), name: "Keys");
    log(filterValues.toString(), name: "values");

    return await db.query(table, where: filterKeys, whereArgs: filterValues);
  }

  //delete single record
  Future<int> deleteRecord({required String mobileNumber}) async {
    final Database db = await init();
    return await db
        .delete(table, where: 'mobileNumber = ?', whereArgs: [mobileNumber]);
  }
}
