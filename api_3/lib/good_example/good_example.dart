import 'dart:convert';

import 'package:api_3/good_example/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main(){
  runApp(ApiData());
}

class ApiData extends StatefulWidget {
  const ApiData({super.key});

  @override
  State<ApiData> createState() => _ApiDataState();
}

class _ApiDataState extends State<ApiData> {
  int a = 1;
  MovieModel? movieModel;
  Future<MovieModel> fetchApiData() async{
    final response = await http.get(Uri.parse("https://www.episodate.com/api/most-popular?page=$a"));
    if(response.statusCode == 200){
      return MovieModel.fromJson(jsonDecode(response.body.toString()));
    }else{
      throw Exception('Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Expanded(child: FutureBuilder(
              future: fetchApiData(),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);
                }else{
                  var movie = snapshot.data!.tvShows;
                  return ListView.builder(
                      itemCount: movie!.length,
                      itemBuilder: (context, index){
                        return Card(
                          child: Column(
                            children: [
                              Image.network(movie[index].imageThumbnailPath.toString())
                            ],
                          ),
                        );
                      });
                }
              },
            )),
          ],
        ),
      ),
    );
  }
}
