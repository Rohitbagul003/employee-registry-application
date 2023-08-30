import 'package:employee_app/models/employee.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends HydratedBloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(const EmployeeState()) {
    on<EmployeeStarted>(_onStarted);
    on<AddEmployee>(_onAddEmployee);
    on<RemoveEmployee>(_onRemoveEmployee);
    on<AlterEmployee>(_onAlterEmployee);
    on<UpdateEmployee>(_onUpdateEmployee);
  }

  void _onStarted(
    EmployeeStarted event,
    Emitter<EmployeeState> emit,
  ) {
    if (state.status == EmployeeStatus.success) return;
    emit(state.copyWith(employees: state.employees, status: EmployeeStatus.success));
  }

  void _onAddEmployee(
    AddEmployee event,
    Emitter<EmployeeState> emit,
  ) {
    emit(state.copyWith(status: EmployeeStatus.loading));
    try {
      List<Employee> temp = [];
      temp.addAll(state.employees);
      temp.insert(0, event.employee);
      emit(state.copyWith(employees: temp, status: EmployeeStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EmployeeStatus.error));
    }
  }

  void _onUpdateEmployee(
    UpdateEmployee event,
    Emitter<EmployeeState> emit,
  ) {
    emit(state.copyWith(status: EmployeeStatus.loading));
    try {
      List<Employee> temp = [];
      temp.addAll(state.employees);

      final employIndex = temp.indexWhere((element) => event.employee.id == element.id);
      if (employIndex != -1) {
        temp.removeWhere((element) => event.employee.id == element.id);
        temp.insert(employIndex, event.employee);
      }
      emit(state.copyWith(employees: temp, status: EmployeeStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EmployeeStatus.error));
    }
  }

  void _onRemoveEmployee(
    RemoveEmployee event,
    Emitter<EmployeeState> emit,
  ) {
    emit(state.copyWith(status: EmployeeStatus.loading));
    try {
      state.employees.remove(event.employee);
      emit(state.copyWith(employees: state.employees, status: EmployeeStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EmployeeStatus.error));
    }
  }

  void _onAlterEmployee(
    AlterEmployee event,
    Emitter<EmployeeState> emit,
  ) {
    emit(state.copyWith(status: EmployeeStatus.loading));
    try {
      state.employees[event.index].isDone = !state.employees[event.index].isDone;
      emit(state.copyWith(employees: state.employees, status: EmployeeStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EmployeeStatus.error));
    }
  }

  @override
  EmployeeState? fromJson(Map<String, dynamic> json) {
    return EmployeeState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(EmployeeState state) {
    return state.toJson();
  }
}
