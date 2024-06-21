
import 'dart:convert';
import 'dart:developer';
import 'package:counterapp/repository/getemployee_api/getemployee_api_repository.dart';
import 'package:http/http.dart' as http;
import 'package:counterapp/view/employeeinfo/widget/container_listview.dart';
import 'package:flutter/material.dart';

class EmployeeInfo extends StatefulWidget {
  const EmployeeInfo({super.key});

  @override
  State<EmployeeInfo> createState() => _EmployeeInfoState();
}

List empList = [];

class _EmployeeInfoState extends State<EmployeeInfo> {
  
  List empList = [];
  Future getproduct() async {
    try {
      var url = Uri.parse("https://dummy.restapiexample.com/api/v1/employees");
      var response = await http.get(url);
      var empList1 = await (jsonDecode(response.body));
      empList=empList1['data'];
      print("$empList");
      setState(() { 
      });
    } catch (e) {
      log("$e");
    }
  }
  @override
  void initState() {
    super.initState();
    GetEmpInfo().getempdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text(
          "Employees",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: GetEmpInfo().empList.isEmpty? const Center(child: CircularProgressIndicator()) : ListView.builder(
          itemCount: empList.length,
          itemBuilder: (context, index) {
            return MycontainerState(empData: empList[index],);
          }),
    );
  }
}
