import 'dart:convert';

import 'package:employ_info/models/employee_detail_model.dart';
import 'package:employ_info/models/employee_model.dart';
import 'package:employ_info/repository/employee_repository/employee_repository.dart';
import 'package:flutter/services.dart';

class EmployeeRepositoryImp extends EmployeeRepository {
  EmployeeRepositoryImp();

  Future<String> get _localEmployeeFile async {
    return 'employeeList.json';
  }

  Future<String> get _localEmployeeDetailsFile async {
    return 'employeeDetails.json';
  }

  Future<String> _readFile(String fileName) async {
    String? jsonText = await rootBundle.loadString('assets/$fileName');
    return jsonText;
  }

  @override
  Future<List<Employee>> getEmployeeList() async {
    List<Employee> result = [];
    String? jsonText = await _readFile(await _localEmployeeFile);
    result = List<Employee>.from(
        json.decode(jsonText).map((x) => Employee.fromJson(x)));
    await Future.delayed(const Duration(milliseconds: 1500), () async {});
    return result;
  }

  @override
  Future<List<EmployeeDetails>> getEmployeeDetailsList() async {
    List<EmployeeDetails> result = [];
    String? jsonText = await _readFile(await _localEmployeeDetailsFile);
    result = List<EmployeeDetails>.from(
        json.decode(jsonText).map((x) => EmployeeDetails.fromJsonFile(x)));
    await Future.delayed(const Duration(milliseconds: 1500), () async {});
    return result;
  }
}
