import 'dart:math';

import 'package:employee_app/models/employee.dart';
import 'package:employee_app/screens/bloc/employee_bloc.dart';
import 'package:employee_app/screens/employee_list.dart';
import 'package:employee_app/utils/components.dart';
import 'package:employee_app/utils/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEmployeeDetails extends StatefulWidget {
  final String id;
  final String name;
  final String designation;
  final String fromDate;
  final String toDate;

  const AddEmployeeDetails({
    super.key,
    required this.id,
    required this.name,
    required this.designation,
    required this.fromDate,
    required this.toDate,
  });

  @override
  _AddEmployeeDetailsState createState() => _AddEmployeeDetailsState();
}

class _AddEmployeeDetailsState extends State<AddEmployeeDetails> with Utility {
  Components decoration = Components();
  final List<String> _items = ['Product Designer', 'Flutter Developer', 'QA Tester', 'Product Owner'];
  TextEditingController nameController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    designationController.dispose();
    fromDateController.dispose();
    toDateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      if (widget.id != "") {
        nameController.text = widget.name;
        designationController.text = widget.designation;
        fromDateController.text = widget.fromDate;
        toDateController.text = widget.toDate;
      } else {
        nameController.text = "";
        designationController.text = "";
        fromDateController.text = "";
        toDateController.text = "";
      }
    });
  }

  addEmployee(Employee employee) {
    context.read<EmployeeBloc>().add(AddEmployee(employee));
  }

  updateEmployee(Employee employee) {
    context.read<EmployeeBloc>().add(UpdateEmployee(employee));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Add Employee Details",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: const BoxDecoration(),
        child: BlocConsumer<EmployeeBloc, EmployeeState>(
          listener: (context, state) {
            debugPrint("##2$state");
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 40,
                  child: TextFormField(
                    controller: nameController,
                    decoration: decoration.textFormFieldDecoration(
                      "Employee name",
                      CupertinoIcons.person,
                    ),
                  ),
                ),
                heightBox20(),
                SizedBox(
                  height: 40,
                  child: TextFormField(
                    readOnly: true,
                    onTap: () => showModal(context),
                    controller: designationController,
                    decoration: decoration.textFormFieldDecorationWithSuffix(
                      "Select Role",
                      CupertinoIcons.bag,
                      Icons.arrow_drop_down_outlined,
                    ),
                  ),
                ),
                heightBox20(),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          controller: fromDateController,
                          readOnly: true,
                          onTap: () {
                            decoration.showDatePickerDecoration(context).then((value) {
                              setState(() {
                                String month = value.month.toString().padLeft(2, '0');
                                String day = value.day.toString().padLeft(2, '0');
                                fromDateController.text = "${value.year}-$month-$day";
                              });
                              debugPrint("## ${fromDateController.text}");
                            });
                          },
                          decoration: decoration.textFormFieldDecoration(
                            fromDateController.text.isEmpty ? "Today" : fromDateController.text,
                            Icons.calendar_today,
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: Icon(
                        CupertinoIcons.arrow_right,
                        color: Colors.blue,
                        size: 15,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          readOnly: true,
                          controller: toDateController,
                          onTap: () {
                            decoration.showDatePickerDecoration(context).then((value) {
                              setState(() {
                                String month = value.month.toString().padLeft(2, '0');
                                String day = value.day.toString().padLeft(2, '0');
                                toDateController.text = "${value.year}-$month-$day";
                              });
                            });
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.calendar_today,
                              size: 18,
                              color: Colors.blue,
                            ),
                            hintText: "No date",
                            hintStyle: const TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w400),
                            // labelText: _selected == "null" ? "Select Role" : "$_selected",
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red.withOpacity(0.4), width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      onPressed: () {
                        debugPrint("widget id : ${widget.id}");
                        if (widget.id.isEmpty) {
                          String id = Random().nextInt(30).toString();
                          addEmployee(
                            Employee(
                              id: id,
                              name: nameController.text,
                              designation: designationController.text,
                              fromDate: fromDateController.text,
                              toDate: toDateController.text,
                            ),
                          );
                        } else {
                          updateEmployee(
                            Employee(
                              id: widget.id,
                              name: nameController.text,
                              designation: designationController.text,
                              fromDate: fromDateController.text,
                              toDate: toDateController.text,
                            ),
                          );
                        }

                        Navigator.pushAndRemoveUntil(
                            context, MaterialPageRoute(builder: (context) => const EmployeeList()), (route) => false);
                        // Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void showModal(context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        // <-- SEE HERE
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return Container(
          // padding: EdgeInsets.all(8),
          height: 210,
          alignment: Alignment.center,
          child: ListView.separated(
            itemCount: _items.length,
            separatorBuilder: (context, int index) {
              return Divider(
                color: Colors.grey.withOpacity(0.4),
                thickness: 0.4,
              );
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Center(
                    child: Text(
                      _items[index],
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    designationController.text = _items[index];
                  });
                  // Navigator.pushAndRemoveUntil(
                  //     context, MaterialPageRoute(builder: (context) => EmployeeList()), (route) => false);
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        );
      },
    );
  }
}
