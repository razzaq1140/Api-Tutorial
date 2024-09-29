import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Models/post_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<PostModel> postList = [];

  Future<List<PostModel>> getApi() async {
    final respone =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(respone.body.toString());
    if (respone.statusCode == 200) {
      for (Map i in data) {
        postList.add(PostModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api Application'),
        centerTitle: true,
      ),
      body:  Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getApi(),
              builder: (context, snapshot) {
                if(!snapshot.hasData)
                  {
                    return Center(child: CircularProgressIndicator() ,);
                  }
                else{
                  return  ListView.builder(
                    itemCount: postList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Title',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                              Text(postList[index].title.toString()),
                              SizedBox(height: 5,),
                              Text('Description',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                              SizedBox(height: 5,),
                              Text(postList[index].body),
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
