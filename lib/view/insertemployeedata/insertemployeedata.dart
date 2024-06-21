import 'dart:developer';
import 'package:counterapp/view/insertemployeedata/widget/textformfield_inputs.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class InsertEmpData extends StatefulWidget {
  const InsertEmpData({super.key});

  @override
  State<InsertEmpData> createState() => _InsertEmpDataState();
}

List empList = [];

class _InsertEmpDataState extends State<InsertEmpData> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController salaryController = TextEditingController();

  List empList = [];
  Future postEmployeeData(context) async {
    try {
      var url = Uri.parse("https://dummy.restapiexample.com/api/v1/create");
      var response = await http.post(url, body: {
        "name": nameController.text,
        "salary": salaryController.text,
        "age": ageController.text
      });
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Data Insert SuccessFully")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Data Insert Failed")));
      }

      setState(() {});
    } catch (e) {
      log("$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text(
            "InsertEmployeesData",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              height: 500,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  TextFormFieldInputs(
                      textController: nameController, textHint: "Enter Name"),
                  const SizedBox(
                    height: 50,
                  ),
                  TextFormFieldInputs(
                      textController: ageController, textHint: "Enter Age"),
                  const SizedBox(
                    height: 50,
                  ),
                  TextFormFieldInputs(
                      textController: salaryController,
                      textHint: "Enter Salary"),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        postEmployeeData(context);
                      },
                      style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                      child: const Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}
