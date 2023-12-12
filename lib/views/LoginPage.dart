import 'package:empower_employees/repositories/EmployeeRepo.dart';
import 'package:empower_employees/views/HomePage.dart';
import 'package:empower_employees/views/RegisterEmployeePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  EmployeeRepo employeeRepo = EmployeeRepo();

  final TextEditingController _mobileTFC = TextEditingController();
  final TextEditingController _passwordTFC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Log In",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Let's go to work",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Required";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.phone,
                        controller: _mobileTFC,
                        decoration: const InputDecoration(
                          labelText: 'Mobile Number',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Required";
                          } else {
                            return null;
                          }
                        },
                        controller: _passwordTFC,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                foregroundColor: Colors.white),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                employeeRepo
                                    .loginEmployee(
                                        mobileNumber: _mobileTFC.text)
                                    .then((value) {
                                  if (value.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            backgroundColor: Colors.redAccent,
                                            content: Text(
                                                "Mobile Number not Registered! Kindly Register!")));
                                  } else {
                                    Get.off(const HomePage());
                                  }
                                });
                              }
                            },
                            child: const Text(
                              "LOG IN",
                              style: TextStyle(fontSize: 18),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RegisterEmployeePage()));
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(color: Colors.redAccent),
                      ))
                ],
              )
            ])),
      ),
    );
  }
}
