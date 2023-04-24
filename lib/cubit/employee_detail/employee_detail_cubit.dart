import 'package:bloc/bloc.dart';
import 'package:employ_info/cubit/employee_detail/employee_detail_state.dart';
import 'package:employ_info/models/employee_model.dart';
import 'package:employ_info/services/sql_service.dart';
import 'package:flutter/material.dart';

class EmployeeDetailCubit extends Cubit<EmployeeDetailState> {
  final SqliteService sqlService;
  final Employee employee;

  EmployeeDetailCubit({required this.sqlService, required this.employee}) : super(EmployeeDetailInitState());

  set employName(String? value) => emit(
    state.copyWith(
      name: value,
    ),
  );

  set employSurName(String? value) => emit(
    state.copyWith(
      surName: value,
    ),
  );

  set employBirthDate(DateTime? value) => emit(
    state.copyWith(
      birthDate: value,
    ),
  );

  set employJob(String? value) => emit(
    state.copyWith(
      job: value,
    ),
  );

  set employeeGender(int? value) => emit(
    state.copyWith(
      gender: value,
    ),
  );

  set employAdressStreet(String? value) => emit(
    state.copyWith(
      adressStreet: value,
    ),
  );

  set employAdressStreetNumber(String? value) => emit(
    state.copyWith(
      adressStreetNumber: value,
    ),
  );

  set employAdressPlz(int? value) => emit(
    state.copyWith(
      adressPlz: value,
    ),
  );

  Future<void> getEmployeeDetails() async{
    emit(EmployeeDetailLoadState());
    await Future.delayed(const Duration(milliseconds: 1500), () async {});
    var employeeDetail = await sqlService.getEmployeeDetails(employee.id!);
    emit(EmployeeDetailLoadedState.fromDatabase(employee: employee, employeeDetails: employeeDetail!));
  }

  Future<void> saveEmployeeDetails(BuildContext context) async{
    var currentState = state;
    emit(EmployeeDetailLoadState());
    await Future.delayed(const Duration(milliseconds: 1500), () async {});
    bool employeeDetail = await sqlService.updateEmployeeDetailsItem(currentState.employeeToDatabase(), currentState.employeeDetailsToDatabase());
    if(employeeDetail) {
      Navigator.of(context).pop(employeeDetail);
    } else {
      emit(EmployeeDetailErrorState(currentState.employeeToDatabase(), currentState.employeeDetailsToDatabase()));
    }
  }
}
