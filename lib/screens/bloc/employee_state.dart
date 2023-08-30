part of 'employee_bloc.dart';

enum EmployeeStatus { initial, loading, success, error }

class EmployeeState extends Equatable {
  final List<Employee> employees;
  final EmployeeStatus status;

  const EmployeeState({
    this.employees = const <Employee>[],
    this.status = EmployeeStatus.initial,
  });

  EmployeeState copyWith({
    EmployeeStatus? status,
    List<Employee>? employees,
  }) {
    return EmployeeState(
      employees: employees ?? this.employees,
      status: status ?? this.status,
    );
  }

  @override
  factory EmployeeState.fromJson(Map<String, dynamic> json) {
    try {
      var listOfEmployees =
          (json['employee'] as List<dynamic>).map((e) => Employee.fromJson(e as Map<String, dynamic>)).toList();

      return EmployeeState(
        employees: listOfEmployees,
        status: EmployeeStatus.values.firstWhere((element) => element.name.toString() == json['status']),
      );
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {'employee': employees, 'status': status.name};
  }

  @override
  List<Object?> get props => [employees, status];
}
