import 'package:employ_info/models/employee_model.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  final List<Employee> employees = <Employee>[];

  @override
  List<Object> get props => [employees];
}

class InitHomeState extends HomeState {
  InitHomeState();
}

class HomeInitializedState extends HomeState {
  HomeInitializedState();
}
