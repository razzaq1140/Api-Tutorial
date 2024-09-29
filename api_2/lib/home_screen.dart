import 'dart:convert';

import 'package:api_2/Models/posts_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostsModel> postApi = [];
  Future<List<PostsModel>> getPost() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        postApi.add(PostsModel.fromJson(i));
      }
      return postApi;
    } else {
      return postApi;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api App'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPost(),
              builder: (context, snapshot) {
                if(!snapshot.hasData)
                  {
                    return Text('Loading..');
                  }
                else
                  {
                    return ListView.builder(
                      itemCount: postApi.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(postApi[index].name.toString()),
                                Text(postApi[index].body.toString()),
                              ],
                            ),
                          ),
                        );
                      },

                    );
                  }
              },
            ),
          )
        ],
      ),
    );
  }
}
