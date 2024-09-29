import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ComplexJson extends StatefulWidget {
  const ComplexJson({super.key});

  @override
  State<ComplexJson> createState() => _ComplexJsonState();
}

class _ComplexJsonState extends State<ComplexJson> {

  var data;
  Future<void> getuserApi() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getuserApi(),
              builder: (context,snapshot){
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context,index){
                  return Card(
                    child: Column(
                      children: [

                        ReuseAble(value: 'Name', title: data[index]["name"]),
                        ReuseAble(value: 'Email', title: data[index]["email"]),
                        ReuseAble(value: 'Address', title: data[index]["address"]["geo"]["lng"]),
                      ],
                    ),
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}


class ReuseAble extends StatelessWidget {
  String title,value;
   ReuseAble({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(value),
        Text(title),
        ],
      ),
    );
  }
}
