import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class Myproduct extends StatefulWidget {
  const Myproduct({super.key});

  @override
  State<Myproduct> createState() => _MyproductState();
}

List productList=[];
class _MyproductState extends State<Myproduct> {

  Future getproduct()async{
    try{
      var url=Uri.parse("https://fakestoreapi.com/products");
      var response=await http.get(
        url,
      );
        productList=jsonDecode(response.body);
        log("$productList");
    }catch(e){
      log("$e");
    }
  }

  @override
  void initState(){
    super.initState();
    getproduct();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text("Products",style: TextStyle(color: Colors.white),),
      ),
      body: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context,index){
        return Container(
          padding:const  EdgeInsets.all(8),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: Colors.white,
            borderRadius:BorderRadius.circular(10) 
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.network(productList[index]['image'],fit: BoxFit.fill,)),
              ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Title: ",style: TextStyle(fontSize: 20),),
                        Expanded(child: Text("${productList[index]['title']}")),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Category: ",
                            style: TextStyle(fontSize: 20),
                          ),
                        Text("${productList[index]['category']}"),
                      ],
                    ),
                      Row(
                        children: [
                          const Text("Price: ",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text("${productList[index]['price']}"),
                        ],
                      ),
                       Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           const Text("Description: ",
                            style: TextStyle(fontSize: 20),
                          ),
                          Expanded(child: Text("${productList[index]['description']}")),
                         ],
                       )
                  ],
                ),
                
            ],
          ),

        );
      }),
    );
  }
}