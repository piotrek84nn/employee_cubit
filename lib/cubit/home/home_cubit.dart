import 'package:bloc/bloc.dart';
import 'package:employ_info/cubit/home/home_state.dart';
import 'package:employ_info/repository/employee_repository/employee_repository.dart';
import 'package:employ_info/services/sql_service.dart';
import 'package:employ_info/services/sql_service_imp.dart';

class HomeCubit extends Cubit<HomeState> {
  final EmployeeRepository _repository;
  final SqliteService _sqlService;

  HomeCubit(this._repository, this._sqlService) : super(InitHomeState());

  Future<void> initializeDatabase() async{
    emit(InitHomeState());
    bool isDbExist = await (_sqlService as SqliteServiceImp).databaseExists();
    if(!isDbExist) {
      await (_sqlService as SqliteServiceImp).initializeDatabaseWithData(_repository);
    } else {
      await Future.delayed(const Duration(milliseconds: 1500), () async {});
    }
    emit(HomeInitializedState());
  }
}
