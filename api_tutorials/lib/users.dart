import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/users_model.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  
  List<UsersModel> usersList = [];
  Future<List<UsersModel>> getUser() async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      for(Map i in data){
        usersList.add(UsersModel.fromJson(i));
      }
      return usersList;
    }
    else{
      return usersList;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUser(),
              builder: (context,snapshot){
                if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator(),);
                }
                else{
                  return ListView.builder(
                    itemCount: usersList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            ReuseAblerow(title: 'Name', value: usersList[index].name),
                            ReuseAblerow(title: 'Email', value: usersList[index].email),
                            ReuseAblerow(title: 'Address', value: usersList[index].address.geo.lat),
                          ],
                        ),
                      );
                    },);
                }
              },
            ),
          ),

        ],
      ),
    );
  }
}


class ReuseAblerow extends StatelessWidget {
  String title,value;
   ReuseAblerow({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
