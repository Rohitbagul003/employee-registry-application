// ignore_for_file: public_member_api_docs, sort_constructors_first
class Employee {
  final String id;
  final String name;
  final String designation;
  final String fromDate;
  final String toDate;
  bool isDone;

  Employee({
    required this.id,
    this.name = "",
    this.designation = "",
    this.toDate = "",
    this.fromDate = "",
    this.isDone = false,
  });

  Employee copyWith({
    String? id,
    String? name,
    String? designation,
    String? fromDate,
    String? toDate,
    bool? isDone,
  }) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      designation: designation ?? this.designation,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      isDone: isDone ?? this.isDone,
    );
  }

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
        id: json['id'],
        name: json['name'],
        designation: json['designation'],
        fromDate: json['fromDate'],
        toDate: json['toDate'],
        isDone: json['isDone']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'designation': designation,
      'fromDate': fromDate,
      'toDate': toDate,
      'isDone': isDone
    };
  }

  @override
  String toString() {
    return '''Employee{id: $id\nname: $name\n designation: $designation\n fromDate: $fromDate\n toDate: $toDate\n isDone: $isDone\n}''';
  }
}
