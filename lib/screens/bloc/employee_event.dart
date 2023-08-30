part of 'employee_bloc.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object> get props => [];
}

class EmployeeStarted extends EmployeeEvent {}

class AddEmployee extends EmployeeEvent {
  final Employee employee;
  const AddEmployee(this.employee);
  @override
  List<Object> get props => [employee];
}

class UpdateEmployee extends EmployeeEvent {
  final Employee employee;
  const UpdateEmployee(this.employee);
  @override
  List<Object> get props => [employee];
}

class RemoveEmployee extends EmployeeEvent {
  final Employee employee;
  const RemoveEmployee(this.employee);
  @override
  List<Object> get props => [employee];
}

class AlterEmployee extends EmployeeEvent {
  final int index;
  const AlterEmployee(this.index);
  @override
  List<Object> get props => [index];
}
