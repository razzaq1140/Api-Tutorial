import 'dart:convert';

import 'package:api_3/Models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<UserModel> getUserApi = [];

  Future<List<UserModel>> getApi() async {
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200)
      {
       for(Map i in data)
         {
           getUserApi.add(UserModel.fromJson(i));
         }
        return getUserApi;
      }
    else
      {
        return getUserApi;
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Api'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getApi(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData)
                    {
                      return CircularProgressIndicator();
                    }
                  else
                    {
                      return ListView.builder(
                        itemCount: getUserApi.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  ReuseAbleRow(title: 'Name', value: snapshot.data![index].name.toString()),
                                  // ReuseAbleRow(title: 'Name', value: getUserApi[index].toString()),
                                  ReuseAbleRow(title: 'Username', value: snapshot.data![index].username.toString()),
                                  ReuseAbleRow(title: 'Email', value: snapshot.data![index].email.toString()),
                                  ReuseAbleRow(title: "Adress", value: snapshot.data![index].address.city.toString()+"  "+
                                      snapshot.data![index].address.geo.lng.toString()
                                  ),
                                ],
                              ),
                            ),
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


class ReuseAbleRow extends StatelessWidget {
  String title,value;
  ReuseAbleRow({super.key,required this.title,required this.value });

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
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

