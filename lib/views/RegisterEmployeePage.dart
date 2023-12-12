import 'dart:developer';

import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:empower_employees/models/EmployeModel.dart';
import 'package:empower_employees/view_models/EmployeeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';

class RegisterEmployeePage extends StatefulWidget {
  final EmployeeModel? employeeDetials;
  const RegisterEmployeePage({super.key, this.employeeDetials});

  @override
  State<RegisterEmployeePage> createState() => _RegisterEmployeePageState();
}

class _RegisterEmployeePageState extends State<RegisterEmployeePage> {
  EmployeeModel employeeInfo = EmployeeModel();
  final TextEditingController _countryTFC = TextEditingController();
  final TextEditingController _stateTFC = TextEditingController();
  final TextEditingController _cityTFC = TextEditingController();
  EmployeeViewModel employeeController = Get.put(EmployeeViewModel());

  @override
  void initState() {
    super.initState();
    if (widget.employeeDetials != null) {
      employeeInfo = widget.employeeDetials!;
      _countryTFC.text = employeeInfo.country!;
      _stateTFC.text = employeeInfo.state!;
      _cityTFC.text = employeeInfo.city!;
    }
    log(employeeInfo.toJson().toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        title: const Text("Register Employee"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  readOnly: widget.employeeDetials != null,
                  initialValue: employeeInfo.name,
                  onChanged: (value) {
                    employeeInfo.name = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  readOnly: widget.employeeDetials != null,
                  initialValue: employeeInfo.mobileNumber,
                  onChanged: (value) {
                    employeeInfo.mobileNumber = value;
                  },
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Mobile Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Gender"),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                          title: const Text('Male'),
                          value: employeeInfo.gender,
                          groupValue: "Male",
                          onChanged: (vaue) {
                            if (widget.employeeDetials == null) {
                              setState(() {
                                employeeInfo.gender = "Male";
                              });
                            }
                          }),
                    ),
                    Expanded(
                      child: RadioListTile(
                          title: const Text('Femaile'),
                          value: employeeInfo.gender,
                          groupValue: "Femaile",
                          onChanged: (vaue) {
                            if (widget.employeeDetials == null) {
                              setState(() {
                                employeeInfo.gender = "Femaile";
                              });
                            }
                          }),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: employeeInfo.designation,
                  readOnly: widget.employeeDetials != null,
                  onChanged: (value) {
                    employeeInfo.designation = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Designatiion',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CountryStateCityPicker(
                    country: _countryTFC,
                    state: _stateTFC,
                    city: _cityTFC,
                    dialogColor: Colors.grey.shade200,
                    textFieldDecoration: const InputDecoration(
                        suffixIcon: Icon(Icons.arrow_drop_down),
                        border: OutlineInputBorder())),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  readOnly: widget.employeeDetials != null,
                  initialValue: employeeInfo.about,
                  onChanged: (value) {
                    employeeInfo.about = value;
                  },
                  maxLines: 3,
                  maxLength: 25,
                  decoration: const InputDecoration(
                    labelText: 'About',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: widget.employeeDetials == null,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white),
                        onPressed: () async {
                          //Check All feilds mandatory ---
                          List<String> requiredFields = [];
                          Map<String, dynamic> data = employeeInfo.toJson();
                          data['country'] = _countryTFC.text;
                          data['state'] = _stateTFC.text;
                          data['city'] = _cityTFC.text;
                          log(data.toString(), name: "Employee Data");
                          data.forEach((key, value) {
                            if (value == null || value.toString().isEmpty) {
                              requiredFields.add(key);
                            }
                          });
                          if (requiredFields.isNotEmpty) {
                            //show required snackbar
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Colors.redAccent,
                                    content:
                                        Text("Required all above fields!")));
                          } else {
                            //Insert into local Db
                            await employeeController
                                .insertEmployee(employeInformation: data)
                                .then((value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text(
                                          "Registered Employee Sucessfully!")));
                              Get.back();
                            });
                          }
                        },
                        child: const Text(
                          "REGISTER",
                          style: TextStyle(fontSize: 18),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
