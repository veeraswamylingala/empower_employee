import 'dart:developer';

import 'package:empower_employees/models/EmployeModel.dart';
import 'package:empower_employees/repositories/EmployeeRepo.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class EmployeeViewModel extends GetxController {
  var lsitOfEmp = <EmployeeModel>[].obs;
  EmployeeRepo employeeRepo = EmployeeRepo();

  RxMap _filterMap = {}.obs;

  RxMap get filterMap => _filterMap;

  set filterMap(RxMap value) {
    _filterMap = value;
  }

  @override
  void onInit() {
    super.onInit();
    fetchAllEmployee();
  }

  //Insert into local DB
  Future insertEmployee(
      {required Map<String, dynamic> employeInformation}) async {
    await employeeRepo.insertEmployee(employeInfo: employeInformation);
    fetchAllEmployee();
  }

  //Fetch all rows from local DB
  Future fetchAllEmployee() async {
    var employee = await employeeRepo.fetchEmployee();
    lsitOfEmp.value = employee.map((e) => EmployeeModel.fromJson(e)).toList();
  }

  //Fetch all rows from local DB
  Future fetchAllFilterEmployee() async {
    log(filterMap.value.toString());
    var employee =
        await employeeRepo.fetchFilterEmployee(filterMap: filterMap.value);
    lsitOfEmp.value = employee.map((e) => EmployeeModel.fromJson(e)).toList();
  }

  //Insert into local DB
  Future deleteEmployee({required String mobileNumber}) async {
    await employeeRepo.deleteEmployee(mobileNumber: mobileNumber);
    fetchAllEmployee();
  }
}
