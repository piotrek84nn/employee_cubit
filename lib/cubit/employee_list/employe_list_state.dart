import 'package:employ_info/models/employee_model.dart';
import 'package:equatable/equatable.dart';

abstract class EmployeeListState extends Equatable {
  final List<Employee> employees = <Employee>[];

  @override
  List<Object> get props => [employees];
}

class InitialEmployeeList extends EmployeeListState {
  InitialEmployeeList();
}

class LoadEmployeeList extends EmployeeListState {
  LoadEmployeeList();
}

class EmployeeListLoaded extends EmployeeListState {
  @override
  final List<Employee> employees;

  EmployeeListLoaded(this.employees);

  @override
  List<Object> get props => [employees];
}
