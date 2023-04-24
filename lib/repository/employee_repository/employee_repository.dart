import 'package:employ_info/models/employee_detail_model.dart';
import 'package:employ_info/models/employee_model.dart';

abstract class EmployeeRepository {
  Future<List<Employee>> getEmployeeList();
  Future<List<EmployeeDetails>> getEmployeeDetailsList();
}
