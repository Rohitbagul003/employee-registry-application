import 'package:employee_app/models/employee.dart';
import 'package:employee_app/screens/add_employee_details.dart';
import 'package:employee_app/screens/bloc/employee_bloc.dart';
import 'package:employee_app/utils/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({super.key});

  @override
  _EmployeeDetailList createState() => _EmployeeDetailList();
}

class _EmployeeDetailList extends State<EmployeeList> with Utility {
  addEmployee(Employee employee) {
    context.read<EmployeeBloc>().add(AddEmployee(employee));
  }

  removeEmployee(Employee employee) {
    context.read<EmployeeBloc>().add(RemoveEmployee(employee));
  }

  alertEmployee(int index) {
    context.read<EmployeeBloc>().add(AlterEmployee(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee List", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<EmployeeBloc, EmployeeState>(
          builder: (context, state) {
            if (state.status == EmployeeStatus.initial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == EmployeeStatus.error) {
              return const Center(child: Text("Something went wrong, please try again later"));
            }

            if (state.status == EmployeeStatus.success) {
              if (state.employees.isEmpty) return const Center(child: Text("No Employee found"));

              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: state.employees.length,
                itemBuilder: (context, int i) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddEmployeeDetails(
                            id: state.employees[i].id,
                            name: state.employees[i].name,
                            designation: state.employees[i].designation,
                            toDate: state.employees[i].toDate,
                            fromDate: state.employees[i].fromDate,
                          ),
                        ),
                        (route) => false,
                      );
                    },
                    child: Slidable(
                      key: ValueKey(state.employees[i].id),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (_) {
                              removeEmployee(state.employees[i]);
                            },
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          state.employees[i].name,
                          style: const TextStyle(fontSize: 16),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.employees[i].designation,
                              style: const TextStyle(fontSize: 14),
                            ),
                            Text(
                              "From ${state.employees[i].fromDate}",
                              style: const TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AddEmployeeDetails(
                  id: "",
                  name: "",
                  designation: "",
                  toDate: "",
                  fromDate: "",
                );
              },
            ),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(
          CupertinoIcons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
