import 'package:employ_info/models/employee_detail_model.dart';
import 'package:employ_info/models/employee_model.dart';

abstract class SqliteService {
  static const male = 1;
  static const female = male + 1;
  Future<List<Employee>?> getEmployeeList();
  Future<EmployeeDetails?> getEmployeeDetails(int id);
  Future<bool> updateEmployeeDetailsItem(Map<String, dynamic> employee, Map<String, dynamic> employeeDetails);
}