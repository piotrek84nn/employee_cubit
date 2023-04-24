import 'package:employ_info/repository/employee_repository/employee_repository.dart';
import 'package:employ_info/repository/employee_repository/employee_repository_imp.dart';
import 'package:employ_info/services/sql_service.dart';
import 'package:employ_info/services/sql_service_imp.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];


List<SingleChildWidget> independentServices = [
  Provider<SqliteService>(create: (_) => SqliteServiceImp.initService()),
  Provider<EmployeeRepository>(create: (_) => EmployeeRepositoryImp()),
];


List<SingleChildWidget> dependentServices = [
];

List<SingleChildWidget> uiConsumableProviders = [
];
