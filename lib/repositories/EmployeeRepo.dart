import 'package:empower_employees/database/DataBaseHelper.dart';

class EmployeeRepo {
  DatabaseHelper dbHelper = DatabaseHelper();

  //login based on mobile number
  Future<List<Map<String, dynamic>>> loginEmployee(
      {required String mobileNumber}) async {
    return await dbHelper.querySingleRow(mobileNumber: mobileNumber);
  }

  //filterRecords
  Future<List<Map<String, dynamic>>> filerEmployeesRecords(
      {required String mobileNumber}) async {
    return await dbHelper.querySingleRow(mobileNumber: mobileNumber);
  }

  //Insert into local DB
  Future<int> insertEmployee(
      {required Map<String, dynamic> employeInfo}) async {
    return await dbHelper.insert(employeInfo);
  }

  //Fetch all rows from local DB
  Future<List<Map<String, dynamic>>> fetchEmployee() async {
    return await dbHelper.queryAllRows();
  }

  //Fetch all rows from local DB
  Future<List<Map<String, dynamic>>> fetchFilterEmployee(
      {required Map filterMap}) async {
    return await dbHelper.filterRecords(filterMap: filterMap);
  }

  //Delete Specific record based on MObile Number
  Future<int> deleteEmployee({required String mobileNumber}) async {
    return await dbHelper.deleteRecord(mobileNumber: mobileNumber);
  }
}
