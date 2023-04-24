class EmployeeDetails {
  EmployeeDetails({
    required this.id,
    required this.job,
    required this.gender,
    required this.adressStreet,
    required this.adressStreetNumber,
    this.adressPlz,
  });

  int id;
  String job;
  int? gender;
  String adressStreet;
  String adressStreetNumber;
  int? adressPlz;

  factory EmployeeDetails.fromJson(Map<String, dynamic> json) {
    return EmployeeDetails(
      id: json["id"],
      job: json["job"],
      gender: json["gender"],
      adressStreet: json["adressStreet"],
      adressStreetNumber: json["adressStreetNumber"],
      adressPlz: json["adressPlz"] == null ? null : int.parse(json["adressPlz"]),
    );
  }

  factory EmployeeDetails.fromJsonFile(Map<String, dynamic> json) {
    int? genderToDb;
    if(json["gender"] != null) {
      genderToDb = json["gender"].toString().startsWith('m') == true ? 1 : 2;
    }
   return EmployeeDetails(
        id: json["id"],
        job: json["job"] ?? '',
        gender: genderToDb,
        adressStreet: json["adressStreet"] ?? '',
        adressStreetNumber: json["adressStreetNumber"].toString(),
        adressPlz: json["adressPlz"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "job": job,
        "gender": gender,
        "adressStreet": adressStreet,
        "adressStreetNumber": adressStreetNumber,
        "adressPlz": adressPlz,
      };

  EmployeeDetails copyWith({
    int? id,
    String? job,
    int? gender,
    String? adressStreet,
    String? adressStreetNumber,
    int? adressPlz,
  }) =>
      EmployeeDetails(
        id: id ?? this.id,
        job: job ?? this.job,
        gender: gender ?? this.gender,
        adressStreet: adressStreet ?? this.adressStreet,
        adressStreetNumber: adressStreetNumber ?? this.adressStreetNumber,
        adressPlz: adressPlz ?? this.adressPlz,
      );
}
