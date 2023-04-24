import 'dart:io';

import 'package:employ_info/models/employee_detail_model.dart';
import 'package:employ_info/models/employee_model.dart';
import 'package:employ_info/repository/employee_repository/employee_repository.dart';
import 'package:employ_info/services/sql_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as join;

class SqliteServiceImp extends SqliteService {
  static const String databaseName = "employee.db";
  static Database? db;

  static SqliteServiceImp initService() {
    return SqliteServiceImp._();
  }

  SqliteServiceImp._() {
    _initializeDb();
  }

  static Future<void> _initializeDb() async {
    if (db != null) {
      return;
    }
      final databasePath = await getDatabasesPath();
      final path = join.join(databasePath, databaseName);
      db = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          await _createTables(db);
        },
      );
  }

  Future<bool> databaseExists() async {
    final databasePath = await getDatabasesPath();
    final path = join.join(databasePath, databaseName);
    return databaseFactory.databaseExists(path);
  }

  static Future<void> _createTables(Database database) async {
    await database.transaction((txn) async {
      await txn.execute("CREATE TABLE Gender(id INTEGER PRIMARY KEY, "
          "name TEXT NOT NULL)");

      await txn.execute("CREATE TABLE Employee(id INTEGER PRIMARY KEY, "
          "name TEXT NOT NULL, surName TEXT NOT NULL, "
          "birthDate TEXT NOT NULL)");

      await txn.execute("CREATE TABLE EmployeeDetail(id INTEGER PRIMARY KEY, "
          "job TEXT, "
          "gender INTEGER, "
          "adressStreet TEXT, "
          "adressStreetNumber TEXT, "
          "adressPlz TEXT,"
          "FOREIGN KEY (id) REFERENCES Employee (id) ON DELETE NO ACTION ON UPDATE NO ACTION,"
          "FOREIGN KEY (gender) REFERENCES Gender (id) ON DELETE NO ACTION ON UPDATE NO ACTION)");
    });
  }

  Future<void> initializeDatabaseWithData(EmployeeRepository repository) async {
    await _initializeDb();
    List<Employee>? empList = await repository.getEmployeeList();
    List<EmployeeDetails>? empDetailsList =
        await repository.getEmployeeDetailsList();
    EmployeeDetails empDetObj;

    await db?.transaction((txn) async {
      await _addGenderItem('Male', txn);
      await _addGenderItem('Female', txn);

      for (Employee e in empList) {
        await _addEmployeeItem(e, txn);
        empDetObj = empDetailsList.firstWhere((element) => element.id == e.id);
        await _addEmployeeDetailsItem(empDetObj, txn);
      }
    });
  }

  static Future<int?> _addGenderItem(String name, Transaction txn) async {
    var value = {'name': name};
    final id = await txn.insert('Gender', value,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<int?> _addEmployeeItem(Employee e, Transaction txn) async {
    final id = await txn.insert('Employee', e.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<int?> _addEmployeeDetailsItem(
      EmployeeDetails e, Transaction txn) async {
    final id = await txn.insert('EmployeeDetail', e.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  @override
  Future<List<Employee>?> getEmployeeList() async {
    await _initializeDb();
    List<Employee>? result = [];
    try {
      await db?.transaction((txn) async {
        final List<Map<String, Object?>> queryResult =
            await txn.query('Employee');
        result = queryResult.map((e) => Employee.fromJson(e)).toList();
      });
    } catch (_) {}
    return result;
  }

  @override
  Future<EmployeeDetails?> getEmployeeDetails(int id) async {
    await _initializeDb();
    EmployeeDetails? result;
    try {
      await db?.transaction((txn) async {
        final List<Map<String, Object?>> queryResult =
            await txn.query('EmployeeDetail', where: "id = ?", whereArgs: [id]);
        Iterable<EmployeeDetails>? it =
            queryResult.map((e) => EmployeeDetails.fromJson(e));
        if (it.isNotEmpty) {
          result = it.first;
        }
      });
    } catch (_) {}
    return result;
  }

  @override
  Future<bool> updateEmployeeDetailsItem(Map<String, dynamic> employee,
      Map<String, dynamic> employeeDetails) async {
    await _initializeDb();
    bool result = false;
    try {
      await db?.transaction((txn) async {
        await txn.insert('Employee', employee,
            conflictAlgorithm: ConflictAlgorithm.replace);

        await txn.insert('EmployeeDetail', employeeDetails,
            conflictAlgorithm: ConflictAlgorithm.replace);
        result = true;
      });
    } catch (_) {}
    return result;
  }
}
