import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Photo extends StatefulWidget {
  const Photo({super.key});

  @override
  State<Photo> createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {
  List<Photos> photo = [];
  
  Future<List<Photos>> getPhoto() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    final data = jsonDecode(response.body.toString());
    if(response.statusCode == 200) {
        for(Map i in data)
          {
            Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
            photo.add(photos);
          }
        return photo;
      }
    else
      {
        return photo;
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photos'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPhoto(),
                builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
                  return ListView.builder(
                    itemCount: photo.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                          ),
                          // title: Text(photo[index].id.toString()),
                          title: Text('Note id: '+snapshot.data![index].id.toString()),
                          subtitle: Text(snapshot.data![index].title.toString()),
                        );
                      },
                  );
                },
            ),
          )
        ],
      ),
    );
  }
}

class Photos
{
  String title,url;
  int id;
  Photos({required this.title,required this.url,required this.id});
}
