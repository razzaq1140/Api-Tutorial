import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/last_example.dart';

class LastsExample extends StatefulWidget {
  const LastsExample({super.key});

  @override
  State<LastsExample> createState() => _LastsExampleState();
}

class _LastsExampleState extends State<LastsExample> {
  Future<LastExample> getApi() async {
    final response =
        await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return LastExample.fromJson(data);
    } else {
      return LastExample.fromJson(data);
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
              future: getApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CupertinoActivityIndicator(),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        subtitle: Text(snapshot.data!.data[index].email.toString()),
                        title: Text(snapshot.data!.data[index].firstName.toString()),
                        leading: CircleAvatar(backgroundImage: NetworkImage(snapshot.data!.data[index].avatar.toString()),),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
