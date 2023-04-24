import 'package:employ_info/models/employee_detail_model.dart';
import 'package:employ_info/models/employee_model.dart';
import 'package:equatable/equatable.dart';

abstract class EmployeeDetailState extends Equatable {
  EmployeeDetailState copyWith({
    int? id,
    String? name,
    String? surName,
    DateTime? birthDate,
    String? job,
    int? gender,
    String? adressStreet,
    String? adressStreetNumber,
    int? adressPlz,
  });

  Map<String, dynamic> employeeToDatabase();
  Map<String, dynamic> employeeDetailsToDatabase();

  @override
  List<Object?> get props => [];
}

class EmployeeDetailInitState extends EmployeeDetailState {
  @override
  EmployeeDetailInitState copyWith({
    int? id,
    String? name,
    String? surName,
    DateTime? birthDate,
    String? job,
    int? gender,
    String? adressStreet,
    String? adressStreetNumber,
    int? adressPlz,
  }) {
    return EmployeeDetailInitState();
  }

  @override
  Map<String, dynamic> employeeToDatabase() => {'': ''};
  @override
  Map<String, dynamic> employeeDetailsToDatabase() => {'': ''};
}

class EmployeeDetailLoadState extends EmployeeDetailState {
  @override
  EmployeeDetailLoadState copyWith({
    int? id,
    String? name,
    String? surName,
    DateTime? birthDate,
    String? job,
    int? gender,
    String? adressStreet,
    String? adressStreetNumber,
    int? adressPlz,
  }) {
    return EmployeeDetailLoadState();
  }

  @override
  Map<String, dynamic> employeeToDatabase() => {'': ''};
  @override
  Map<String, dynamic> employeeDetailsToDatabase() => {'': ''};
}

class EmployeeDetailLoadedState extends EmployeeDetailState {
  late final int? id;
  late final String? name;
  late final String? surName;
  late final DateTime? birthDate;
  late final String? job;
  late final int? gender;
  late final String? adressStreet;
  late final String? adressStreetNumber;
  late final int? adressPlz;

  EmployeeDetailLoadedState._(
    this.id,
    this.name,
    this.surName,
    this.birthDate,
    this.job,
    this.gender,
    this.adressStreet,
    this.adressStreetNumber,
    this.adressPlz,
  );

  factory EmployeeDetailLoadedState.fromDatabase(
      {required Employee employee, required EmployeeDetails employeeDetails}) {
    return EmployeeDetailLoadedState._(
      employee.id,
      employee.name,
      employee.surName,
      employee.birthDate,
      employeeDetails.job,
      employeeDetails.gender,
      employeeDetails.adressStreet,
      employeeDetails.adressStreetNumber,
      employeeDetails.adressPlz,
    );
  }

  @override
  EmployeeDetailLoadedState copyWith({
    int? id,
    String? name,
    String? surName,
    DateTime? birthDate,
    String? job,
    int? gender,
    String? adressStreet,
    String? adressStreetNumber,
    int? adressPlz,
  }) {
    return EmployeeDetailLoadedState._(
      id ?? this.id,
      name ?? this.name,
      surName ?? this.surName,
      birthDate ?? this.birthDate,
      job ?? this.job,
      gender ?? this.gender,
      adressStreet ?? this.adressStreet,
      adressStreetNumber ?? this.adressStreetNumber,
      adressPlz ?? this.adressPlz,
    );
  }

  @override
  Map<String, dynamic> employeeToDatabase() => {
    "id": id,
    "name": name,
    "surName": surName,
    "birthDate": birthDate?.toIso8601String(),
  };


  @override
  Map<String, dynamic> employeeDetailsToDatabase() => {
    "id": id,
    "job": job,
    "gender": gender,
    "adressStreet": adressStreet,
    "adressStreetNumber": adressStreetNumber,
    "adressPlz": adressPlz,
  };

  @override
  List<Object?> get props => [
        name,
        surName,
        birthDate,
        job,
        gender,
        adressStreet,
        adressStreetNumber,
        adressPlz,
      ];
}

class EmployeeDetailErrorState extends EmployeeDetailState {
  final Map<String, dynamic> employeeDb;
  final Map<String, dynamic> employeeDetailsDb;
  EmployeeDetailErrorState(this.employeeDb, this.employeeDetailsDb);


  @override
  EmployeeDetailLoadState copyWith({
    int? id,
    String? name,
    String? surName,
    DateTime? birthDate,
    String? job,
    int? gender,
    String? adressStreet,
    String? adressStreetNumber,
    int? adressPlz,
  }) {
    return EmployeeDetailLoadState();
  }

  @override
  Map<String, dynamic> employeeToDatabase() => employeeDb;
  @override
  Map<String, dynamic> employeeDetailsToDatabase() => employeeDetailsDb;
}
