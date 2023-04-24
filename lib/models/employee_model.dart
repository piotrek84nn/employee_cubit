class Employee {
  Employee({
    this.id,
    required this.name,
    required this.surName,
    required this.birthDate,
  });

  int? id;
  String name;
  String surName;
  DateTime birthDate;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json["id"] ?? 0,
    name: json["name"],
    surName: json["surName"],
    birthDate: DateTime.parse(json["birthDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "surName": surName,
    "birthDate": birthDate.toIso8601String(),
  };

  Employee copyWith({
    int? id,
    String? name,
    String? surName,
    DateTime? birthDate,
  }) =>
      Employee(
        id: id ?? this.id,
        name: name ?? this.name,
        surName: surName ?? this.surName,
        birthDate: birthDate ?? this.birthDate,
      );
}
