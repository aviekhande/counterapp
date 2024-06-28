import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class GetPosts {
  Map postList = {};
  Future getPostsData() async {
    try {
      var url = Uri.parse('https://dummyjson.com/posts');
      var response = await http.get(url);
      var empList1 = await (jsonDecode(response.body));
      postList = empList1;
      log("$postList");
      return postList;
    } catch (e) {
      log("$e");
    }
  }
}
