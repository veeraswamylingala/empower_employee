import 'dart:core';

class EmployeeModel {
  String? name;
  String? gender;
  String? mobileNumber;
  String? designation;
  String? country;
  String? state;
  String? city;
  String? about;

  EmployeeModel({
    this.name,
    this.gender,
    this.mobileNumber,
    this.designation,
    this.country,
    this.state,
    this.city,
    this.about,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        name: json["name"],
        gender: json["gender"],
        mobileNumber: json["mobileNumber"],
        designation: json["designation"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        about: json["about"],
      );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'gender': gender,
      'mobileNumber': mobileNumber,
      'designation': designation,
      'country': country,
      'state': state,
      'city': city,
      'about': about
    };
  }
}
