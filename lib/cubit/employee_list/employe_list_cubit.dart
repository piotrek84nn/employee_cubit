import 'package:bloc/bloc.dart';
import 'package:employ_info/cubit/employee_list/employe_list_state.dart';
import 'package:employ_info/models/employee_model.dart';
import 'package:employ_info/services/sql_service.dart';

class EmployeeListCubit extends Cubit<EmployeeListState> {
  final SqliteService _sqlService;

  EmployeeListCubit(this._sqlService) : super(InitialEmployeeList());

  Future<void> loadEmployeeList() async{
    emit(LoadEmployeeList());
    await Future.delayed(const Duration(milliseconds: 1500), () async {});
    List<Employee>? empList = await _sqlService.getEmployeeList();
    empList ??= [];
    emit(EmployeeListLoaded(empList));
  }
}
