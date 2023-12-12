import 'dart:developer';

import 'package:empower_employees/view_models/EmployeeViewModel.dart';
import 'package:empower_employees/views/LoginPage.dart';
import 'package:empower_employees/views/RegisterEmployeePage.dart';
import 'package:empower_employees/views/WeatherTab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  EmployeeViewModel employeeController = Get.put(EmployeeViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text("Empower Employee"),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
              onPressed: () {
                Get.offAll(const LoginPage());
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const RegisterEmployeePage()));
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
          child: Obx(
        () => Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Expanded(
                  flex: 1, child: Card(elevation: 10.0, child: WeatherTab())),
              const SizedBox(
                height: 10,
              ),
              IconButton(
                onPressed: () {
                  showFilterTab();
                },
                icon: const FaIcon(
                  FontAwesomeIcons.filter,
                ),
              ),
              Expanded(
                  flex: 3,
                  child: employeeController.lsitOfEmp.isNotEmpty
                      ? ListView.builder(
                          itemCount: employeeController.lsitOfEmp.length,
                          itemBuilder: ((context, index) {
                            return Card(
                              elevation: 5.0,
                              child: Slidable(
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        employeeController.deleteEmployee(
                                            mobileNumber: employeeController
                                                .lsitOfEmp[index]
                                                .mobileNumber!);
                                      },
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  leading: const CircleAvatar(
                                      backgroundColor: Colors.redAccent,
                                      child: Icon(
                                        Icons.account_box,
                                        color: Colors.white,
                                      )),
                                  trailing: const Icon(
                                    Icons.arrow_right,
                                  ),
                                  onTap: () {
                                    Get.to(RegisterEmployeePage(
                                      employeeDetials:
                                          employeeController.lsitOfEmp[index],
                                    ));
                                  },
                                  title: Text(employeeController
                                      .lsitOfEmp[index].name!),
                                  subtitle: Text(
                                      "${employeeController.lsitOfEmp[index].designation!} | ${employeeController.lsitOfEmp[index].mobileNumber!}"),
                                ),
                              ),
                            );
                          }))
                      : const Center(child: Text("No Employees Found")))
            ],
          ),
        ),
      )),
    );
  }

//Show filter Tab-----
  showFilterTab() {
    log(employeeController.filterMap.value.toString());
    TextEditingController name = TextEditingController(
        text: employeeController.filterMap.value['name'] ?? "");
    TextEditingController mobileNumber = TextEditingController(
        text: employeeController.filterMap.value['mobileNumber'] ?? "");

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 100,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Filter Records',
                        style: TextStyle(fontSize: 18),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Divider(),
                      ),
                      TextFormField(
                        controller: name,
                        onChanged: (value) {
                          // employeeInfo.name = value;
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
                        controller: mobileNumber,
                        onChanged: (value) {
                          // employeeInfo.name = value;
                        },
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'MobileNumber',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.black),
                            onPressed: () {
                              employeeController.filterMap({});
                              Get.back();
                              employeeController.fetchAllEmployee();
                            },
                            child: const Text("Clear"))),
                    Expanded(
                        child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white),
                            onPressed: () {
                              Map data = {
                                "name": name.text,
                                "mobileNumber": mobileNumber.text
                              };
                              data.removeWhere((key, value) =>
                                  (value == null || value.toString().isEmpty));

                              employeeController.filterMap(data);
                              Get.back();
                              employeeController.fetchAllFilterEmployee();
                            },
                            child: const Text("Apply")))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
