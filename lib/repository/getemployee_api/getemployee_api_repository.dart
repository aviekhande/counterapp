import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
class GetEmpInfo{
  List empList = [];
   Future getempdata() async {
    try {
      var url = Uri.parse("https://dummy.restapiexample.com/api/v1/employees");
      var response = await http.get(url);
      var empList1 = await (jsonDecode(response.body));
      empList = empList1['data'];
      print("$empList");
    } catch (e) {
      log("$e");
    }
  }
}